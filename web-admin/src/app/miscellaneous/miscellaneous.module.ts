import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';

import { NzResultModule } from 'ng-zorro-antd/result';
import { NzButtonModule } from 'ng-zorro-antd/button';

import { MiscellaneousRoutingModule } from './miscellaneous-routing.module';
import { MiscellaneousComponent } from './miscellaneous.component';
import { NotFoundComponent } from './not-found/not-found.component';
import { InternalServerErrorComponent } from './internal-server-error/internal-server-error.component';

@NgModule({
  imports: [
    CommonModule,
    RouterModule,
    MiscellaneousRoutingModule,
    RouterModule,
    NzResultModule,
    NzButtonModule
  ],
  declarations: [
    MiscellaneousComponent,
    NotFoundComponent,
    InternalServerErrorComponent,
  ],
})
export class MiscellaneousModule { }
