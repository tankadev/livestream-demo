export class OrderDTO {
  orderDate: string;
  customerUuid: string;
  expectedDeliveryDate?: string;
  expectedPrice?: number;
  note?: string;
  imageFile?: File;
}
