import { Component, OnInit } from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {BookService} from '../../service/book.service';

@Component({
  selector: 'app-book-combo',
  templateUrl: './book-combo.component.html',
  styleUrls: ['./book-combo.component.css']
})
export class BookComboComponent implements OnInit {

  bookList: IBook[] = [];

  constructor(private bookService: BookService) { }

  ngOnInit(): void {
    this.getAllBookCombo();
  }

  getAllBookCombo() {
    this.bookService.getAllBookCombo().subscribe((data: IBook[]) => {
      this.bookList = data;
      console.log(this.bookList);
    });
  }

}
