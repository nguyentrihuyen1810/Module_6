import {Component, OnInit} from '@angular/core';
import {BookService} from '../../service/book.service';
import {IBook} from '../../model/book/IBook';
import {ICategory} from '../../model/book/ICategory';
import {ActivatedRoute, Router} from '@angular/router';
import {FormControl, FormGroup} from '@angular/forms';
import {TokenStorageService} from '../../service/security/token-storage.service';
import {CartService} from '../../service/cart.service';
import {NotifierService} from 'angular-notifier';
import {HeaderComponent} from '../../layout/header/header.component';

@Component({
  selector: 'app-book-list',
  templateUrl: './book-list.component.html',
  styleUrls: ['./book-list.component.css']
})
export class BookListComponent implements OnInit {
  bookList: IBook[] = [];
  bookList2: IBook[] = [];
  formSearch: FormGroup;

  categoryList: ICategory[] = [];

  page = 0;
  size: number;
  totalPages: number;
  totalPageList: number[] = [];
  page2 = 0;
  size2: number;
  totalPages2: number;
  totalPageList2: number[] = [];

  check = 1;

  categoryId: any;

  private roles: string[];
  isLoggedIn = false;
  showAdminBoard = false;
  showCustomer = false;
  userName: string;

  accountId: number;

  constructor(
    private bookService: BookService,
    private activatedRoute: ActivatedRoute,
    private cartService: CartService,
    private notification: NotifierService,
    private tokenStorageService: TokenStorageService,
    private router: Router,
    private headerComponent: HeaderComponent
  ) {
  }

  ngOnInit(): void {
    this.formSearch = new FormGroup({
      nameSearch: new FormControl(null)
    });

    this.findAllBookList(0);
    this.findAllBookList2(0);
    this.findAllCategory();
    if (!localStorage.getItem('foo')) {
      localStorage.setItem('foo', 'no reload');
      location.reload();
    } else {
      localStorage.removeItem('foo');
    }

    this.activatedRoute.paramMap.subscribe((param) => {
      this.categoryId = param.get('id');
      this.findAllBookListCategory(0, this.categoryId);
    }, () => {
    }, () => {
    });

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

  // ========list======
  findAllBookList(page: number, categoryId?: any) {
    if (categoryId === undefined) {
      this.categoryId = '';
    } else {
      this.categoryId = categoryId;
    }
    this.page = page;
    this.bookService.findAllBookListCategory(this.page, this.formSearch.get('nameSearch').value, this.categoryId).subscribe((data: any) => {
      this.bookList = data.content;
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

  findAllBookList2(page: number, categoryId?: any) {
    if (categoryId === undefined) {
      this.categoryId = '';
    } else {
      this.categoryId = categoryId;
    }
    this.page2 = page;
    // tslint:disable-next-line:max-line-length
    this.bookService.findAllBookListCategory2(this.page2, this.formSearch.get('nameSearch').value, this.categoryId).subscribe((data: any) => {
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

  findAllBookListCategory(page: number, categoryId?: any) {
    if (categoryId === undefined) {
      this.categoryId = '';
    } else {
      this.categoryId = categoryId;
    }
    this.bookService.findAllBookListCategory(page, this.formSearch.get('nameSearch').value, this.categoryId).subscribe((data: any) => {
      this.bookList = data.content;
      this.totalPages = data.totalPages;
      this.size = data.size;

      this.totalPageList = [];
      for (let i = 0; i < this.totalPages; i++) {
        this.totalPageList.push(i);
      }

      this.bookList2 = data.content;
      this.totalPages2 = data.totalPages;
      this.size2 = data.size;

      this.totalPageList2 = [];
      for (let i = 0; i < this.totalPages2; i++) {
        this.totalPageList2.push(i);
      }
    }, () => {
      // this.page--;
      // this.findAllBookListCategory(this.page, this.categoryId);
    }, () => {
    });
  }

  searchBook() {
    this.findAllBookList(0);
    this.findAllBookList2(0);
  }
}
