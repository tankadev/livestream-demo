import { Component, OnInit } from '@angular/core';

import { finalize } from 'rxjs/operators';

import { OrderRO } from 'src/app/@common/ro/order.ro';
import { OrderService } from './../../../@common/services/order.service';

@Component({
  selector: 'app-pending-order',
  templateUrl: './pending-order.component.html',
  styleUrls: ['./pending-order.component.scss']
})
export class PendingOrderComponent implements OnInit {

  isFetchData: boolean = false;
  pendingOrdersList: OrderRO[] = [];

  constructor(
    private orderService: OrderService
  ) { }

  ngOnInit(): void {
    this.fetchListOrder();
  }

  private fetchListOrder(): void {
    this.isFetchData = true;
    this.orderService.getPendingOrderList()
    .pipe(
      finalize(() => this.isFetchData = false)
    ).subscribe(
      (resOrderList) => {
        this.pendingOrdersList = resOrderList;
      }
    );
  }

}
