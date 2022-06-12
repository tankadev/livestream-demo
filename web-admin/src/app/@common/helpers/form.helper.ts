import { ElementRef } from '@angular/core';
import { AbstractControl, FormControl, FormGroup } from '@angular/forms';

export class FormHelper {

  public static isFieldValid(formGroup: FormGroup, field: string): boolean {
    return !formGroup.get(field).valid && formGroup.get(field).touched;
  }

  public static validateAllFormFields(formGroup: FormGroup): void {
    Object.values(formGroup.controls).forEach(control => {
      if (control.invalid) {
        control.markAsDirty();
        control.updateValueAndValidity({ onlySelf: true });
      }
    });
  }

  public static phone(control: AbstractControl): any {
    const value = control.value;

    if (value == null || value.length === 0) {
      return {};
    }

    return typeof value === 'string' && /(^0\d{9}$)/.test(value)
      ? {}
      : { phoneError: true };
  }

}
