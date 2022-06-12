import { CustomerRO } from "src/modules/customer/ro/customer.ro";

export class OrderRO {
    uuid: string;
    orderDate: string;
    status: number;
    expectedDeliveryDate: string;
    deliveryDate: string;
    expectedPrice: number;
    price: number;
    note: string;
    imageUrl: string;
    customerUuid: string;
    customer: CustomerRO;
}
