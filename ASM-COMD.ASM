
;
;+800	".data" ->3000h-

STR_HELLO:
	DB	"Hello, World!", 0ah, 0

FILENAME_TEST1:
	DB	"CreateFileTest.txt", 0

	ALIGN	4

N_WROTE:DD	0

HDL_STDIN:DD	0
HDL_STDOUT:DD	0
HDL_STDERR:DD	0

HDL_OUTFILE:DD	0

N_READ:DD	0

PUTCHR_BUF:DB	0

CMDLINE:DD	0

READ_BUF:	DEFS	200

;USRDMA:


;

MES10:	DB	'end address = $'
MES11:	DB	'label(s)    = $'

BDAT:	DEFS	10H

INCL_NAME:DD	0

COND:	DB	0

IF.FLG:	DB	0

SUBWRK:	DEFS	16


STR_BYTE:DB	4,'BYTE'

STR_WORD:DB	4,'WORD'

STR_DWORD:DB	5,'DWORD'

STR_SHORT:DB	5,'SHORT'

;

EMES_SEEK:
	DB	'Seek failed !$'

EMES_ALLOC:
	DB	'Alloc failed !$'

EMES0:	DEFM	'Read file open error$'
EMES1:	DEFM	'Read file read error$'
EMES2:	DEFM	'Write file make error$'
EMES3:	DEFM	'Write file write error$'
EMES4:	DEFM	'Label error$'
EMES5:	DEFM	'Multiply Defined label$'
EMES6:	DEFM	'Format error$'
EMES7:	DEFM	'Number error$'
EMES8:	DEFM	'Label table full$'
EMES9:	DEFM	'Undefined label$'
EMESA:	DEFM	'Reference error$'
EMESB:	DEFM	'Operand error$'
EMESC:	DEFM	'Include error$'
EMESD:	DEFM	'Too long line$'


MES2:	DEFM	'Pass...$'


STR_ASM:DB	'.ASM',0

STR_COM:DB	'.COM',0

;-----
WORK:

LBL_SEG:DD	0

PASS:	DB	0

LIN.NO:	DD	0
LBL.NO:	DD	0
LBL.NX:	DD	0
ERR.NO:	DD	0

TEXT.ADR:DD	0
RDATA.ADR:DD	0
DATA.ADR:DD	0
DATA_END.ADR:DD	0

ENTRY_IAT.ADR:DD	0
ENTRY_IMPORT.ADR:DD	0

ORG.ADR:DD	0
O.ADR1:	DD	0
O.ADR2:	DD	0
O.BYTE:	DD	0

FLG.1:	DB	0
FLG.2:	DB	0
FLG.3:	DB	0
FLG.R:	DB	0;use short jmp
FLG.L:	DB	0
FLG.P:	DB	0;display line
FLG.E:	DB	0;make exp

FLG.D:	DB	0;debug symbol
FLG.W:	DB	0;windows 32-bit pe exe

FLG.TEXT_WRITABLE:DB	0

FLG.386:DB	0
FLG.DWORD:DB	0
FLG.SHORT:DB	0

FLG2.386:DB	0
FLG2.DWORD:DB	0

FLG2.SHORT:DB	0

FLG2.FAR:DB	0

PRE_SIZE:DB	0
PRE_SIZE1:DB	0
PRE_SIZE2:DW	0	;DB?

C.MOVZX.CODE:	DB	0

S.LEFT:	DD	0
S.PNT:	DD	0
FL.END:	DB	0

W.LEFT:	DD	0
W.PNT:	DD	0

PNT:	DD	0
PNT2:	DD	0

FLAG_FILE2:DB	00H

HDL:	DD	0
HDL2:	DD	0

LOAD.F:	DB	0	;including file no.
FCB:	DD	0	;pointer to fcb

FILE2:	DEFS	80	;write file

FILE1:	DEFS	80	;read file

	DEFS	270H	;for 16 files

STACK:	DD	0

QUOTATION:
	DB	0


F.TYPE:	DB	0

MOD2:	DB	0

L.DATA:
	DEFS	linesize+20

;TABFLG:	DEFS	1

;SGN:	DEFS	1
LEN:	DB	0

WORKDC:	DEFS	6


LBL.PNT.NEXT:
	DD	0


LBL.PNT.TOP:	DEFS	400H	;100H*4

LBL.PNT:	DEFS	400H	;100H*4

PREV_O.ADR1:DD	0

WORK1:	DEFS	200	;100
WORK2:	DEFS	200	;100



;-----
;------
HEADER_BUF:
	DEFS	FILE_ALIGN

;------
;HEADER_TEMPLATE:
WIN_HEADER:
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
	;;DS	BASE+PE_OFFSET-$
	DEFS	WIN_HEADER+PE_OFFSET-$

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


WIN_HEADER_END:
	;ds	HEADER+0400h-$
;;	ALIGN	FILE_ALIGN

;;_TEXT:

;+400	".text"

;----
IMAGE_DEBUG_DIRECTORY_OFF:	DD	0
COFF_SYMBOLS_HEADER_OFF:	DD	0
PUT_DEBUG_LONGSTR_PNT:		DD	0
PUT_DEBUG_LONGSTR_TOTAL_SIZE:	DD	0

;
COFF_BUF:	DEFS	100H

STR_IMAGE_DEBUG_DIRECTORY:
	;DB	'__ENTRY_DEBUG__',0
	DB	'__IMAGE_DEBUG_DIRECTORY__',0


EMES_NO_DEBUG_ENTRY:
	DB	'Not found __IMAGE_DEBUG_DIRECTORY__',0dh,0ah,'$'

EMES_NO_LABEL:
	DB	'Not found label:','$'


;ENTRY_DEBUG_HEADER:
IMAGE_DEBUG_DIRECTORY:
	DD	0	;Characteristics
	DD	529037aeh	;TimeDateStamp
	DW	0	;MajorVersion
	DW	0	;MinorVersion
	DD	1;IMAGE_DEBUG_TYPE_COFF	;Type
;+10
	DD	0;_DEBUG_NAME_END-_DEBUG_HEADER1	;SizeOfData;

	DD	0	;AddressOfRawData
;+18
	DD	0;_DEBUG_HEADER1-BASE	;PointerToRawData



COFF_SYMBOLS_HEADER:
	DD	4	;NumberOfSymbols
	DD	-1;_SYM1-_DEBUG_HEADER1	;LvaToFirstSymbol
	DD	0	;NumberOfLinenumbers
	DD	0	;LvaToFirstLinenumber

	DD	0;_TEXT_RVA	;RvaToFirstByteOfCode
	DD	0;_TEXT_END-1-_TEXT+_TEXT_RVA	;RvaToLastByteOfCode
	DD	0;_DATA_RVA	;RvaToFirstByteOfData
	DD	0;_DATA_END-1-_DATA+_DATA_RVA	;RvaToLastByteOfData

COFF_SYMBOL:
	DB	'12345678'	;ShortName
	DD	0	;Value
	DW	1;-2	;SectionNumber
	DW	0	;Type
	DB	2	;StorageClass
	DB	0	;NumberOfAuxSymbols


