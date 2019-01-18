import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'order'
})
export class OrderPipe implements PipeTransform {

 transform(array: Array<string>, args: string): Array<string> {
   console.log("entrooooo")

  /*if(!array || array === undefined || array.length === 0) return null;

    array.sort((a: any, b: any) => {
      if (a.precio < b.precio) {
        return -1;
      } else if (a.precio > b.precio) {
        return 1;
      } else {
        return 0;
      }
    });*/
    return array;
  }

}
