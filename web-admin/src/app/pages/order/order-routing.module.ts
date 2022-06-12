import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';

import { OrderComponent } from './order.component';
import { PendingOrderComponent } from './pending/pending-order.component';
import { SuccessOrderComponent } from './success/success-order.component';
import { CreateOrderComponent } from './create-order/create-order.component';

const routes: Routes = [{
  path: '',
  component: OrderComponent,
  children: [
    {
      path: '',
      redirectTo: 'dang-cho'
    },
    {
      path: 'dang-cho',
      component: PendingOrderComponent
    },
    {
      path: 'hoan-thanh',
      component: SuccessOrderComponent
    },
    {
      path: 'tao-don-hang',
      component: CreateOrderComponent
    }
  ]
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class OrderRoutingModule {}
