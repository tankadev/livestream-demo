import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';

import { finalize } from 'rxjs/operators';

import { NgxSpinnerService } from 'ngx-spinner';

import { LOCAL_STORAGE } from 'src/app/@config/local-storage.config';
import { AuthService } from './../../../auth/auth.service';
import { NAVIGATION } from 'src/app/@config/navigation.config';

@Component({
  selector: 'navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {

  @Input() isCollapsed: boolean = false;

  @Output() isCollapsedChange: EventEmitter<boolean> = new EventEmitter<boolean>();

  userName: string = localStorage.getItem(LOCAL_STORAGE.USER_NAME) ?? '';

  constructor(
    private authService: AuthService,
    private spinner: NgxSpinnerService,
    private router: Router
  ) { }

  ngOnInit(): void {
  }

  public logOut(): void {
    this.spinner.show();
    this.authService.logout().pipe(
      finalize(() => {
        this.spinner.hide();
      })
    ).subscribe(
      () => {
        // window.location.reload();
        this.router.navigate([NAVIGATION.AUTH]);
      }
    );
  }

  public onChangedCollapsed(): void {
    this.isCollapsedChange.emit(!this.isCollapsed);
  }

}
