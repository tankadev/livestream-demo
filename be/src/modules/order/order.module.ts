import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm'

import { OrderController } from './order.controller';
import { OrderService } from './order.service';
import { OrderEntity } from './order.entity';
import { AWSService } from 'src/shared/services/aws.service';

@Module({
  imports: [TypeOrmModule.forFeature([OrderEntity])],
  controllers: [OrderController],
  providers: [OrderService, AWSService],
  exports: [
    OrderService,
    TypeOrmModule
  ]
})
export class OrderModule {}
