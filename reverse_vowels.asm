section .data
	; declare global vars here

section .text
	global reverse_vowels

;;	void reverse_vowels(char *string)
;	Cauta toate vocalele din string-ul `string` si afiseaza-le
;	in ordine inversa. Consoanele raman nemodificate.
;	Modificare se va face in-place
reverse_vowels:

	pop esi ; asta e adresa de return din functie
	pop eax ; aici am stringul
	push ebx
	xor edi, edi

for_loop:
	xor edx, edx
	xor ebx, ebx
	add dl, [eax]

	cmp dl, 0 ; verific daca am ajuns la caracterul NULL
	jz end_for_loop

	cmp dl, 'a' ; verific daca am vocale
	jz change_value

	cmp dl, 'i'
	jz change_value

	cmp dl, 'e'
	jz change_value

	cmp dl, 'u'
	jz change_value

	cmp dl, 'o'
	jz change_value

continue_for:
	cmp ebx, 0
	jne encrypt_string

	inc edi
	inc eax
	jmp for_loop

change_value:
	inc ebx
	jmp continue_for

encrypt_string:
	push edx
	inc edi
	inc eax
	jmp for_loop

end_for_loop:
	sub eax, edi
	xor edi, edi

for_loop_2:
	xor edx, edx
	xor ebx, ebx
	add dl, [eax]

	cmp dl, 0
	jz end_for_loop_2

	cmp dl, 'a' ; verific daca am vocale
	jz change_value_2

	cmp dl, 'i'
	jz change_value_2

	cmp dl, 'e'
	jz change_value_2

	cmp dl, 'u'
	jz change_value_2

	cmp dl, 'o'
	jz change_value_2

continue_for_2:
	cmp ebx, 0
	jne encrypt_string_2

	inc edi
	inc eax
	jmp for_loop_2

change_value_2:
	inc ebx
	jmp continue_for_2

	inc edi
	inc eax
	jmp for_loop_2

encrypt_string_2:
	xor edx, edx
	pop edx

	xor ecx, ecx
	and [eax], byte 0
	add [eax], dl

	inc eax
	inc edi
	jmp for_loop_2

end_for_loop_2:
	pop ebx
	sub eax, edi

	push eax
	push esi
	ret