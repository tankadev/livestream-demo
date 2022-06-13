import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

import { Observable } from 'rxjs';
import { map, finalize } from 'rxjs/operators';

import { JwtHelperService } from '@auth0/angular-jwt';

import { LoginRO } from './ro/fb-login.ro';
import { BaseAPIService } from '../@common/services/base-api.service';
import { API_URL } from '../@config/api-url.config';
import { NAVIGATION } from '../@config/navigation.config';
import { LOCAL_STORAGE } from '../@config/local-storage.config';
import { LoginLocalDTO } from './dto/login-local.dto';

declare const FB: any;

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(
    private router: Router,
    private http: BaseAPIService,
  ) { }

  login(loginDTO: LoginLocalDTO): Observable<any> {
    return this.http.post<LoginRO>(`${API_URL.AUTH.CONTROLLER}/${API_URL.AUTH.LOGIN}/`, loginDTO).pipe(
      map((res) => {
        this.saveToken(LOCAL_STORAGE.ACCESS_TOKEN, res.accessToken ?? '');
        this.saveToken(LOCAL_STORAGE.REFRESH_TOKEN, res.refreshToken ?? '');
        localStorage.setItem(LOCAL_STORAGE.EXPIRED_IN, (res.expiresIn ?? 0).toString());
        this.router.navigate([NAVIGATION.DASHBOARD]);
      })
    );
  }

  requestAccessToken(): Observable<any> {
    return this.http.post<LoginRO>(`${API_URL.AUTH.CONTROLLER}/${API_URL.AUTH.REFRESH}/?refreshToken=${this.getRefreshToken}`);
  }

  logout(): Observable<any> {
    return this.http.post(
      `${API_URL.AUTH.CONTROLLER}/${API_URL.AUTH.LOGOUT}`
    ).pipe(
      finalize(() => {
        localStorage.clear();
      })
    );
  }

  // Getter
  get isLoggedIn(): boolean {
    const token = localStorage.getItem(LOCAL_STORAGE.ACCESS_TOKEN);
    if (token) {
      return true;
    }
    return false;
  }

  get getToken(): string | null {
    return localStorage.getItem(LOCAL_STORAGE.ACCESS_TOKEN) ?? null;
  }

  get getRefreshToken(): string | null {
    return localStorage.getItem(LOCAL_STORAGE.REFRESH_TOKEN) ?? null;
  }

  get isAccessTokenExpired(): boolean {
    return this.checkTokenExpire(LOCAL_STORAGE.ACCESS_TOKEN);
  }

  get isRefreshTokenExpired(): boolean {
    return this.checkTokenExpire(LOCAL_STORAGE.REFRESH_TOKEN);
  }

  // Method
  public saveToken(tokenName: string, tokenValue: string): void {
    localStorage.setItem(tokenName, tokenValue);
    if (tokenName === LOCAL_STORAGE.ACCESS_TOKEN) {
      const helper = new JwtHelperService();
      const infoBase64 = helper.decodeToken(tokenValue);
      if (infoBase64 && infoBase64.username) {
        localStorage.setItem(LOCAL_STORAGE.USER_NAME, infoBase64.username);
      }
    }
  }

  private checkTokenExpire(tokenName: string): boolean {
    const token = localStorage.getItem(tokenName);
    if (token) {
      const helper = new JwtHelperService();
      const expired = helper.isTokenExpired(token);
      return expired;
    }
    return true;
  }
}
