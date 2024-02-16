import { NgModule, Injector } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { createCustomElement } from '@angular/elements';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: []
})
export class AppModule {
  constructor(injector: Injector,) {
    if ( ! window.customElements.get("app-ng-webcom") ) {
      // Convert `AppComponent` to a custom element.
      const elm = createCustomElement(AppComponent, {injector});
      // Register the custom element with the browser.
      customElements.define('app-ng-webcom', elm);
    }
  }
  ngDoBootstrap() {}
}
