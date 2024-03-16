section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	pathlen dd 0
	; declare global vars here

section .text
	global pwd
	extern strcat

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories
pwd:
	push ebp
	mov ebp, esp

	mov ecx, dword [ebp+8]  ; Adresa vectorului de directoare
	mov edx, dword [ebp+12]  ; Numărul de directoare
	mov esi, dword [ebp+16]  ; Adresa buffer-ului de rezultat (output)

	pusha

	mov dword [pathlen], 0 ;pt adancimea stivei

	xor eax, eax ;initializ cu 0
	xor ebx, ebx
verificare:
	mov ebx, [ecx+ eax*4]


	cmp byte [ebx+1], '.' ;pt 2 puncte se intoarce
	je intoarcere

	cmp byte [ebx], '.' ;pt 1 punct nu se intampla nimic
	je do_nothing

	

	push ebx
	inc dword [pathlen] ; +1 pt nr care calculeaza adancimea stivei
	jmp do_nothing


intoarcere:
	cmp dword [pathlen],0
	je do_nothing
	add esp, 4
	dec dword [pathlen] ; -1 din adancime pentru intoarcere


do_nothing:
	inc eax
	cmp eax, edx ;compara cu nr de directoare
	jl verificare



	mov ecx, dword [pathlen]

output: 
	;concateneaza cu strcat in output
	
	push esi 
	push ecx
	push slash
	push esi
	call strcat
	add esp, 8
	pop ecx
	pop esi


	mov eax, ecx
	mov edx, 4
	mul edx
	sub eax, 4
	add eax, esp


	push esi
	push ecx
	push dword [eax]
	push esi
	call strcat
	add esp, 8
	pop ecx
	pop esi

	loop output

	push esi
	push ecx
	push slash
	push esi
	call strcat
	add esp, 8
	pop ecx
	pop esi

	mov eax, dword [pathlen]

	mov edx, 4
	mul edx
	add esp, eax
 
	popa

	leave

	ret