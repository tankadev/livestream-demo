import { async } from '@angular/core/testing';
import { Component, OnInit } from '@angular/core';

import { TranslateService } from '@ngx-translate/core';
import { environment } from '../environments/environment';
import { getMessaging, getToken, onMessage } from 'firebase/messaging';
import { UserService } from './@common/services/user.service';

@Component({
  selector: 'app-root',
  template: `
    <router-outlet></router-outlet>
    <ngx-spinner></ngx-spinner>
  `
})
export class AppComponent implements OnInit {

  message: any = null;

  constructor(
    public translate: TranslateService,
    public userService: UserService
  ) {
    translate.setDefaultLang('vi');
    translate.use('vi');
  }

  ngOnInit(): void {
    this.requestPermission();
    this.listen();
  }

  requestPermission(): void {
    const messaging = getMessaging();
    getToken(messaging,
      { vapidKey: environment.firebase.vapidKey }).then(
        async (currentToken) => {
          if (currentToken) {
            console.log(currentToken);
            localStorage.setItem('pushToken', currentToken);
          } else {
            console.log('No registration token available. Request permission to generate one.');
          }
        }).catch((err) => {
          console.log('An error occurred while retrieving token. ', err);
        });
  }

  listen(): void {
    const messaging = getMessaging();
    onMessage(messaging, (payload) => {
      console.log('Message received. ', payload);
      this.message = payload;
    });
  }

}
