import { Component, OnInit } from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {BookService} from '../../service/book.service';

@Component({
  selector: 'app-book-vietnam',
  templateUrl: './book-vietnam.component.html',
  styleUrls: ['./book-vietnam.component.css']
})
export class BookVietnamComponent implements OnInit {

  bookList: IBook[] = [];

  constructor(private bookService: BookService) { }

  ngOnInit(): void {
    this.getAllBookVietNam();
  }

  getAllBookVietNam() {
    this.bookService.getAllBookVietNam().subscribe((data: IBook[]) => {
      this.bookList = data;
      console.log(this.bookList);
    });
  }

}
