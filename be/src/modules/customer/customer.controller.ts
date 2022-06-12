import { Body, Controller, Get, HttpCode, Param, Post, Put, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CustomerService } from './customer.service';
import { CustomerDTO } from './dto/customer.dto';

@Controller('customer')
@UseGuards(JwtAuthGuard)
export class CustomerController {
    constructor(
        private readonly customerService: CustomerService
    ) {}

    @Get()
    @HttpCode(200)
    getAllCustomer() {
        return this.customerService.getListCustomer();
    }

    @Post('create')
    @HttpCode(201)
    createCustomer(
        @Body() customerInfo: CustomerDTO
    ) {
        return this.customerService.createCustomer(customerInfo);
    }

    @Put('update/:uuid')
    @HttpCode(200)
    updateCustomer(
        @Param('uuid') uuid: string,
        @Body() customerInfo: CustomerDTO
    ) {
        return this.customerService.updateCustomer(uuid, customerInfo);
    }
}
