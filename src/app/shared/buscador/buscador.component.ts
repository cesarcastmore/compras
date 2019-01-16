import { Component, OnInit } from '@angular/core';
import { SearchService } from './search.service';

@Component({
  selector: 'app-buscador',
  templateUrl: './buscador.component.html',
  styleUrls: ['./buscador.component.css']
})
export class BuscadorComponent implements OnInit {

	public text: string;
	public list: any[]= [];

  constructor(private searcher: SearchService) { }

  ngOnInit() {
  }

  public find(){

  	this.list=[];

  	this.searcher.search('soriana', this.text, 0).subscribe(data=>{
  		console.log(data);
  		for(let r of data.results){
  			this.list.push(r);
  		}
  	});

  	  	this.searcher.search('heb', this.text, 0).subscribe(data=>{
  		for(let r of data.results){
  			this.list.push(r);
  		}
  	});

  }

}
