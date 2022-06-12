import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';

import { Observable } from 'rxjs';

import { environment } from '../../../environments/environment';
import { catchError, map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class BaseAPIService {

  baseUrl: string = environment.BE_URL;
  headers = new HttpHeaders({
    'Content-Type': 'application/json; charset=utf-8'
  });

  constructor(public http: HttpClient) { }

  get<T>(url: string, headers?: HttpHeaders): Observable<T> {

    return this.http.get<T>(`${this.baseUrl}/${url}`, {
      headers:  headers ?? this.headers
    });
  }

  post<T>(url: string, body?: object, headers?: HttpHeaders): Observable<T> {
    return this.http.post<T>(`${this.baseUrl}/${url}`, body ?? {}, {
      headers:  headers ?? this.headers
    });
  }

  put<T>(url: string, body?: object, headers?: HttpHeaders): Observable<T> {
    return this.http.put<T>(`${this.baseUrl}/${url}`, body ?? {}, {
      headers:  headers ?? this.headers
    });
  }

  postFormData<T>(url: string, body: object): Observable<T> {
    const formData = new FormData();
    for (const [key, value] of Object.entries(body)) {
      if (value) {
        formData.append(key, value);
      }
    }
    return this.http.post<T>(`${this.baseUrl}/${url}`, formData, {
      headers:  new HttpHeaders()
    });
  }

  putFormData<T>(url: string, body: object): Observable<T> {
    const formData = new FormData();
    for (const [key, value] of Object.entries(body)) {
      if (value) {
        formData.append(key, value);
      }
    }
    return this.http.put<T>(`${this.baseUrl}/${url}`, formData, {
      headers:  new HttpHeaders()
    });
  }

  delete<T>(url: string): Observable<T> {
    return this.http.delete<T>(`${this.baseUrl}/${url}`);
  }

  buildFormData(formData: FormData, data: any, parentKey?: any): void {
    if (data && typeof data === 'object' && !(data instanceof Date) && !(data instanceof File)) {
      Object.keys(data).forEach(key => {
        this.buildFormData(formData, data[key], parentKey ? `${parentKey}[${key}]` : key);
      });
    } else {
      const value = data == null ? '' : data;

      formData.append(parentKey, value);
    }
  }
}
