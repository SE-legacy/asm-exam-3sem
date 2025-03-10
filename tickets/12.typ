= Исполняемые COM-файлы, их отличие от EXE-файлов, примеры.

В DOS существует два типа исполняемых файлов: EXE и COM-файлы.

COM-файл обязательно должен иметь модель памяти tiny. Поэтому в нем может быть только один сегмент, объединяющий в себе данные и исполняемые инструкции. Отсюда возникает ограничение на размер COM-файла: 64 КБ.

Кроме этого, COM-файл не содержит в себе никакой дополнительной информации; в то время как у каждого EXE-файла должен быть заголовок, начинающийся со строки "MZ" и хранящий информацию такую, как начальные значения CS:IP (точка входа), SS, SP.

Это отражается на процессе написания DOS программ: в начале каждого COM-файла должна быть использована директива org 100h, которая «перепрыгнет» специальную структуру PSP размером 256 байт, создающуюся в памяти при запуске любой программы DOS.

Пример COM-программы:
```asm
.model tiny
.code
org 100h
start:
    mov AH, 09h
    lea DX, Str1
    int 21h
    mov AX, 4C00h
    int 21h
;==========================
;       data
;==========================
    Str1 db 'Hello', '$'
end start
```
Аналогичная EXE-программа, модель small:
```asm
.model small
.stack 100h
.data
Str1 db 'Hello', '$'
.code
start:
  mov AX, @data
  mov DS, AX

  mov AH, 09h
  lea DX, Str1
  int 21h

  mov AX, 4C00h
  int 21h
end start
```
Процесс сборки COM-программы будет отличаться от процесса сборки EXE-программы. На этапе связывания, для EXE команда будет:

TLINK.EXE PROG.OBJ

А для COM:

TLINK.EXE /T PROG.OBJ
