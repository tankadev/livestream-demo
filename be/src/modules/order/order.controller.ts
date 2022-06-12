import { Body, Controller, Get, HttpCode, Param, Post, Put, UploadedFile, UseGuards, UseInterceptors } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { OrderStatusEnum } from '../auth/enums/order-status.enum';

import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { OrderDTO } from './dto/order.dto';
import { OrderService } from './order.service';

@Controller('order')
@UseGuards(JwtAuthGuard)
export class OrderController {
    constructor(
        private readonly orderService: OrderService
    ) {}

    @Get('list-success')
    @HttpCode(200)
    getListOrder() {
        return this.orderService.getAllSuccessOrder();
    }

    @Get('list-pending')
    @HttpCode(200)
    getListPendingOrder() {
        return this.orderService.getAllPendingOrder();
    }

    @Get('detail-by-qrcode/:uuid')
    @HttpCode(200)
    getOrderDetailById(
        @Param('uuid') uuid: string,
    ) {
        return this.orderService.getDetailOrderById(uuid);
    }

    @Get('detail-by-phone/:phone')
    @HttpCode(200)
    getOrderDetailByPhone(
        @Param('phone') phone: string,
    ) {
        return this.orderService.getDetailOrderByPhone(phone);
    }

    @Post('create')
    @HttpCode(201)
    @UseInterceptors(FileInterceptor('imageFile'))
    createOrder(
        @Body() orderInfo: OrderDTO,
        @UploadedFile() imageFile: Express.Multer.File
    ) {
        return this.orderService.createOrder(orderInfo, imageFile);
    }

    @Put('update/:uuid')
    @HttpCode(200)
    @UseInterceptors(FileInterceptor('imageFile'))
    updateOrder(
        @Param('uuid') uuid: string,
        @Body() orderInfo: OrderDTO,
        @UploadedFile() imageFile: Express.Multer.File
    ) {
        return this.orderService.updateOrder(uuid, orderInfo, imageFile);
    }

    @Put('complete/:uuid')
    @HttpCode(200)
    completeOrder(
        @Param('uuid') uuid: string,
        @Body() orderInfo: {price: number}
    ) {
        return this.orderService.completeOrder(uuid, orderInfo);
    }

    @Put('inprogress/:uuid')
    @HttpCode(200)
    inprogressOrder(
        @Param('uuid') uuid: string
    ) {
        return this.orderService.updateStatus(uuid, OrderStatusEnum.INPROGRESS);
    }

    @Put('delivery/:uuid')
    @HttpCode(200)
    deliveryOrder(
        @Param('uuid') uuid: string,
        @Body() orderInfo: {deliveryDate: string}
    ) {
        return this.orderService.deliveryOrder(uuid, orderInfo);
    }

    @Put('cancel/:uuid')
    @HttpCode(200)
    cancelOrder(
        @Param('uuid') uuid: string
    ) {
        return this.orderService.updateStatus(uuid, OrderStatusEnum.CANCEL);
    }
}
