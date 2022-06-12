import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { getConnection, getRepository, Repository } from 'typeorm';
import * as uuid from 'uuid';
import * as sharp from 'sharp';

import { OrderEntity } from './order.entity';
import { BackendLogger } from '../logger/BackendLogger';
import { OrderRO } from './ro/order.ro';
import { OrderDTO } from './dto/order.dto';
import { AWSService } from 'src/shared/services/aws.service';
import { DotenvService } from '../dotenv/dotenv.service';
import { CustomerEntity } from '../customer/customer.entity';

@Injectable()
export class OrderService {
    private readonly logger = new BackendLogger(OrderService.name);

    constructor(
        @InjectRepository(OrderEntity)
        private readonly orderRepo: Repository<OrderEntity>,
        private readonly awsService: AWSService,
        private readonly dotenvService: DotenvService
    ) { }

    async getAllSuccessOrder(): Promise<OrderRO[]> {
        try {
            let order: OrderEntity[] = [];
            order = await getRepository(OrderEntity)
                .createQueryBuilder('order')
                .leftJoinAndSelect('order.customer', 'customer')
                .where('order.status IN (:...listStatus)', { listStatus: [4, 5] })
                .orderBy({
                    'order.status': 'ASC',
                    'order.orderDate': 'ASC'
                })
                .getMany();
            return this.formatToOrderRO(order);
        } catch(error) {
            this.logger.error(`getAllOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async getAllPendingOrder(): Promise<OrderRO[]> {
        try {
            let order: OrderEntity[] = [];
            order = await getRepository(OrderEntity)
                .createQueryBuilder('order')
                .leftJoinAndSelect('order.customer', 'customer')
                .where('order.status IN (:...listStatus)', { listStatus: [1, 2, 3] })
                .orderBy({
                    'order.status': 'ASC',
                    'order.orderDate': 'ASC'
                })
                .getMany();
            return this.formatToOrderRO(order);
        } catch(error) {
            this.logger.error(`getAllPendingOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async getDetailOrderById(uuid: string): Promise<OrderRO> {
        try {
            const order = await getRepository(OrderEntity)
                .createQueryBuilder('order')
                .leftJoinAndSelect('order.customer', 'customer')
                .where('order.uuid = :uuid', { uuid })
                .getOne();
            if (order) {
                order.imageUrl = order.imageUrl ? `${this.dotenvService.get('S3_URL')}/${order.imageUrl}` : null;
                return order;
            }

            throw 'ORDER.ORDER_DOES_NOT_EXIST';
        } catch(error) {
            if (error === 'ORDER.ORDER_DOES_NOT_EXIST') {
                throw new HttpException(error, HttpStatus.NOT_FOUND);
            }
            this.logger.error(`getDetailOrderById: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async getDetailOrderByPhone(phone: string): Promise<OrderRO[]> {
        try {
            const customer = await getRepository(CustomerEntity)
                .createQueryBuilder('customer')
                .where('customer.phoneNumber = :phone', { phone })
                .getOne();
            if (customer) {
                const orders = await getRepository(OrderEntity)
                .createQueryBuilder('order')
                .leftJoinAndSelect('order.customer', 'customer')
                .where('customer.phoneNumber = :phone', { phone })
                .orderBy({
                    'order.status': 'ASC',
                    'order.orderDate': 'ASC'
                })
                .getMany();

                return this.formatToOrderRO(orders);
            }

            throw 'ORDER.PHONE_NUMBER_DOES_NOT_EXIST';
        } catch(error) {
            if (error === 'ORDER.PHONE_NUMBER_DOES_NOT_EXIST') {
                throw new HttpException(error, HttpStatus.NOT_FOUND);
            }
            this.logger.error(`getDetailOrderByPhone: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async createOrder(orderInfo: OrderDTO, imageFile: Express.Multer.File): Promise<any> {
        const queryRunner = getConnection().createQueryRunner();
        await queryRunner.connect();
        await queryRunner.startTransaction();
        try {
            let url: string = null;
            if (imageFile) {
                const compressImgBuffer = await sharp(imageFile.buffer)
                    .toFormat('jpeg')
                    .jpeg({ mozjpeg: true })
                    .toBuffer();
                url = await this.awsService.uploadFile(
                    compressImgBuffer, `${Date.now().toString()}-${imageFile.originalname}`, 'don-hang'
                );
            }

            const newOrder = this.orderRepo.create({
                uuid: uuid.v4().replace(/-/g, ''),
                status: 1,
                orderDate: orderInfo.orderDate,
                customerUuid: orderInfo.customerUuid,
                note: orderInfo.note,
                expectedDeliveryDate: orderInfo.expectedDeliveryDate,
                expectedPrice: orderInfo.expectedPrice,
                imageUrl: url ? url : null
            });
            await queryRunner.manager.save(newOrder);
            await queryRunner.commitTransaction();
            return { message: 'ORDER.CREATE_ORDER_SUCCESS' };
        } catch (error) {
            await queryRunner.rollbackTransaction();
            this.logger.error(`createOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        } finally {
            await queryRunner.release();
        }
    }

    async updateOrder(orderUuid: string, orderInfo: OrderDTO, imageFile: Express.Multer.File): Promise<any> {
        const queryRunner = getConnection().createQueryRunner();
        await queryRunner.connect();
        await queryRunner.startTransaction();
        try {

            const orderDetail = await this.orderRepo.findOne({ uuid: orderUuid });
            if (orderDetail) {
                let url: string = null;
                if (imageFile) {
                    // Xóa file cũ được lưu trên S3
                    await this.awsService.deleteFile(orderDetail.imageUrl);

                    const compressImgBuffer = await sharp(imageFile.buffer)
                        .toFormat('jpeg')
                        .jpeg({ mozjpeg: true })
                        .toBuffer();
                    url = await this.awsService.uploadFile(
                        compressImgBuffer, `${Date.now().toString()}-${imageFile.originalname}`, 'don-hang'
                    );
                }
                await queryRunner.manager.update(OrderEntity, { uuid: orderUuid }, {
                    note: orderInfo.note ? orderInfo.note : orderDetail.note,
                    expectedDeliveryDate: orderInfo.expectedDeliveryDate ? orderInfo.expectedDeliveryDate : orderDetail.expectedDeliveryDate,
                    expectedPrice: orderInfo.expectedPrice ? orderInfo.expectedPrice : orderDetail.expectedPrice,
                    imageUrl: url ? url : orderDetail.imageUrl
                });
                await queryRunner.commitTransaction();
                return { message: 'ORDER.UPDATE_ORDER_SUCCESS' };
            }

            throw 'ORDER.UUID_DOES_NOT_EXIST';
        } catch (error) {
            await queryRunner.rollbackTransaction();
            if (error === 'ORDER.UUID_DOES_NOT_EXIST') {
                throw new HttpException(error, HttpStatus.NOT_FOUND);
            }
            this.logger.error(`updateOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        } finally {
            await queryRunner.release();
        }
    }

    async completeOrder(orderUuid: string, orderInfo: {price: number}): Promise<any> {
        try {
            await this.orderRepo.update(orderUuid, {
                status: 3,
                price: orderInfo.price
            });
            return { message: 'ORDER.COMPLETED' };
        } catch(error) {
            this.logger.error(`completeOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async deliveryOrder(orderUuid: string, orderInfo: {deliveryDate: string}): Promise<any> {
        try {
            await this.orderRepo.update(orderUuid, {
                status: 4,
                deliveryDate: orderInfo.deliveryDate
            });
            return { message: 'ORDER.DELIVERED' };
        } catch(error) {
            this.logger.error(`deliveryOrder: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async updateStatus(orderUuid: string, newStatus: number): Promise<any> {
        try {
            await this.orderRepo.update(orderUuid, { status: newStatus });
            return { message: 'ORDER.UPDATE_STATUS_SUCCESS' };
        } catch(error) {
            this.logger.error(`updateStatus: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private formatToOrderRO(order: OrderEntity[]): OrderRO[] {
        return order.map(item => {
            item.imageUrl = item.imageUrl ? `${this.dotenvService.get('S3_URL')}/${item.imageUrl}` : null;
            return item;
        });
    }

}
