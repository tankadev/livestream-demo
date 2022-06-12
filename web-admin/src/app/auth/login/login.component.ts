import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { NgxSpinnerService } from 'ngx-spinner';

import { AuthService } from './../auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  loginForm!: FormGroup;
  mgsError!: string;

  constructor(
    private authService: AuthService,
    private fb: FormBuilder,
    private spinner: NgxSpinnerService,
    private cdr: ChangeDetectorRef
  ) { }

  public ngOnInit(): void {
    this.loginForm = this.fb.group({
      username: [],
      password: []
    });
  }

  public submitLogin(): void {
    if (this.loginForm.valid) {
      this.spinner.show();
      this.authService.login(this.loginForm.value).subscribe(
        (res) => {
          this.spinner.hide();
        }, (err) => {
          console.log(err);
          this.onShowMessage(err.error.message);
          this.spinner.hide();
        }
      );
    }
  }

  private onShowMessage(mgs: string): void {
    this.mgsError = mgs;
    setTimeout(() => {
      this.mgsError = '';
      this.cdr.detectChanges();
    }, 3000);
  }

}
