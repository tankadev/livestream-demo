import { BaseAPIService } from './base-api.service';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { PendingVerifyRO } from '../ro/pending-verify.ro';
import { API_URL } from 'src/app/@config/api-url.config';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(
    private http: BaseAPIService
  ) { }

  getListPendingVerify(): Observable<PendingVerifyRO[]> {
    return this.http.get<PendingVerifyRO[]>(`${API_URL.USER.CONTROLLER}/${API_URL.USER.PENDING_VERIFY}/`);
  }

  reject(id: string): Observable<any> {
    return this.http.put(`${API_URL.USER.CONTROLLER}/${API_URL.USER.REJECTED}/${id}/`, {});
  }

  approved(id: string): Observable<any> {
    return this.http.put(`${API_URL.USER.CONTROLLER}/${API_URL.USER.APPROVED}/${id}/`, {});
  }
}
