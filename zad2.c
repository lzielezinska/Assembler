#include <stdio.h>

int main(){

int x = 0xB7A6;
int y ;

asm volatile(
	".intel_syntax noprefix;"
	"xor ebx, ebx;"
	"xor edx, edx;"
	"mov eax, %1;"
	"mov ecx, eax;"

	"petla:"

	"and ecx, 0x0001;"   //Przypisuje do ecx ostatni bit
	"cmp ecx, 0x0001;"   //Sprawdzam czy jest rowny 1

	"jnz skok;"          // Jezeli nie jest wykonuje skok

	"petla1: cmp eax, 0;"

	"add ebx, 1;"        //Zwiekszam licznik o 1
	"shr eax;"           //Przesuwam o jeden bit
        "mov ecx, eax;"      //Po przesunieciu przypisuje wartosc do ecx
	"and ecx, 0x0001;"   //Przypisuje do ecx ostatni bit
        "cmp ecx, 0x0001;"   //Sprawdzam czy jest rowny 1

	"jz petla1;"

	"cmp ebx, edx;"
	"jng skok2;"

	"mov edx, ebx;"
	"skok2: "
	"xor ebx, ebx;"

	"skok: cmp eax,0;"

        "shr eax;"
        "mov ecx, eax;"

        "jnz petla;"
        "mov %0, edx;"

        ".att_syntax prefix;"
        :"=r"(y)
        :"r"(x)
        :"eax","ebx","ecx","edx"





);


printf("x = %x\ny = %d\n", x, y);

 return 0;
}
