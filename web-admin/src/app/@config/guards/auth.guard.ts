import { Injectable } from '@angular/core';
import { CanActivate, Router } from '@angular/router';

import { AuthService } from 'src/app/auth/auth.service';
import { NAVIGATION } from './../navigation.config';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {  }

  canActivate(): boolean {
    if (this.authService.isLoggedIn) {
      return true;
    }

    this.router.navigate([NAVIGATION.AUTH]);
    return false;
  }

  canActivateChild(): boolean {
    return this.canActivate();
  }
}
