import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { BuscadorComponent } from './shared/buscador/buscador.component';
import { ButtonsModule, WavesModule, CardsFreeModule } from 'angular-bootstrap-md'
import { HttpModule } from '@angular/http';
import { FormsModule }   from '@angular/forms';
import { OrderPipe } from './shared/buscador/order.pipe';
@NgModule({
  declarations: [
    AppComponent,
    BuscadorComponent,
    OrderPipe
  ],
  imports: [
    BrowserModule, 
    ButtonsModule,
    WavesModule,
    CardsFreeModule,
    HttpModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
