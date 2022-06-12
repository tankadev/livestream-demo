import { CustomerRO } from './customer.ro';

export class OrderRO {
  uuid: string;
  orderDate: string;
  customerUuid: string;
  expectedDeliveryDate: string;
  expectedPrice: number;
  deliveryDate: string;
  price: number;
  note: string;
  imageUrl: string;
  status: number;
  customer: CustomerRO;
}
