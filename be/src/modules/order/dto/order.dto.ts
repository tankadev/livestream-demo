export class OrderDTO {
    orderDate: string;
    status: number;
    customerUuid: string;
    expectedDeliveryDate?: string;
    deliveryDate?: string;
    expectedPrice?: number;
    price?: number;
    note?: string;
}
