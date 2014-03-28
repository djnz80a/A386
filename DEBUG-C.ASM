;--------------

_DEBUG:



_DEBUG_FILL:
;	DB	0

	ALIGN	FILE_ALIGN

_DEBUG_END:




	ALIGN	FILE_ALIGN
;-------------------

;;HEADER_END:



;	CLI
;	mov	esp,40000h
;	STI
;	CLD

;	CALL	GETCLINE

;	MOV	EAX,DS
;	MOV	ES,EAX

;	MOV	ESI,CLINE+1
;	MOV	EDI,FILE1
;	CALL	STRCPY



;stypedef struct _IMAGE_COFF_SYMBOLS_HEADER {
;    DWORD   NumberOfSymbols;
;    DWORD   LvaToFirstSymbol;
;    DWORD   NumberOfLinenumbers;
;    DWORD   LvaToFirstLinenumber;
;    DWORD   RvaToFirstByteOfCode;
;    DWORD   RvaToLastByteOfCode;
;    DWORD   RvaToFirstByteOfData;
;    DWORD   RvaToLastByteOfData;
;} IMAGE_COFF_SYMBOLS_HEADER, *PIMAGE_COFF_SYMBOLS_HEADER;

	ALIGN FILE_ALIGN




;NumberOfSymbols
;    The number of symbols.
;LvaToFirstSymbol
;    The virtual address of the first symbol.
;NumberOfLinenumbers
;    The number of line-number entries.
;LvaToFirstLinenumber
;    The virtual address of the first line-number entry.
;RvaToFirstByteOfCode
;    The relative virtual address of the first byte of code.
;RvaToLastByteOfCode
;    The relative virtual address of the last byte of code.
;RvaToFirstByteOfData
;    The relative virtual address of the first byte of data.
;RvaToLastByteOfData
;    The relative virtual address of the last byte of data.

;+1c
;IMAGE_COFF_SYMBOLS_HEADER
_DEBUG_HEADER1:
	DD	4	;NumberOfSymbols
	DD	_SYM1-_DEBUG_HEADER1	;LvaToFirstSymbol
	DD	0	;NumberOfLinenumbers
	DD	0	;LvaToFirstLinenumber

	DD	_TEXT_RVA	;RvaToFirstByteOfCode
	DD	_TEXT_END-1-_TEXT+_TEXT_RVA	;RvaToLastByteOfCode
	DD	_DATA_RVA	;RvaToFirstByteOfData
	DD	_DATA_END-1-_DATA+_DATA_RVA	;RvaToLastByteOfData


;	dd	3dh
;	dd	0020h
;	dd	0
;	dd	0

;	dd	00001000h
;	dd	00001200h
;	dd	00002000h
;	dd	00001400h


;//
;// Symbol format.
;//
;
;typedef struct _IMAGE_SYMBOL {
;    union {
;        BYTE    ShortName[8];
;        struct {
;            DWORD   Short;     // if 0, use LongName
;            DWORD   Long;      // offset into string table
;        } Name;
;        DWORD   LongName[2];    // PBYTE [2]
;    } N;
;    DWORD   Value;
;    SHORT   SectionNumber;
;    WORD    Type;
;    BYTE    StorageClass;
;    BYTE    NumberOfAuxSymbols;
;} IMAGE_SYMBOL;
;typedef IMAGE_SYMBOL UNALIGNED *PIMAGE_SYMBOL;

;#define IMAGE_SIZEOF_SYMBOL                  18


;//
;// Section values.
;//
;// Symbols have a section number of the section in which they are
;// defined. Otherwise, section numbers have the following meanings:
;//
;
;#define IMAGE_SYM_UNDEFINED           (SHORT)0          // Symbol is undefined or is common.
;#define IMAGE_SYM_ABSOLUTE            (SHORT)-1         // Symbol is an absolute value.
;#define IMAGE_SYM_DEBUG               (SHORT)-2         // Symbol is a special debug item.
;#define IMAGE_SYM_SECTION_MAX         0xFEFF  

;IMAGE_SYM_UNDEFINED 0 Symbol record is not yet assigned a section. If the value
;is 0 this indicates a references to an external symbol
;defined elsewhere. If the value is non-zero this is a
;common symbol with a size specified by the value.

_SYM1:
	DB	'header',0,0	;ShortName
	DD	0	;Value
	DW	-2	;SectionNumber
	DW	0	;Type
	DB	2	;StorageClass
	DB	0	;NumberOfAuxSymbols
_DEBUG_NAME_END:

	DB	'_start',0,0	;ShortName
	DD	00001000h	;Value
	DW	1	;SectionNumber
	DW	0	;Type
	DB	2	;StorageClass
	DB	0	;NumberOfAuxSymbols

	DB	'hogehoge'
	DD	12345678h;00001000h	;Value
	DW	1	;SectionNumber
	DW	0	;Type
	DB	2	;StorageClass
	DB	0	;NumberOfAuxSymbols



	DB	'end',0, 0,0,0,0
	DD	4000h
	DW	-2
	DW	0
	DB	2
	DB	0


;SYM2_END:

;01B 00000000 DEBUG  notype       External     | header
;01C 00001000 SECT1  notype ()    External     | _start
;03C 00004000 DEBUG  notype       External     | end

	DEFS	700h







