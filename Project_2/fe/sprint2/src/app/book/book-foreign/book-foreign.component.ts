import { Component, OnInit } from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {BookService} from '../../service/book.service';

@Component({
  selector: 'app-book-foreign',
  templateUrl: './book-foreign.component.html',
  styleUrls: ['./book-foreign.component.css']
})
export class BookForeignComponent implements OnInit {

  bookList: IBook[] = [];

  constructor(private bookService: BookService) { }

  ngOnInit(): void {
    this.getAllBookForeign();
  }

  getAllBookForeign() {
    this.bookService.getAllBookForeign().subscribe((data: IBook[]) => {
      this.bookList = data;
      console.log(this.bookList);
    });
  }
}
