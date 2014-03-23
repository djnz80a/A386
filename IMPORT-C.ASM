
;------------------------------------

_RDATA:

;+600	".rdata" ->2000h-

;<- #c IMAGE_DIRECTORY_ENTRY_IAT
;<- 0:FirstThunk

;Import Address Table
ENTRY_IAT:

IAT_GetStdHandle:
;IAT_GetStdHandle EQU $-_RDATA+_RDATA_RVA+BASE
	DD	ENTRY_GetStdHandle-_RDATA+_RDATA_RVA	;0000204ch	;DW	0264h / DB	"GetStdHandle",0
IAT_WriteFile:
	DD	ENTRY_WriteFile-_RDATA+_RDATA_RVA	;00002040h	;DW	0525h /	DB	"WriteFile", 0
IAT_ReadFile:
	DD	ENTRY_ReadFile-_RDATA+_RDATA_RVA
IAT_CreateFileA:
	DD	ENTRY_CreateFileA-_RDATA+_RDATA_RVA
IAT_CloseHandle:
	DD	ENTRY_CloseHandle-_RDATA+_RDATA_RVA
IAT_ExitProcess:
	DD	ENTRY_ExitProcess-_RDATA+_RDATA_RVA
IAT_GetCommandLineA:
	DD	ENTRY_GetCommandLineA-_RDATA+_RDATA_RVA
IAT_SetFilePointer:
	DD	ENTRY_SetFilePointer-_RDATA+_RDATA_RVA
IAT_SetEndOfFile:
	DD	ENTRY_SetEndOfFile-_RDATA+_RDATA_RVA
IAT_GlobalAlloc:
	DD	ENTRY_GlobalAlloc-_RDATA+_RDATA_RVA
IAT_GlobalFree:
	DD	ENTRY_GlobalFree-_RDATA+_RDATA_RVA

	DD	00000000h

ENTRY_IAT_END:

;<- #1 IMAGE_DIRECTORY_ENTRY_IMPORT

ENTRY_IMPORT:
;+60c	(200ch)
	DD	ENTRIES_0-_RDATA+_RDATA_RVA	;00002034h	;Characteristics
;+610
	DD	00000000h	;TimeDateStamp
	DD	00000000h	;ForwarderChain
	DD	DLLNAME_KERNEL32-_RDATA+_RDATA_RVA	;0000205ch	;Name = "KERNEL32.dll", 0
	DD	_RDATA_RVA	;00002000h	;FirstThunk
						;== ENTRY_IAT-_RDATA+_RDATA_RVA
;+620
	DD	00000000h	;Characteristics
	DD	00000000h
	DD	00000000h
	DD	00000000h
;+630
	DD	00000000h	;FirstThunk
ENTRY_IMPORT_END:

ENTRIES_0:
;+634	(2034h) <- 0:Characteristics
	DD	ENTRY_GetStdHandle-_RDATA+_RDATA_RVA	;0000204ch	;DW	0264h / DB	"GetStdHandle",0
	DD	ENTRY_WriteFile-_RDATA+_RDATA_RVA	;00002040h	;DW	0525h / DB	"WriteFile", 0
	DD	ENTRY_ReadFile-_RDATA+_RDATA_RVA
	DD	ENTRY_CreateFileA-_RDATA+_RDATA_RVA
	DD	ENTRY_CloseHandle-_RDATA+_RDATA_RVA
	DD	ENTRY_ExitProcess-_RDATA+_RDATA_RVA
	DD	ENTRY_GetCommandLineA-_RDATA+_RDATA_RVA
	DD	ENTRY_SetFilePointer-_RDATA+_RDATA_RVA
	DD	ENTRY_SetEndOfFile-_RDATA+_RDATA_RVA
	DD	ENTRY_GlobalAlloc-_RDATA+_RDATA_RVA
	DD	ENTRY_GlobalFree-_RDATA+_RDATA_RVA

	DD	00000000h


ENTRY_GlobalFree:
	DW	0
	DB	"GlobalFree",0
	ALIGN	4

ENTRY_GlobalAlloc:
	DW	0
	DB	"GlobalAlloc",0
	ALIGN	4

ENTRY_SetEndOfFile:
	DW	0
	DB	"SetEndOfFile", 0
	ALIGN	4

ENTRY_SetFilePointer:
	DW	0
	DB	"SetFilePointer", 0
	ALIGN	4

ENTRY_GetCommandLineA:
	DW	0
	DB	"GetCommandLineA", 0
	ALIGN	4

ENTRY_ExitProcess:
	DW	0
	DB	"ExitProcess",0
	ALIGN	4

ENTRY_CloseHandle:
	DW	0
	DB	"CloseHandle", 0
	ALIGN	4

ENTRY_CreateFileA:
	DW	0
	DB	"CreateFileA", 0
	ALIGN	4

ENTRY_ReadFile:
	DW	0
	DB	"ReadFile", 0
	ALIGN	4

;+640	(2040h)
ENTRY_WriteFile:
	DW	0525h
	DB	"WriteFile", 0

;+64c	(204ch)
ENTRY_GetStdHandle:
	DW	0264h
	DB	"GetStdHandle",0
	DB	0

;+65c	(205ch)
DLLNAME_KERNEL32:
	DB	"KERNEL32.dll", 0
	DB	0,0,0


;//
;// Debug Format
;//
;
;typedef struct _IMAGE_DEBUG_DIRECTORY {
;    DWORD   Characteristics;
;    DWORD   TimeDateStamp;
;    WORD    MajorVersion;
;    WORD    MinorVersion;
;    DWORD   Type;
;    DWORD   SizeOfData;
;    DWORD   AddressOfRawData;
;    DWORD   PointerToRawData;
;} IMAGE_DEBUG_DIRECTORY, *PIMAGE_DEBUG_DIRECTORY;

IMAGE_DEBUG_TYPE_COFF	EQU             1

	ALIGN	32

ENTRY_DEBUG:
__IMAGE_DEBUG_DIRECTORY__:
	DD	0	;Characteristics
	DD	529037aeh	;TimeDateStamp
	DW	0	;MajorVersion
	DW	0	;MinorVersion
	DD	IMAGE_DEBUG_TYPE_COFF	;Type

	;DD	_DEBUG_END-_DEBUG_HEADER1 ;-18	;SizeOfData;
	;DD	_DEBUG_FILL-_DEBUG_HEADER1 ;-18	;SizeOfData;
	DD	_DEBUG_NAME_END-_DEBUG_HEADER1

	DD	0  ;_DEBUG_HEADER1-_DEBUG+_DEBUG_RVA	;AddressOfRawData
	;DD	_DEBUG_HEADER1-_DEBUG;-BASE	;PointerToRawData
	DD	_DEBUG_HEADER1-BASE
	;DD	0ff000000h

;
;http://msdn.microsoft.com/en-us/library/windows/desktop/ms680307%28v=vs.85%29.aspx
;
;SizeOfData
;    The size of the debugging information, in bytes. This value does not include the debug directory itself.
;
;AddressOfRawData
;    The address of the debugging information when the image is loaded, relative to the image base.
;
;PointerToRawData
;    A file pointer to the debugging information.


;IMAGE_DEBUG_DIRECTORY	size=1ch

;---------



_RDATA_FILL:
	;ds	HEADER+0800h-$
	ALIGN	FILE_ALIGN	;200h

_RDATA_END:

