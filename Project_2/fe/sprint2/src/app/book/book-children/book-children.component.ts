import { Component, OnInit } from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {BookService} from '../../service/book.service';

@Component({
  selector: 'app-book-children',
  templateUrl: './book-children.component.html',
  styleUrls: ['./book-children.component.css']
})
export class BookChildrenComponent implements OnInit {

  bookList: IBook[] = [];
  accountId: number;
  isLoggedIn = false;

  constructor(private bookService: BookService) { }

  ngOnInit(): void {
    this.getAllBookChildren();
  }

  getAllBookChildren() {
    this.bookService.getAllBookChildren().subscribe((data: IBook[]) => {
      this.bookList = data;
      console.log(this.bookList);
    });
  }

}
