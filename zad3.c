#include <stdio.h>




int main(void){

char s[] = "abbbssssssssssssssssss";
int x = 0;

asm volatile(
	".intel_syntax noprefix;"
	"mov eax, %1;"          //do eax przypisuje tablice znakow s
	"mov ecx,1;"
	"xor edx,edx;"          // edx=0 
	"xor ebx, ebx;"
	"petla:"

		"mov bl, [eax];"      		// Przpypisuje pierwszy element eax do bl
		"cmp bl,0;"                     // Sprawdzam czy pierwszy element jest rowny zero
                "je koniec;"                    // Jezli tak to wykonuje skok do etykiety koniec

		"inc eax;"            		// Zwiekszam eax o 1(Przechodze do kolejnego elementu)
		"mov bh, [eax];"		// Przypisuje kolejny element tablicy do al
		"cmp bh,0;"        		// Sprawdzam czy kolejny element jest rowny zero
		"je koniec;"          		// Jezli tak to wykonuje skok do etykiety koniec

		"cmp bl, bh;"      		// Porownuje bl z pierwszym elementem eax
		"jne skok;"            		// Jeżeli nie są równe wykonuje skok
			"add ecx,1;"  		// Jeżeli są zwiększam licznik o 1
			"jmp petla;"
		"skok:"
		"cmp ecx, edx;"       		// Porównuje ecx z edx
		"jng skok2;"			//Jeżeli ecx > edx przpisuje ecx=edx
			"mov edx, ecx;"
			"mov ecx, 1;"		//Zeruje ecx

		"skok2:"

	"jmp petla;"
	"koniec:"

	"cmp ecx, edx;"                 // Porównuje ecx z edx
        "jng skok3;"                    //Jeżeli ecx > edx przpisuje ecx=edx
		"mov edx, ecx;"
                "mov ecx, 1;"           //Zeruje ecx
	"skok3:"

	"mov %0, edx;"
	".att_syntax prefix;"
	:"=r"(x)
	:"r"(s)
	:"eax","ebx","ecx","edx"
);

printf("%d\n",x);

 return 0;
}
