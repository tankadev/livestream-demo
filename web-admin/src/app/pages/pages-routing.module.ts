import { RouterModule, Routes } from '@angular/router';
import { NgModule } from '@angular/core';

import { PagesComponent } from './pages.component';
import { PendingVerifyComponent } from './pending-verify/pending-verify.component';

const routes: Routes = [{
  path: '',
  component: PagesComponent,
  children: [
    {
      path: '',
      redirectTo: 'danh-sach-cho-duyet',
      pathMatch: 'full',
    },
    {
      path: 'danh-sach-cho-duyet',
      component: PendingVerifyComponent,
    },
  ],
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class PagesRoutingModule {
}
