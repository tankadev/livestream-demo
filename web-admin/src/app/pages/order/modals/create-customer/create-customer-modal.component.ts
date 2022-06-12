import { finalize } from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { NzModalRef } from 'ng-zorro-antd/modal';
import { NgxSpinnerService } from 'ngx-spinner';

import { FormHelper } from 'src/app/@common/helpers/form.helper';
import { CustomerService } from 'src/app/@common/services/customer.service';

@Component({
  selector: 'app-create-customer-modal',
  templateUrl: './create-customer-modal.component.html',
  styleUrls: ['./create-customer-modal.component.scss']
})
export class CreateCustomerModalComponent implements OnInit {

  createCustomerForm: FormGroup;

  constructor(
    private fb: FormBuilder,
    private modal: NzModalRef,
    private spinner: NgxSpinnerService,
    private customerService: CustomerService
  ) { }

  ngOnInit(): void {
    this.initForm();
  }

  public submitCreateCustomer(): void {
    if (this.createCustomerForm.valid) {
      this.spinner.show();
      this.customerService.createCustomer(this.createCustomerForm.value).pipe(
        finalize(() => this.spinner.hide())
      ).subscribe(
        (resCustomerInfo) => {
          this.modal.destroy({ newCustomerInfo: resCustomerInfo });
        }
      );
    } else {
      FormHelper.validateAllFormFields(this.createCustomerForm);
    }
  }

  public onCancelClick(): void {
    this.modal.destroy();
  }

  private initForm(): void {
    this.createCustomerForm = this.fb.group({
      name: ['', [Validators.required]],
      phoneNumber: ['', [Validators.required, FormHelper.phone]]
    });
  }

}
