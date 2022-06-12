import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';

import { BaseAPIService } from './base-api.service';
import { API_URL } from 'src/app/@config/api-url.config';
import { OrderRO } from '../ro/order.ro';
import { OrderDTO } from '../dto/order.dto';

@Injectable({
  providedIn: 'root'
})
export class OrderService {

  constructor(
    private http: BaseAPIService
  ) { }

  getOrderList(): Observable<OrderRO[]> {
    return this.http.get<OrderRO[]>(`${API_URL.ORDER.CONTROLLER}/`);
  }

  getPendingOrderList(): Observable<OrderRO[]> {
    return this.http.get<OrderRO[]>(`${API_URL.ORDER.CONTROLLER}/${API_URL.ORDER.LIST_PENDING}/`);
  }

  createOrder(body: OrderDTO): Observable<any>{
    return this.http.postFormData<any>(`${API_URL.ORDER.CONTROLLER}/${API_URL.ORDER.CREATE}`, body);
  }
}
