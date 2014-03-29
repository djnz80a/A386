
;section order:
;.text
;.rdata
;.entry_iat:
;.entry_import:
;.data

;http://msdn.microsoft.com/en-us/library/ms809762.aspx

PE_OFFSET EQU	000000C0H

;must be aligned
DATA_ADD EQU 8000h+8000h+8000h+20000h	;read buf level 0 + write buf + read buf level1~ + labels
;DATA_ADD EQU 0


;FILE_ALIGN EQU	200h
FILE_ALIGN EQU	1000h	;##
SECTION_ALIGN EQU	1000h
;SECTION_ALIGN EQU	200h	;##

;_TEXT_RVA EQU	1000h
;_RDATA_RVA EQU	2000h
;_DATA_RVA EQU	3000h
;_RELOC_RVA EQU	4000h

_TEXT_RVA EQU	_TEXT-BASE
_RDATA_RVA EQU	_RDATA-BASE
_DATA_RVA EQU	_DATA-BASE

_DEBUG_RVA EQU	_DEBUG-BASE

;_RELOC_RVA EQU	_RELOC-BASE+DATA_ADD


_RDATA_SIZE EQU	_RDATA_END-_RDATA
_DATA_SIZE EQU	_DATA_END-_DATA+DATA_ADD
;_RELOC_SIZE EQU _RELOC_END-_RELOC
_RELOC_SIZE EQU 0

CODE_SIZE EQU	_TEXT_END-_TEXT
INIT_DATA_SIZE EQU	_RDATA_SIZE+_DATA_SIZE+_RELOC_SIZE
UNINIT_DATA_SIZE EQU	0

;BASE_SIZE EQU	_RELOC_RVA+SECTION_ALIGN	;_RELOC_SIZE
BASE_SIZE EQU	_DATA_RVA+_DATA_SIZE	;SECTION_ALIGN	;_RELOC_SIZE

ENTRY_RVA EQU	_TEXT_RVA


HEADER:
	DB	'M','Z'
	DW	0090h	;Bytes on last page of file
	DW	0003h	;Pages in file
	DW	0000h	;Relocations
	DW	0004h	;Size of header in paragraphs
	DW	0000h	;Minimum extra paragraphs needed
	DW	0FFFFh	;Maximum extra paragraphs needed
	DW	0000h	;Initial (relative) SS value

;+10
	DW	00B8h	;Initial SP value
	DW	0000h	;Checksum
	DW	0000h	;Initial IP value
	DW	0000h	;Initial (relative) CS value
	DW	0040h	;File address of relocation table
	DW	0000h	;Overlay number
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words

;+20
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;OEM identifier (for e_oeminfo)
	DW	0000h	;OEM information; e_oemid specific
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
;+30
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
	DW	0000h	;Reserved words
;+3c
	DD	PE_OFFSET	;000000C0H	;DW	00C0H, 0000h	;File address of new exe header
;+40
	DB	0Eh, 1Fh,0BAh, 0Eh, 00h,0B4h, 09h,0CDh
	DB	21h,0B8h, 01h, 4Ch,0CDh, 21h, 54h, 68h
	DB	69h, 73h, 20h, 70h, 72h, 6Fh, 67h, 72h
	DB	61h, 6Dh, 20h, 63h, 61h, 6Eh, 6Eh, 6Fh
	DB	74h, 20h, 62h, 65h, 20h, 72h, 75h, 6Eh
	DB	20h, 69h, 6Eh, 20h, 44h, 4Fh, 53h, 20h
	DB	6Dh, 6Fh, 64h, 65h, 2Eh, 0Dh, 0Dh, 0Ah
	DB	24h, 00h, 00h, 00h, 00h, 00h, 00h, 00h


	;PUSH	CS
	;POP	DS
	;MOV	DX,MES_DUMMY-HEADER-40H
	;MOV	AH,9
	;INT	21H
	;MOV	AX,4C01H
	;INT	21H
;MES_DUMMY:
	;DB	"This program cannot be run in DOS mode.", 0dh, 0dh, 0ah, '$'

;+80
	

	;DS	HEADER+0c0h-$
	;;DEFS	BASE+PE_OFFSET-$
	DEFS	0c0h-80h

;+c0
	DB	'P','E', 00h, 00h
	DW	014ch		;Machine	= IMAGE_FILE_MACHINE_I386
	DW	3;0004h	;0003h	;0004h		;NumberOfSections
	DD	529037aeh	;TimeDateStamp
	;DD	00000000h	;PointerToSymbolTable
	DD	_SYM1-BASE
;+d0
	DD	4;3;00000000h	;NumberOfSymbols
	DW	00E0h		;SizeOfOptionalHeader
	DW	0107h;0102h		;Characteristics = IMAGE_FILE_32BIT_MACHINE(0x0100)
				;		| IMAGE_FILE_EXECUTABLE_IMAGE(0x0002)
;+d8
	DW	010Bh		;Magic
	DB	5;09h	;MajorLinkerVersion
	DB	12;00h	;MinorLinkerVersion
	DD	CODE_SIZE	;00000200h	;SizeOfCode
;+e0
	DD	INIT_DATA_SIZE	;00000600h	;SizeOfInitializedData
	DD	UNINIT_DATA_SIZE	;00000000h	;SizeOfUninitializedData
	DD	ENTRY_RVA	;00001000h	;AddressOfEntryPoint
	DD	_TEXT_RVA	;00001000h	;BaseOfCode
;+f0
	DD	_RDATA_RVA	;00002000h	;BaseOfData
	DD	BASE	;00400000h	;ImageBase
	DD	SECTION_ALIGN	;00001000h	;SectionAlignment

	DD	FILE_ALIGN	;00000200h	;FileAlignment
;+100
	DW	4;0005h	;MajorOperatingSystemVersion
	DW	0000h	;MinorOperatingSystemVersion
	DW	0000h	;MajorImageVersion
	DW	0000h	;MinorImageVersion
	DW	4;0005h	;MajorSubsystemVersion
	DW	0000h	;MinorSubsystemVersion
	DD	00000000h	;Win32VersionValue
;+110
	DD	BASE_SIZE	;00005000h	;SizeOfImage
	DD	_TEXT-BASE	;00000400h	;SizeOfHeaders
	DD	00000000h	;CheckSum
	DW	0003h		;Subsystem = IMAGE_SUBSYSTEM_WINDOWS_CUI(3)

;IMAGE_SUBSYSTEM_WINDOWS_GUI          2   // Image runs in the Windows GUI subsystem.
;IMAGE_SUBSYSTEM_WINDOWS_CUI          3   // Image runs in the Windows character subsystem.


	;DW	8540h		;DllCharacteristics
	;DW	8500h
	;DW	8000h
	DW	0
				;
				;IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE 0x0040     // DLL can move.
				;IMAGE_DLLCHARACTERISTICS_NX_COMPAT    0x0100     // Image is NX compatible
				;IMAGE_DLLCHARACTERISTICS_NO_SEH       0x0400     // Image does not use SEH.  No SE handler may reside in this image
				;IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE     0x8000

;IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY    0x0080     // Code Integrity Image


;+120
	DD	00100000h	;SizeOfStackReserve
	DD	00001000h	;SizeOfStackCommit
	DD	00100000h	;SizeOfHeapReserve
	DD	00001000h	;SizeOfHeapCommit
;+130
	DD	00000000h	;LoaderFlags
	DD	00000010h	;NumberOfRvaAndSizes

;+138
	DD	00000000h	;#0
	DD	00000000h
;+140
	DD	ENTRY_IMPORT-_RDATA+_RDATA_RVA	;0000200ch	;#1 IMAGE_DIRECTORY_ENTRY_IMPORT
	DD	ENTRY_IMPORT_END-ENTRY_IMPORT	;00000028h
	DD	00000000h	;#2 IMAGE_DIRECTORY_ENTRY_RESOURCE
	DD	00000000h
;+150
	DD	00000000h	;#3
	DD	00000000h
	DD	00000000h	;#4
	DD	00000000h
;+160
	DD	0	;00004000h	;#5 IMAGE_DIRECTORY_ENTRY_BASERELOC
	DD	0	;00000010h
	;DD	ENTRY_DEBUG-_DEBUG+_DEBUG_RVA	;00000000h	;#6 IMAGE_DIRECTORY_ENTRY_DEBUG
	dd 0;DD	ENTRY_DEBUG-_RDATA+_RDATA_RVA	;00000000h	;#6 IMAGE_DIRECTORY_ENTRY_DEBUG
	dd 0;DD	1ch*1	;00000000h
;+170
	DD	00000000h	;#7
	DD	00000000h
	DD	00000000h	;#8
	DD	00000000h
;+180
	DD	00000000h	;#9
	DD	00000000h
	DD	00000000h	;#a
	DD	00000000h
;+190
	DD	00000000h	;#b
	DD	00000000h
	DD	_RDATA_RVA	;00002000h	;#c IMAGE_DIRECTORY_ENTRY_IAT
	DD	ENTRY_IAT_END-ENTRY_IAT	;0000000ch
;+1a0
	DD	00000000h	;#d
	DD	00000000h
	DD	00000000h	;#e
	DD	00000000h
;+1b0
	DD	00000000h	;#f
	DD	00000000h

;section header
;+1b8	(c0('PE') + f8)
	DB	".text",0,0,0
	DD	_TEXT_FILL-_TEXT	;0000001dh	;adrs/size
	DD	_TEXT_RVA	;00001000h	;VirtualAddress
	DD	_TEXT_END-_TEXT	;00000200h	;SizeOfRawData
	DD	_TEXT-BASE	;00000400h	;PointerToRawData
	DD	00000000h	;PointerToRelocations
	DD	00000000h	;PointerToLinenumbers
	DW	0000h		;NumberOfRelocations
	DW	0000h		;NumberOfLinenumbers
	DD	60000020h	;Characteristics
	;DD	60000020h+80000000h	;Characteristics
	;	IMAGE_SCN_CNT_CODE	(00000020)
	;	| IMAGE_SCN_MEM_EXECUTE	(20000000)
	;	| IMAGE_SCN_MEM_READ	(40000000)
;+1e0
	DB	".rdata", 0,0
	DD	_RDATA_FILL-_RDATA	;0000006ah
	DD	_RDATA_RVA	;00002000h	;VirtualAddress
	DD	_RDATA_END-_RDATA	;00000200h	;SizeOfRawData
	DD	_RDATA-BASE	;00000600h	;PointerToRawData
	DD	00000000h
	DD	00000000h
	DW	0000h
	DW	0000h
	DD	40000040h
	;	IMAGE_SCN_CNT_INITIALIZED_DATA	(00000040)
	;	| IMAGE_SCN_MEM_READ		(40000000)

;+208
	DB	".data",0,0,0
	DD	DATA_ADD+_DATA_FILL-_DATA	;0000000fh
	DD	_DATA_RVA	;00003000h	;VirtualAddress
	DD	_DATA_END-_DATA	;00000200h	;SizeOfRawData
	DD	_DATA-BASE	;00000800h	;PointerToRawData
	DD	00000000h
	DD	00000000h
	DW	0000h
	DW	0000h
	DD	0c0000040h
	;	IMAGE_SCN_CNT_INITIALIZED_DATA(00000040)
	;	| IMAGE_SCN_MEM_READ	(40000000)
	;	| IMAGE_SCN_MEM_WRITE	(80000000)
;;+230
;	DB	".reloc",0,0
;	DD	_RELOC_FILL-_RELOC	;00000028h
;	DD	_RELOC_RVA	;00004000h	;VirtualAddress
;	DD	_RELOC_END-_RELOC	;00000200h	;SizeOfRawData
;	DD	_RELOC-BASE	;00000a00h	;PointerToRawData
;	DD	00000000h
;	DD	00000000h
;	DW	0000h
;	DW	0000h
;	DD	42000040h
;	;	IMAGE_SCN_CNT_INITIALIZED_DATA	(00000040)
;	;	| IMAGE_SCN_MEM_DISCARDABLE	(02000000)
;	;	| IMAGE_SCN_MEM_READ		(40000000)

;+230
	DB	".debug",0,0
	DD	_DEBUG_FILL-_DEBUG	;00000028h
	;DD	_DEBUG_END-_DEBUG	;00000028h
	DD	_DEBUG_RVA	;00004000h	;VirtualAddress
	DD	_DEBUG_END-_DEBUG	;00000200h	;SizeOfRawData
	DD	_DEBUG-BASE	;00000a00h	;PointerToRawData
	DD	00000000h
	DD	00000000h
	DW	0000h
	DW	0000h
	DD	40000040h
	;DD	42000040h
;	;	IMAGE_SCN_CNT_INITIALIZED_DATA	(00000040)
;	;	| IMAGE_SCN_MEM_DISCARDABLE	(02000000)
;	;	| IMAGE_SCN_MEM_READ		(40000000)



;#define IMAGE_SCN_ALIGN_16BYTES              0x00500000  // Default alignment if no others are specified.

;+258



	;ds	HEADER+0400h-$
	ALIGN	FILE_ALIGN

_TEXT:

;+400	".text"

	PUSH	DWORD -10
	CALL	[IAT_GetStdHandle]
	MOV	[HDL_STDIN],EAX

	PUSH	DWORD -11
	CALL	[IAT_GetStdHandle]
	MOV	[HDL_STDOUT],EAX

	PUSH	DWORD -12
	CALL	[IAT_GetStdHandle]
	MOV	[HDL_STDERR],EAX

	CALL	[IAT_GetCommandLineA]
	MOV	[CMDLINE],EAX

	MOV	ESI,EAX
	CALL	_PUTSTR




	;JMP	TEST_HELLO

	;JMP	TEST2
	;JMP	TEST3
	;JMP	TEST4
	;JMP	TEST5
	;JMP	TEST6
	;JMP	TEST7

	JMP	ENTRY_MAIN

	PUSH	DWORD -12;-11;	PUSH	0FFFFFFF5h
	;CALL	[IAT_GetStdHandle-_RDATA+_RDATA_RVA+BASE]	;CALL	[00402000h]
	CALL	[IAT_GetStdHandle]

	push	eax

	push	0
	push	N_WROTE	;0
	push	0eh
	;push	STR_HELLO-_DATA+_DATA_RVA+BASE	;00403000h
	push	STR_HELLO
	push	EAX
	;CALL	[IAT_WriteFile-_RDATA+_RDATA_RVA+BASE]	;;call	[00402004h]
	CALL	[IAT_WriteFile]

	pop	eax

	push	0
	mov	ebx,esp;	lea	eax,[esp+0]
	push	0
	push	ebx
	push	0eh
	push	STR_HELLO
	push	eax
	call	[IAT_WriteFile]

	pop	eax

;	XOR	EAX,EAX
	RET


TEST2:
	PUSH	DWORD -10
	CALL	[IAT_GetStdHandle]
	MOV	[HDL_STDIN],EAX

	PUSH	DWORD -11
	CALL	[IAT_GetStdHandle]
	MOV	[HDL_STDOUT],EAX


	PUSH	0
	PUSH	N_READ
	PUSH	100
	PUSH	READ_BUF
	PUSH	[HDL_STDIN]
	call	[IAT_ReadFile]

	PUSH	0
	PUSH	N_WROTE
	PUSH	[N_READ]
	PUSH	READ_BUF
	PUSH	[HDL_STDOUT]
	call	[IAT_WriteFile]

	MOV	EAX,[N_READ]

	RET


CREATE_NEW          EQU 1
CREATE_ALWAYS       EQU 2
OPEN_EXISTING       EQU 3
OPEN_ALWAYS         EQU 4
TRUNCATE_EXISTING   EQU 5

GENERIC_READ	EQU	80000000h
GENERIC_WRITE	EQU	40000000h
FILE_ATTRIBUTE_NORMAL EQU	00000080h

TEST3:
	PUSH	0		;templateFile
	PUSH	FILE_ATTRIBUTE_NORMAL
	PUSH	CREATE_ALWAYS	;CREATE_NEW
	PUSH	0		;securityAttribute
	PUSH	0		;shareMode
	PUSH	GENERIC_WRITE
	PUSH	FILENAME_TEST1
	CALL	[IAT_CreateFileA]
	MOV	[HDL_OUTFILE],EAX

	push	0
	push	N_WROTE	;0
	push	0eh
	push	STR_HELLO
	push	EAX
	CALL	[IAT_WriteFile]


	PUSH	[HDL_OUTFILE]
	CALL	[IAT_CloseHandle]

	RET


TEST4:
	CALL	[IAT_GetCommandLineA]
	MOV	[CMDLINE],EAX

	MOV	ESI,EAX
	CALL	_PUTSTR

	RET

TEST5:
	MOV	EBX,[IAT_ExitProcess]

	;CLI
	XOR	EAX,EAX
	MOV	AX,CS
	MOV	DS,AX
	MOV	ES,AX
	;MOV	SS,AX
	;MOV	ESP,_TEXT_FILL-4
	;STI

	PUSH	100
	PUSH	EBX
	RET

	MOV	EAX,100
	PUSH	EAX
	CALL	[IAT_ExitProcess]

	RET

TEST6:
	CALL	[IAT_GetCommandLineA]
	MOV	[CMDLINE],EAX

	MOV	ESI,EAX
	CALL	_PUTSTR

	MOV	EAX,[_DATA_FILL]


	MOV	EAX,[_TEXT]

	MOV	[_TEXT],EAX	;exception

	MOV	ESI,[CMDLINE]
	CALL	_PUTSTR

	RET

TEST_HELLO:
	MOV	ESI,STR_HELLO
	CALL	_PUTSTR
	RET

TEST7:
	MOV	EDI,USRDMA
	MOV	ECX,10000h
TEST7.10:
	MOV	[EDI],AL
	INC	EDI
	DEC	ECX
	JNE	TEST7.10

	CALL	TEST_HELLO
	MOV	AL,'7'
	CALL	_PUTCHR
	CALL	_PUTCRLF
	RET

_PUTCRLF:
	MOV	AL,0Dh
	CALL	_PUTCHR
	MOV	AL,0AH
	CALL	_PUTCHR
	RET

;
_PUTSTR:
	MOV	AL,[ESI]
	OR	AL,AL
	JE	_PUTSTR.R

	CALL	_PUTCHR

	INC	ESI
	JMP	_PUTSTR

_PUTSTR.R:
	RET

_PUTCHR:
	PUSHAD

	MOV	[PUTCHR_BUF],AL

	PUSH	0
	MOV	EAX,ESP

	push	0
	push	EAX	;push	N_WROTE	;0
	push	01h
	push	PUTCHR_BUF
	push	[HDL_STDOUT]
	CALL	[IAT_WriteFile]

	POP	EAX

	POPAD
	RET


GMEM_FIXED	EQU	00000000H
GMEM_ZEROINIT	EQU	00000040H

;	EAX<size
;	>EAX memory address

ALLOC:
	MOV	EBX,GMEM_FIXED+GMEM_ZEROINIT
	PUSH	EAX
	PUSH	EBX
	CALL	[IAT_GlobalAlloc]

	OR	EAX,EAX
	JE	ERR_ALLOC

	PUSHAD
	MOV	EBX,EAX
	CALL	PUTH4
	POPAD

	RET

;	EAX<memory address

FREE:
	PUSH	EAX
	CALL	[IAT_GlobalFree]

	RET



;################
