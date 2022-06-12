import { Router } from '@angular/router';
import { Injectable } from '@angular/core';
import {
    HttpInterceptor, HttpHandler,
    HttpRequest, HttpEvent
} from '@angular/common/http';

import { Observable, BehaviorSubject, Subject } from 'rxjs';
import { filter, take, switchMap, catchError, map } from 'rxjs/operators';
import { AuthService } from 'src/app/auth/auth.service';
import { LOCAL_STORAGE } from '../local-storage.config';


@Injectable()
export class TokenInterceptor implements HttpInterceptor {

    private refreshTokenInProgress = false;
    private refreshTokenSubject: Subject<any> = new BehaviorSubject<any>(null);

    constructor(private authService: AuthService, private router: Router) { }
    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        if (request.url.indexOf('refresh') !== -1) {
          return next.handle(this.injectToken(request));
        }

        const accessExpired = this.authService.isAccessTokenExpired;
        const refreshExpired = this.authService.isRefreshTokenExpired;

        if (accessExpired && refreshExpired) {
            return next.handle(request);
        }
        if (accessExpired && !refreshExpired) {
            if (!this.refreshTokenInProgress) {
                this.refreshTokenInProgress = true;
                this.refreshTokenSubject.next(null);
                return this.authService.requestAccessToken().pipe(
                    switchMap((authResponse) => {
                        this.authService.saveToken(LOCAL_STORAGE.ACCESS_TOKEN, authResponse.accessToken);
                        this.authService.saveToken(LOCAL_STORAGE.REFRESH_TOKEN, authResponse.refreshToken);
                        localStorage.setItem(LOCAL_STORAGE.EXPIRED_IN, (authResponse.expiresIn ?? 0).toString());
                        this.refreshTokenInProgress = false;
                        this.refreshTokenSubject.next(authResponse.refreshToken);
                        return next.handle(this.injectToken(request));
                    }),
                    catchError((error) => {
                      localStorage.clear();
                      this.router.navigate(['/']);
                      return next.handle(request);
                   })
                );
            } else {
                return this.refreshTokenSubject.pipe(
                    filter(result => result !== null),
                    take(1),
                    switchMap((res) => {
                        return next.handle(this.injectToken(request));
                    })
                );
            }
        }

        if (!accessExpired) {
            return next.handle(this.injectToken(request));
        }

        return next.handle(request);

        // return next.handle(request).pipe(
        //   catchError((error: any, caught: Observable<any>): Observable<any> => {
        //     return error;
        //   })
        // );
    }

    injectToken(request: HttpRequest<any>): HttpRequest<any> {
        const token = this.authService.getToken;
        return request.clone({
            setHeaders: {
                Authorization: `Bearer ${token}`
            }
        });
    }
}
