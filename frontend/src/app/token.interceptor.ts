import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class TokenInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    const token = localStorage.getItem('x-auth-token');

    if (token) {
      const cloned = req.clone({
        headers: req.headers.set('x-auth-token', token)
      });
      return next.handle(cloned);
    }

    return next.handle(req);
  }
}
