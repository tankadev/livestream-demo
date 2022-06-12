import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PendingVerifyComponent } from './pending-verify.component';
import { ShareModule } from 'src/app/@share/share.module';

@NgModule({
  declarations: [PendingVerifyComponent],
  imports: [
    CommonModule,
    ShareModule,
  ]
})
export class PendingVerifyModule { }
