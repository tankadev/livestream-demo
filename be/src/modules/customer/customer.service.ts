import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';

import { Repository } from 'typeorm';
import * as uuid from 'uuid';

import { CustomerEntity } from './customer.entity';
import { BackendLogger } from '../logger/BackendLogger';
import { CustomerRO } from './ro/customer.ro';
import { CustomerDTO } from './dto/customer.dto';

@Injectable()
export class CustomerService {
    private readonly logger = new BackendLogger(CustomerService.name);

    constructor(
        @InjectRepository(CustomerEntity)
        private readonly customerRepo: Repository<CustomerEntity>
    ) { }

    async getListCustomer(): Promise<CustomerRO[]> {
        try {
            return await this.customerRepo.find();
        } catch(error) {
            this.logger.error(`getListCustomer: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async createCustomer(customerDTO: CustomerDTO): Promise<CustomerRO> {
        try {
            const customer = await this.customerRepo.findOne({ where: { phoneNumber: customerDTO.phoneNumber } })
            if (customer) {
                throw 'CUSTOMER.PHONE_ALREADY_EXIST';
            }

            const newCustomer = this.customerRepo.create(
                {
                    uuid: uuid.v4().replace(/-/g, ''),
                    name: customerDTO.name,
                    phoneNumber: customerDTO.phoneNumber,
                    insertDate: (new Date()).toISOString(),
                    updateDate: null
                }
            );

            return await this.customerRepo.save(newCustomer);
        } catch (error) {
            if (error === 'CUSTOMER.PHONE_ALREADY_EXIST') {
                throw new HttpException(error, HttpStatus.BAD_REQUEST);
            }
            this.logger.error(`createCustomer: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async updateCustomer(uuid: string, customerInfo: CustomerDTO): Promise<CustomerRO> {
        try {
            const customer = await this.customerRepo.findOne({ where: { phoneNumber: customerInfo.phoneNumber } })
            if (customer && customer.uuid !== uuid) {
                throw 'CUSTOMER.PHONE_ALREADY_EXIST';
            }

            const customerEntity = {
                name: customerInfo.name,
                phoneNumber: customerInfo.phoneNumber,
                updateDate: (new Date()).toISOString()
            }
            await this.customerRepo.update(uuid, customerEntity);

            return {
                uuid: uuid,
                name: customerInfo.name,
                phoneNumber: customerInfo.phoneNumber,
                insertDate: null,
                updateDate: customerEntity.updateDate
            }
        } catch(error) {
            if (error === 'CUSTOMER.PHONE_ALREADY_EXIST') {
                throw new HttpException(error, HttpStatus.BAD_REQUEST);
            }
            this.logger.error(`updateCustomer: ${error}`);
            throw new HttpException('INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR); 
        }
    }

}
