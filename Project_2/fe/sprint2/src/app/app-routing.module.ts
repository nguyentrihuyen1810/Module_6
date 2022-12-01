import {NgModule} from '@angular/core';
import {Routes, RouterModule} from '@angular/router';
import {BookIntroComponent} from './book/book-intro/book-intro.component';
import {BookListComponent} from './book/book-list/book-list.component';
import {BookCartComponent} from './book/book-cart/book-cart.component';
import {BookDetailComponent} from './book/book-detail/book-detail.component';
import {AuthGuard} from './helpers/auth.guard';
import {BothAuthGuard} from './helpers/both-auth.guard';
import {LoginComponent} from './security/login/login.component';
import {BookPromotionComponent} from './book/book-promotion/book-promotion.component';
import {BothAuthCustomerGuard} from './helpers/both-auth-customer.guard';
import {ErrorNotFoundComponent} from './security/error/error-not-found/error-not-found.component';
import {BookPoliticsComponent} from './book/book-politics/book-politics.component';
import {BookChildrenComponent} from './book/book-children/book-children.component';
import {BookForeignComponent} from './book/book-foreign/book-foreign.component';
import {BookVietnamComponent} from './book/book-vietnam/book-vietnam.component';
import {BookComboComponent} from './book/book-combo/book-combo.component';



const routes: Routes = [
  {path: '', component: BookIntroComponent},
  {path: 'cart', component: BookCartComponent, canActivate: [AuthGuard, BothAuthCustomerGuard]},
  {path: 'book/detail/:id', component: BookDetailComponent},
  {path: 'book/list', component: BookListComponent},
  {path: 'book/list/:id', component: BookListComponent},
  {path: 'book/listCombo', component: BookComboComponent},
  {path: 'book/listPromotion', component: BookPromotionComponent},
  {path: 'book/listBookVietNam', component: BookVietnamComponent},
  {path: 'book/listBookForeign', component: BookForeignComponent},
  {path: 'book/listBookChildren', component: BookChildrenComponent},
  {path: 'book/listBookPolitics', component: BookPoliticsComponent},
  {path: 'book/list-promotion', component: BookPromotionComponent},
  {path: 'login', component: LoginComponent},
  {path: 'auth/access-denied', component: ErrorNotFoundComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
