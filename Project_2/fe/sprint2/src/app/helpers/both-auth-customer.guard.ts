import {Injectable} from '@angular/core';
import {CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, UrlTree, Router} from '@angular/router';
import {Observable} from 'rxjs';
import {TokenStorageService} from '../service/security/token-storage.service';

@Injectable({
  providedIn: 'root'
})
export class BothAuthCustomerGuard implements CanActivate {
  constructor(private tokenStorageService: TokenStorageService, private router: Router) {
  }

  canActivate(
    next: ActivatedRouteSnapshot): boolean {
    const token = this.tokenStorageService.getToken();

    if (token == null) {
      this.router.navigateByUrl('/login');
      return false;
    } else if (!token || (this.tokenStorageService.getUser().account.roles[0].roleId !== 1
      && this.tokenStorageService.getUser().account.roles[0].roleId !== 2)) {
      this.router.navigateByUrl('/auth/access-denied');
      return false;
    }  else {
      return true;
    }
  }

  isRole() {
    const tokenPayload = this.tokenStorageService.getUser().account.roles[0].roleName;
    for (const role of tokenPayload) {
      if (role === 'ROLE_ADMIN' || role === 'ROLE_ACCOUNTANT') {
        return true;
      }
    }
    return false;
  }
}
