import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { Repository } from 'typeorm';
import * as uuid from 'uuid';
import * as admin from 'firebase-admin';

import { NotificationsEntity } from './notifications.entity';
import { BackendLogger } from '../logger/BackendLogger';

@Injectable()
export class NotificationsService {
    private readonly logger = new BackendLogger(NotificationsService.name);

    constructor(
        @InjectRepository(NotificationsEntity)
        private readonly notificationsRepo: Repository<NotificationsEntity>
    ) { }

    async createNotification(userUuid: string, pushToken: string, title: string, content: string): Promise<any> {
        try {
            const newNoti = this.notificationsRepo.create(
                {
                    title: title,
                    content: content,
                    userUuid: userUuid
                }
            );
            newNoti.uuid = uuid.v4().replace(/-/g, '');

            await this.notificationsRepo.save(newNoti);
            if (pushToken) {
                const payload = {
                    notification: {
                      title,
                      body: content,
                      sound : "default"
                    }
                };
                await admin.messaging().sendToDevice([pushToken], payload);
            }
        } catch (error) {
            this.logger.error(`createNotification: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
