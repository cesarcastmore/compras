import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-menus',
  templateUrl: './menus.component.html',
  styleUrls: ['./menus.component.css']
})
export class MenusComponent implements OnInit {

	public toggle:boolean = true; 

  constructor() { }

  ngOnInit() {
  }

  public onToggle(){
  	this.toggle= !this.toggle;
  }

}
