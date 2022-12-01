import {Component, OnInit} from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {ICategory} from '../../model/book/ICategory';
import {BookService} from '../../service/book.service';
import {ActivatedRoute} from '@angular/router';
import {TokenStorageService} from '../../service/security/token-storage.service';
import {CartService} from '../../service/cart.service';
import {NotifierService} from 'angular-notifier';
import {HeaderComponent} from '../../layout/header/header.component';

@Component({
  selector: 'app-book-promotion',
  templateUrl: './book-promotion.component.html',
  styleUrls: ['./book-promotion.component.css']
})
export class BookPromotionComponent implements OnInit {
  bookList: IBook[] = [];
  bookList2: IBook[] = [];
  categoryList: ICategory[] = [];

  check = 1;

  page = 0;
  size: number;
  totalPages: number;
  totalPageList: number[] = [];
  page2 = 0;
  size2: number;
  totalPages2: number;
  totalPageList2: number[] = [];

  private roles: string[];
  isLoggedIn = false;
  showAdminBoard = false;
  showCustomer = false;
  userName: string;

  accountId: number;

  constructor(private bookService: BookService,
              private activatedRoute: ActivatedRoute,
              private cartService: CartService,
              private notification: NotifierService,
              private tokenStorageService: TokenStorageService,
              private headerComponent: HeaderComponent) {
  }

  ngOnInit(): void {
    this.findAllBookList(0);
    this.findAllBookList2(0);
    this.findAllCategory();
    // kiểm tra đăng nhập
    this.isLoggedIn = !!this.tokenStorageService.getToken();
    if (this.isLoggedIn) {
      this.userName = this.tokenStorageService.getUser().account.username;
      this.roles = this.tokenStorageService.getUser().account.roles[0].roleName;
      // kiểm tra role
      this.showAdminBoard = this.roles.includes('ROLE_ADMIN');
      this.showCustomer = this.roles.includes('ROLE_CUSTOMER');

      console.log('roles: ' + this.roles);
    }

    this.accountId = this.tokenStorageService.getUser().account.accountId;
  }

  // thêm sách vào giỏ hàng
  addBook(bookAdd: IBook) {
    bookAdd.bookQuantity = 1;
    this.cartService.addBook(this.accountId, bookAdd).subscribe(() => {
    }, (error) => {
      this.notification.notify('error', error.error);
    }, () => {
      this.notification.notify('success', 'Thêm sách vào giỏ hàng thành công');
      this.headerComponent.getQuantityCart();
    });
  }

  // ===list==

  findAllBookList(page: number) {
    this.page = page;
    this.bookService.findAllBookPromotion(this.page).subscribe((data: any) => {
      this.bookList = data.content;
      console.log(this.page);
      this.totalPages = data.totalPages;
      this.size = data.size;

      this.totalPageList = [];
      for (let i = 0; i < this.totalPages; i++) {
        this.totalPageList.push(i);
      }
    }, () => {
      // this.page--;
      // this.findAllBookList(this.page, this.categoryId);
    }, () => {
      this.page2 = 0;
    });
  }

  findAllBookList2(page: number) {
    this.page2 = page;
    this.bookService.findAllBookPromotion2(this.page2).subscribe((data: any) => {
      console.log(data);
      this.bookList2 = data.content;
      this.totalPages2 = data.totalPages;
      this.size2 = data.size;

      this.totalPageList2 = [];
      for (let i = 0; i < this.totalPages2; i++) {
        this.totalPageList2.push(i);
      }
    }, () => {
      // this.page2--;
      // this.findAllBookList2(this.page2, this.categoryId);
    }, () => {
      this.page = 0;
    });
  }

  findAllCategory() {
    this.bookService.findAllCategory().subscribe((data: ICategory[]) => {
      this.categoryList = data;
    });
  }

}
