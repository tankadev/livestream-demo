import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { NzLayoutModule } from 'ng-zorro-antd/layout';

import { PagesRoutingModule } from './pages-routing.module';
import { PagesComponent } from './pages.component';
import { ShareModule } from '../@share/share.module';
import { PendingVerifyModule } from './pending-verify/pending-verify.module';

@NgModule({
  declarations: [ PagesComponent ],
  imports: [
    CommonModule,
    PagesRoutingModule,
    NzLayoutModule,
    ShareModule,
    PendingVerifyModule
  ]
})
export class PagesModule { }
