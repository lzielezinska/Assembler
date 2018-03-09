.intel_syntax noprefix
.globl _start
.text

_start:				;//pobieram argumenty

mov ebp, esp
	mov eax, [ebp]
//	add al, '0'
	cmp eax,3
	je  skok6
//	mov [msg1+1], al


	mov eax, 4
	mov ebx, 1
	mov ecx, offset msg1
	mov edx, 20;	//offset dlugosc
	int 0x80
	jmp czy_koniec


	skok6:

	mov ebx, [ebp+8]

	mov ecx,0
	mov edx,0
	mov eax,10

atoi:
	mov dl, byte ptr [ebx]
	cmp dl,0
	je skok4

		inc ebx
		sub dl,48
		movzx edx, dl
		imul ecx, eax
		add ecx, edx

		jmp atoi
	skok4:

	mov eax, ecx
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx

	mov ebx, [ebp+12];



	mov edx, ebx;		//Zapisuje niezmieniomy ebx, w edx

petla:
	cmp byte ptr [ebx],0;	//Sprawdzam czy nie koniec
	je wynik

	cmp byte ptr[ebx],' ';		//Sprzwdzam czy znak=" "
	je wynik
		inc ebx
		inc ecx
		jmp petla


wynik:
	push eax;		//Zapamietuje na stosie wartosc x
	push ebx

	powrot1:
	push edx
	push ecx
	cmp  eax, 0;		//Sprawdzam czy eax=0
	je skok2
		powrot2:
		cmp ecx,0
		je skok3
				push eax
				push ebx
				push ecx
				push edx;
					mov ecx, edx
					mov dl, [edx]
					mov [msg+1], dl; 	//adres edx w ecx
					mov edx, 2;	//wyswietlam tylko pierwszy znak edx
					mov ebx, 1
					mov eax, 4;			//Drukowanie ?????????????????????????????????????????????
					mov ecx, offset msg;	//Drukuje ją??????????????????????????????
					int 0x80
				pop edx
				pop ecx
				pop ebx
				pop eax
				inc edx;
				dec ecx
				jmp powrot2
		skok3:
		dec eax

		push eax
		push ebx
		push ecx
		push edx
			mov eax, 4
			mov edx, 1
			mov ebx, 1
			mov ecx, offset spacja
			int 0x80
		pop edx
		pop ecx
		pop ebx
		pop eax


		
		pop ecx
		pop edx
		jmp powrot1
	skok2:
	pop ecx
	pop edx
	pop ebx
	pop eax

	inc ecx

	cmp byte ptr [ebx],0;
        je czy_koniec

	inc ebx
	add edx, ecx
	xor ecx, ecx
	jmp petla

czy_koniec:



mov eax, 4
mov edx, 1
mov ebx, 1
mov ecx, offset enter
int 0x80





mov eax,1;	//zakończenie programu??????
mov ebx,0
int 0x80;

.data

msg:
.asciz ""
msg1:
.asciz "Zla ilosc argumentow"
//.equ dlugosc,$-msg1
enter:
.ascii "\n"

spacja:
.ascii " "

