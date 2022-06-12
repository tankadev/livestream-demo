import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

import { finalize } from 'rxjs/operators';

import { NzModalService } from 'ng-zorro-antd/modal';
import { NzUploadFile } from 'ng-zorro-antd/upload';
import { NzNotificationService } from 'ng-zorro-antd/notification';
import { NgxSpinnerService } from 'ngx-spinner';

import { FormHelper } from 'src/app/@common/helpers/form.helper';
import { CustomerRO } from 'src/app/@common/ro/customer.ro';
import { CustomerService } from 'src/app/@common/services/customer.service';
import { CreateCustomerModalComponent } from '../modals/create-customer/create-customer-modal.component';
import { OrderService } from './../../../@common/services/order.service';
import { OrderDTO } from './../../../@common/dto/order.dto';

@Component({
  selector: 'app-create-order',
  templateUrl: './create-order.component.html',
  styleUrls: ['./create-order.component.scss']
})
export class CreateOrderComponent implements OnInit {

  isFetchDataCustomerList: boolean = false;
  customerList: CustomerRO[] = [];
  createOrderForm!: FormGroup;

  // image variable
  fileList: NzUploadFile[] = [];
  previewImageVisible: boolean = false;
  previewImageSource: string | undefined = '';

  constructor(
    private router: Router,
    private fb: FormBuilder,
    private modal: NzModalService,
    private viewContainerRef: ViewContainerRef,
    private customerService: CustomerService,
    private orderService: OrderService,
    private spinner: NgxSpinnerService,
    private notification: NzNotificationService
  ) { }

  ngOnInit(): void {
    this.initForm();
    this.fetchDataCustomerList();
  }

  public submitCreateOrder(): void {
    if (this.createOrderForm.valid) {
      const { customer, note, expectedDeliveryDate, expectedPrice } = this.createOrderForm.value;
      const orderData: OrderDTO = new OrderDTO();
      orderData.orderDate = new Date().toISOString();
      orderData.customerUuid = customer;
      orderData.note = note ? note : null;
      orderData.expectedDeliveryDate = expectedDeliveryDate ? new Date(expectedDeliveryDate).toISOString() : null;
      orderData.expectedPrice = expectedPrice ? expectedPrice : null;
      orderData.imageFile = this.fileList.length > 0 ? this.fileList[0] as any : null;

      this.spinner.show();
      this.orderService.createOrder(orderData).pipe(
        finalize(() => this.spinner.hide())
      ).subscribe(
        (res) => {
          this.createNotification('success', res.message);
        }, (err) => {
          this.createNotification('error', err.error.message);
        }
      );
    } else {
      FormHelper.validateAllFormFields(this.createOrderForm);
    }
  }

  public onClickCreateCustomer(): void {
    const modal = this.modal.create({
      nzTitle: 'Thêm mới khách hàng',
      nzContent: CreateCustomerModalComponent,
      nzViewContainerRef: this.viewContainerRef,
      nzMaskClosable: false,
      nzFooter: null
    });
    modal.afterClose.subscribe((result: {newCustomerInfo: CustomerRO}) => {
      if (result && result.newCustomerInfo) {
        this.customerList.push(result.newCustomerInfo);
        this.createOrderForm.controls.customer.setValue(result.newCustomerInfo.uuid);
      }
    });
  }

  public onClickFetchDataCustomer(): void {
    this.fetchDataCustomerList();
  }

  public onClickOpenCustomerList(): void {
    this.router.navigate([]).then(result => {  window.open(`/khach-hang`, '_blank'); });
  }

  public beforeUpload = (file: NzUploadFile): boolean => {
    this.fileList = this.fileList.concat(file);
    const myReader = new FileReader();
    myReader.readAsDataURL(file as any);
    myReader.onloadend = (e) => {
      this.previewImageSource = myReader.result as string;
    };
    return false;
  }

  private initForm(): void {
    this.createOrderForm = this.fb.group({
      customer: ['', [Validators.required]],
      note: [],
      expectedDeliveryDate: [],
      expectedPrice: []
    });
  }

  private fetchDataCustomerList(): void {
    this.isFetchDataCustomerList = true;
    this.customerService.getCustomerList().pipe(
      finalize(() => this.isFetchDataCustomerList = false)
    ).subscribe(
      (resCustomerList) => {
        this.customerList = resCustomerList;
      }
    );
  }

  private createNotification(type: string, mgs: string): void {
    let title = '';
    switch (type) {
      case 'success':
        title = 'Thành công';
        break;
      case 'error':
        title = 'Thất bại';
        break;
    }
    this.notification.create(type, title, mgs);
  }

}
