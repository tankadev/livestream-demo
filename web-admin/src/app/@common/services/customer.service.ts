import { Observable } from 'rxjs';
import { Injectable } from '@angular/core';

import { BaseAPIService } from './base-api.service';
import { API_URL } from 'src/app/@config/api-url.config';
import { CustomerRO } from '../ro/customer.ro';
import { CustomerDTO } from '../dto/customer.dto';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {

  constructor(
    private http: BaseAPIService
  ) { }

  getCustomerList(): Observable<CustomerRO[]> {
    return this.http.get<CustomerRO[]>(`${API_URL.CUSTOMER.CONTROLLER}/`);
  }

  createCustomer(body: CustomerDTO): Observable<CustomerRO>{
    return this.http.post<CustomerRO>(`${API_URL.CUSTOMER.CONTROLLER}/${API_URL.CUSTOMER.CREATE}`, body);
  }
}
