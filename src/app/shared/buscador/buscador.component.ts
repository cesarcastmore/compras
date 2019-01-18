import { Component, OnInit } from '@angular/core';
import { SearchService } from './search.service';

@Component({
  selector: 'app-buscador',
  templateUrl: './buscador.component.html',
  styleUrls: ['./buscador.component.css']
})
export class BuscadorComponent implements OnInit {

  public text: string;
  public list: any[] = [];
  public cadenas: string[] = ['soriana', 'heb', 'liverpool', 'sears'];


  constructor(private searcher: SearchService) {}

  ngOnInit() {

  }

  public find() {
    this.list=[];

    this.getList(0);


  }


  public getList(index: number) {
    this.searcher.search(this.cadenas[index], this.text, 1).subscribe(data => {

      for (let r of data.results) {
        this.list.push(r);
      }

      this.list = this.order(this.list);
      index = index + 1;

      if (index < this.cadenas.length) {
        this.getList(index++);
      } else {
        return;
      }


    });
  }


  order(array: Array < any > ): Array < any > {
    console.log("entrooooo")

    if (!array || array === undefined || array.length === 0) return null;

    array.sort((a: any, b: any) => {
      if (Number(a.precio) < Number(b.precio)) {
        return -1;
      } else if (Number(a.precio) > Number(b.precio)) {
        return 1;
      } else {
        return 0;
      }
    });
    return array;
  }

}
