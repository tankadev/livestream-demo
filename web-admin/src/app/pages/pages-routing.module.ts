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
      redirectTo: 'don-hang',
      pathMatch: 'full',
    },
    {
      path: 'don-hang',
      loadChildren: () => import('./order/order.module').then(m => m.OrderModule)
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
