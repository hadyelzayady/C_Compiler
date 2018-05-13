#include <stdio.h>
#include <string.h>
 
union Data {
   int i;
   float f;
   char str[20];
};
 
 void fn(Data d)
 {
   if(d.i!=NULL){
      printf ("not nuk");
   }
   else
   {
      printf("NULL\n");
   }
 }
int main( ) {

   union Data data;
   data.f=NULL;        
   fn(data);
   data.i = 10;
   printf( "data.i : %d\n", data);
   
   data.f = 220.5;
   printf( "data.f : %f\n", data.f);
   
   strcpy( data.str, "C Programming");
   printf( "data.str : %s\n", data.str);

   return 0;
}