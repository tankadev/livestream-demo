import { NgxSpinnerService } from 'ngx-spinner';
import { Component, OnInit } from '@angular/core';
import { finalize } from 'rxjs/operators';
import { PendingVerifyRO } from 'src/app/@common/ro/pending-verify.ro';
import { UserService } from 'src/app/@common/services/user.service';
import { getMessaging, onMessage } from 'firebase/messaging';

@Component({
  selector: 'app-pending-verify',
  templateUrl: './pending-verify.component.html',
  styleUrls: ['./pending-verify.component.scss']
})
export class PendingVerifyComponent implements OnInit {

  isFetchData: boolean = false;
  pendingList: PendingVerifyRO[] = [];

  constructor(
    private userService: UserService,
    private spinner: NgxSpinnerService,
  ) { }

  ngOnInit(): void {
    this.fetchListOrder();
    this.saveToken();
    this.listen();
  }

  listen(): void {
    const messaging = getMessaging();
    onMessage(messaging, (payload) => {
      console.log('Message received. ', payload);
      this.fetchListOrder();
    });
  }

  private saveToken(): void {
    const token = localStorage.getItem('pushToken');
    this.userService.updatePushToken(token).subscribe(
      (res) => {
      }, () => {
      }
    );
  }

  private fetchListOrder(): void {
    this.isFetchData = true;
    this.userService.getListPendingVerify().subscribe(
      (res) => {
        this.pendingList = res;
        this.isFetchData = false;
      }, () => {
        this.isFetchData = false;
      }
    );
  }

  public onClickReject(id: string): void {
    this.spinner.show();
    this.userService.reject(id).subscribe(
      () => {
        this.fetchListOrder();
        this.spinner.hide();
      }, () => {
        this.spinner.hide();
      }
    );
  }

  public onClickApproved(id: string): void {
    this.spinner.show();
    this.userService.approved(id).subscribe(
      () => {
        this.fetchListOrder();
        this.spinner.hide();
      }, () => {
        this.spinner.hide();
      }
    );
  }

}
