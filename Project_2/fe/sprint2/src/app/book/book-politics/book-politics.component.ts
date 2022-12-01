import { Component, OnInit } from '@angular/core';
import {IBook} from '../../model/book/IBook';
import {BookService} from '../../service/book.service';

@Component({
  selector: 'app-book-politics',
  templateUrl: './book-politics.component.html',
  styleUrls: ['./book-politics.component.css']
})
export class BookPoliticsComponent implements OnInit {

  bookList: IBook[] = [];

  constructor(private bookService: BookService) { }

  ngOnInit(): void {
    this.getAllBookPolitics();
  }

  getAllBookPolitics() {
    this.bookService.getAllBookPolitics().subscribe((data: IBook[]) => {
      this.bookList = data;
      console.log(this.bookList);
    });
  }

}
