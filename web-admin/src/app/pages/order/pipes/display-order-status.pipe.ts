import { Pipe, PipeTransform } from '@angular/core';

import { OrderStatusEnum } from 'src/app/@common/enums/order-status.enum';

@Pipe({
  name: 'displayOrderStatus'
})
export class DisplayOrderStatusPipe implements PipeTransform {

  transform(status: number): { color: string, text: string } {
    let color: string = '';
    let statusText: string = '';
    switch (status) {
      case OrderStatusEnum.REQUESTED:
        color = 'geekblue';
        statusText = 'Đang gửi yêu cầu';
        break;
      case OrderStatusEnum.PENDING:
        color = 'blue';
        statusText = 'Đang chờ';
        break;
      case OrderStatusEnum.INPROGRESS:
        color = 'cyan';
        statusText = 'Đang làm';
        break;
      case OrderStatusEnum.DONE:
        color = 'green';
        statusText = 'Làm xong';
        break;
      case OrderStatusEnum.DELIVERED:
        color = 'magenta';
        statusText = 'Đã giao';
        break;
      case OrderStatusEnum.CANCEL:
        color = 'red';
        statusText = 'Hủy';
        break;
    }
    return { color, text: statusText };
  }

}
