import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { BuscadorComponent } from './pages/buscador/buscador.component';
import { ButtonsModule, WavesModule, CardsFreeModule, CheckboxModule } from 'angular-bootstrap-md'
import { HttpModule } from '@angular/http';
import { FormsModule, ReactiveFormsModule }   from '@angular/forms';
import { MenusComponent } from './pages/menus/menus.component';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { AppRoutingModule } from './app-routing.module';

@NgModule({
  declarations: [
    AppComponent,
    BuscadorComponent,
    MenusComponent,
    LoginComponent,
    RegisterComponent
  ],
  imports: [
    BrowserModule, 
    ButtonsModule,
    WavesModule,
    CardsFreeModule,
    HttpModule,
    FormsModule,
    AppRoutingModule,
    CheckboxModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
