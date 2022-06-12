import { ModuleWithProviders, NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

import { NzLayoutModule } from 'ng-zorro-antd/layout';
import { NzMenuModule } from 'ng-zorro-antd/menu';
import { NzButtonModule } from 'ng-zorro-antd/button';
import { NzBadgeModule } from 'ng-zorro-antd/badge';
import { NzAvatarModule } from 'ng-zorro-antd/avatar';
import { NzPopoverModule } from 'ng-zorro-antd/popover';
import { NzTableModule } from 'ng-zorro-antd/table';
import { NzDividerModule } from 'ng-zorro-antd/divider';
import { NzPageHeaderModule } from 'ng-zorro-antd/page-header';
import { NzFormModule } from 'ng-zorro-antd/form';
import { NzInputModule } from 'ng-zorro-antd/input';
import { NzDatePickerModule } from 'ng-zorro-antd/date-picker';
import { NzSelectModule } from 'ng-zorro-antd/select';
import { NzUploadModule } from 'ng-zorro-antd/upload';
import { NzToolTipModule } from 'ng-zorro-antd/tooltip';
import { NzModalModule } from 'ng-zorro-antd/modal';
import { NzNotificationModule } from 'ng-zorro-antd/notification';
import { NzTagModule } from 'ng-zorro-antd/tag';

import { FooterComponent } from './components/footer/footer.component';
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { IconsProviderModule } from '../icons-provider.module';
import { SafeHtmlPipe } from './pipes/safe-html.pipe';


const IMPORTS: any[]  = [
  RouterModule,
  NzLayoutModule,
  NzMenuModule,
  NzButtonModule,
  IconsProviderModule,
  NzBadgeModule,
  NzAvatarModule,
  NzPopoverModule,
  NzTableModule,
  NzDividerModule,
  NzPageHeaderModule,
  NzFormModule,
  NzInputModule,
  NzDatePickerModule,
  NzSelectModule,
  NzUploadModule,
  NzToolTipModule,
  NzModalModule,
  NzNotificationModule,
  NzTagModule
];

const COMPONENTS: any[]  = [
  NavbarComponent,
  SidebarComponent,
  FooterComponent
];

const PIPES: any[] = [
  SafeHtmlPipe
];

const DIRECTIVES: any[] = [
  //
];

const PROVIDERS: any[] = [
  //
];

@NgModule({
  imports: [CommonModule, ...IMPORTS],
  exports: [CommonModule, ...COMPONENTS, ...PIPES, ...DIRECTIVES, ...IMPORTS],
  declarations: [...COMPONENTS, ...PIPES, ...DIRECTIVES],
  providers: [...PROVIDERS]
})
export class ShareModule {
  static forRoot(): ModuleWithProviders<ShareModule> {
    return {
      ngModule: ShareModule
    };
  }
}
