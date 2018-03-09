.intel_syntax noprefix

.global main

.text

main:
	push  ebp
	mov ebp, esp

	mov eax, [ebp+12]
	mov ebx, [eax+4]

	push ebx
	call atoi
	add esp,4;		//Argument pobrany z linii jest zapamiętany w eax

	push eax;		//Zapamietuje eax

	mov eax, [ebp+12]
        mov ebx, [eax+8]
	push ebx
	call atoi
	add esp,4


	pop ebx; 		//n
	push eax;		//m

	call rekursja

//	add esp,4

	push eax
	mov eax, offset komunikat
	push eax
	call printf
	add esp, 8

	mov eax, 0

	mov esp, ebp
	pop ebp
	ret






rekursja:


	xor eax, eax;		//Zeruje rejestr z wynikiem
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx

	mov ecx, [ebp+8]

	cmp ebx, 0;		//Sprawdzam czy ebx=0
	jne skok1
		mov eax, ecx;	//Przypisuje do eax=ebx (dla n=0 f(n)=m) 
		add eax, 2;	//Dodaje 2(f(n)=m+2)
		jmp koniec
	
	skok1:
	cmp ebx, 1
	jne skok2
		mov eax, ecx
		jmp koniec
	skok2:
	cmp ebx, 2
	jne skok3
		mov eax, ecx
		jmp koniec
	skok3:
	//************************************2*f(n-1,m)**********************************************
		push ebx;		//Zapamiętuje ebx
		sub ebx, 1;		//Zmniejszam ebx o 1(n-1) 
		push ecx;		//Zapamiętuje ecx
	call rekursja
		add esp,4
		add eax, eax;		//Podwajam wynik bo 2*
		pop ebx;		//Zachowuje wartość ebx
		push eax;		//Wynik trzeba włożyc na stos
	//************************************f(n-2,m+1)*************************************************
		push ebx
		push ecx
		sub ebx, 2
		add ecx, 1
	call rekursja
		pop ecx;
		pop ebx
		pop edx;		//Do edx przypisuje wynik
		add eax, edx;		//Dodaje wynik poprzedniego wywołania
		push eax
	//************************************-f(n-3, m)*************************************************
		push ebx
		push ecx
		sub ebx, 3
	call rekursja
		add esp, 4
		pop ebx
		pop edx
		sub edx, eax
		mov eax, edx

	koniec:
		pop edx
		pop ecx
		pop ebx
		pop ebp
	ret



.data

komunikat:
.asciz "wynik = %i\n"
