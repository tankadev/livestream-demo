import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'

import { CustomerController } from './customer.controller';
import { CustomerService } from './customer.service';
import { CustomerEntity } from './customer.entity';
import { AWSService } from 'src/shared/services/aws.service';

@Module({
  imports: [TypeOrmModule.forFeature([CustomerEntity])],
  controllers: [CustomerController],
  providers: [CustomerService, AWSService],
  exports: [
    CustomerService,
    TypeOrmModule
  ]
})
export class CustomerModule {}
