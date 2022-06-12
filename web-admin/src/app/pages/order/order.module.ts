import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule } from '@angular/forms';

import { TranslateModule } from '@ngx-translate/core';

import { OrderComponent } from './order.component';
import { PendingOrderComponent } from './pending/pending-order.component';
import { SuccessOrderComponent } from './success/success-order.component';
import { OrderRoutingModule } from './order-routing.module';
import { CreateOrderComponent } from './create-order/create-order.component';
import { ShareModule } from 'src/app/@share/share.module';
import { CreateCustomerModalComponent } from './modals/create-customer/create-customer-modal.component';
import { DisplayOrderStatusPipe } from './pipes/display-order-status.pipe';

@NgModule({
  declarations: [OrderComponent, PendingOrderComponent, SuccessOrderComponent, CreateOrderComponent, CreateCustomerModalComponent, DisplayOrderStatusPipe],
  imports: [
    CommonModule,
    OrderRoutingModule,
    TranslateModule,
    ReactiveFormsModule,
    ShareModule
  ]
})
export class OrderModule { }
