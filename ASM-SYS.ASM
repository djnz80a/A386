;
;	EDX:filename
;	AL:mode(unused)
;	>EAX:handle
;
SYS_open:
	CALL	INT21_open
	RET

;	EDX:filename
;	AL:mode(unused)
;	>EAX:handle
SYS_create:
	CALL	INT21_create
	RET

;	AL:0(from top)/1(from current)/2(from bottom)
;	EBX:handle
;	CX:DX:distance
SYS_seek:
	CALL	INT21_seek
	RET

;	EBX:handle
;	ECX:bytes
;	EDX:address

SYS_read:
	CALL	INT21_read
	RET

;	EBX:handle
;	ECX:bytes
;	EDX:address

SYS_write:
	CALL	INT21_write
	RET

;	EBX:handle
SYS_truncate:
	CALL	INT21_truncate
	RET

;	EBX:handle
SYS_close:
	CALL	INT21_close
	RET

SYS_exit:
	CALL	INT21_exit
	RET

SYS_putchr:
	CALL	INT21_putchr
	RET

;	EDX:pnt to string (ends with '$')
SYS_putstr:
	CALL	INT21_putstr
	RET


;#define INVALID_HANDLE_VALUE ((HANDLE)(LONG_PTR)-1)

INVALID_HANDLE_VALUE EQU -1




;
;3d00	open
;	edx=filename
;	>ax handle
;	>cf=1 : error
INT21_open:

	PUSHAD
	MOV	AL,'['
	CALL	DOS02
	MOV	ESI,EDX
	CALL	_PUTSTR
	MOV	AL,']'
	CALL	DOS02
	CALL	_PUTCRLF
	POPAD

	PUSH	0		;templateFile
	PUSH	FILE_ATTRIBUTE_NORMAL
	PUSH	OPEN_EXISTING	;CREATE_ALWAYS	;CREATE_NEW
	PUSH	0		;securityAttribute
	PUSH	0		;shareMode
	PUSH	GENERIC_READ
	PUSH	EDX		;FILENAME_TEST1
	CALL	[IAT_CreateFileA]
	CMP	EAX,INVALID_HANDLE_VALUE
	JE	INT21_open.ERR

	;MOV	[HDL_INFILE],EAX

	CLC
	RET
INT21_open.ERR:
	STC
	RET

;
;3c00	create
;	edx=filename
;	>ax handle
;	>cf=1 : error

;
INT21_create:

	PUSHAD
	MOV	AL,'['
	CALL	DOS02
	MOV	ESI,EDX
	CALL	_PUTSTR
	MOV	AL,']'
	CALL	DOS02
	CALL	_PUTCRLF
	POPAD

	PUSH	0		;templateFile
	PUSH	FILE_ATTRIBUTE_NORMAL
	PUSH	CREATE_ALWAYS	;CREATE_NEW
	PUSH	0		;securityAttribute
	PUSH	0		;shareMode
	PUSH	GENERIC_WRITE
	PUSH	EDX		;FILENAME_TEST1
	CALL	[IAT_CreateFileA]
	CMP	EAX,INVALID_HANDLE_VALUE
	JE	INT21_create.ERR

	;MOV	[HDL_OUTFILE],EAX

	CLC
	RET
INT21_create.ERR:
	STC
	RET


;#define FILE_BEGIN           0
;#define FILE_CURRENT         1
;#define FILE_END             2

;4200	seek
;	bx=handle
;	cx : dx offset
;
;	> dx : ax current pointer

INT21_seek:
		;PUSHAD
		;MOV	EDX,MES_SEEK
		;CALL	DOS09
		;POPAD

		;PUSHAD
		;CALL	PUTH4
		;POPAD

	SHL	ECX,10h
	MOV	CX,DX

	MOVZX	EAX,AL

	PUSH	EAX
	PUSH	0	;size<2GB
	PUSH	ECX
	PUSH	EBX
	CALL	[IAT_SetFilePointer]

	CMP	EAX,0FFFFFFFFH
	JE	ERR_SEEK

	MOV	EDX,EAX
	SHR	EDX,10H
	MOVZX	EAX,AX

	CLC

;erro check?

	RET

;MES_SEEK:DB	'(seek)$'

INT21_getfilepointer:
	


;
;3f00	read
;	bx=handle
;	edx=buf
;	ecx=bytes
;	>eax read bytes

INT21_read:
	
	PUSH	0
	PUSH	N_READ
	PUSH	ECX
	PUSH	EDX	;READ_BUF
	PUSH	EBX	;[HDL_STDOUT]
	CALL	[IAT_ReadFile]
	OR	EAX,EAX
	JE	INT21_read.ERR

	MOV	EAX,[N_READ]
	CLC
	RET
INT21_read.ERR:
	XOR	EAX,EAX
	STC
	RET

;4000	write
;	bx=handle
;	edx=buf
;	ecx=bytes
;	>eax wrote bytes
;	cf=1 : error	
;
;4000	write/truncate
;	ecx=edx=0
;	bx=handle

INT21_write:
	XOR	EAX,EAX
	MOV	AX,CX
	OR	AX,DX
	JE	INT21_truncate

	PUSH	0
	PUSH	N_WROTE
	PUSH	ECX
	PUSH	EDX	;READ_BUF
	PUSH	EBX	;[HDL_STDOUT]
	CALL	[IAT_WriteFile]
	OR	EAX,EAX
	JE	INT21_write.ERR

	MOV	EAX,[N_WROTE]

	CLC
	RET

INT21_write.ERR:
	XOR	EAX,EAX
	STC
	RET


INT21_truncate:
	PUSH	EBX
	CALL	[IAT_SetEndOfFile]
	RET


;3e00	close
;	bx=handle
;	cf=1 : error
INT21_close:

	PUSH	EBX
	CALL	[IAT_CloseHandle]
	OR	EAX,EAX
	JE	INT21_close.ERR

	CLC
	RET

INT21_close.ERR:
	STC
	RET


;4c	exit
;	al=code

INT21_exit:
	MOVZX	EAX,AL
	PUSH	EAX
	CALL	[IAT_ExitProcess]

	RET

INT21_putchr:
	CALL	_PUTCHR
	RET

INT21_putstr:
	;JMP	_DOS09


	PUSHAD
INT21_putstr.1:
	MOV	AL,[EDX]
	CMP	AL,'$'
	JE	INT21_putstr.2
	PUSH	EDX
	;CALL	DOS02
	MOV	DL,AL
	CALL	INT21_putchr
	POP	EDX
	INC	EDX
	JMP	INT21_putstr.1

INT21_putstr.2:
	POPAD
	RET

;
;	put chr direct to console
;
INT91_1D:
	PUSHAD
	CALL	DOS02
	POPAD
	RET
;
;
;
;
DOS02:
;	DB	60H
;	MOV	AH,02H
;	MOV	DL,AL
;	INT	21H
;	DB	61H

	PUSHAD

	CALL	_PUTCHR

	POPAD

	RET

DOS09:
;	PUSH	EAX
;	MOV	AH,09H
;	INT	21H
;	POP	EAX


	PUSHAD
DOS09.1:
	MOV	AL,[EDX]
	CMP	AL,'$'
	JE	DOS09.R
	PUSH	EDX
	CALL	DOS02
	POP	EDX
	INC	EDX
	JMP	DOS09.1

DOS09.R:
	POPAD
	RET

;
;
DOS09_Z:

	PUSHAD
DOS09_Z.1:
	MOV	AL,[EDX]
	OR	AL,AL
	JE	DOS09_Z.R
	PUSH	EDX
	CALL	DOS02
	POP	EDX
	INC	EDX
	JMP	DOS09_Z.1

DOS09_Z.R:
	POPAD
	RET


