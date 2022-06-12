import { NgModule } from '@angular/core';
import { Routes, RouterModule, ExtraOptions } from '@angular/router';

import { AuthGuard } from './@config/guards/auth.guard';
import { PublicGuard } from './@config/guards/public.guard';
import { InternalServerErrorComponent } from './miscellaneous/internal-server-error/internal-server-error.component';
import { NotFoundComponent } from './miscellaneous/not-found/not-found.component';

export const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./pages/pages.module').then(m => m.PagesModule),
    canActivate: [AuthGuard]
  },
  {
    path: 'auth',
    loadChildren: () => import('./auth/auth.module').then(m => m.AuthModule),
    canActivate: [PublicGuard]
  },
  { path: '', redirectTo: '', pathMatch: 'full' },
  { path: '500', component: InternalServerErrorComponent },
  { path: '**', component: NotFoundComponent },
];

const config: ExtraOptions = {
  useHash: false,
};
@NgModule({
  imports: [RouterModule.forRoot(routes, config)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
