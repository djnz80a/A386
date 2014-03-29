#!/bin/sh
# replace "DEFS n" to "TIME n DB 0"
# replace "ES:[BX(+n)]" to "[ES:BX(+n)]"
# -b to "not convert crlf with cygwin sed"

if [ ! -d "tmp_nasm" ]; then
mkdir tmp_nasm
fi

for f in  \
A386A.ASM \
A386R.ASM \
ASM-COM.ASM \
ASM-COMD.ASM \
DEBUG-C.ASM \
HEADER-C.ASM \
IMPORT-C.ASM \
PUTDEB-C.ASM \
WRCOFF-C.ASM \
WRWIN-A.ASM \
WRWIN-R.ASM;

do echo "converting $f for nasm";

echo -e "\tbits 32\n\n" > tmp_nasm/$f;
bash -c "cat $f | \
sed -b -e 's/#INCLUDE[ \t]<\(.*\)>/%include \"\1\"/' | \
sed -b -e 's/\bDEFS[ \t]\+\([^;]*\)\b/TIMES \1 DB 0/' | \
sed -b -e 's/ES:\[BX\(.*\)\]/[ES:BX\1]/' " >> tmp_nasm/$f ;

done

