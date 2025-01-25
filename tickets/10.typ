= Модели памяти, организация программы с помощью точечных директив.
 
В программе на Ассемблере могут использоваться упрощенные (точечные) директивы.

```asm
.model <модель> ; --- определяет модель памяти, выделяемой ддля программы.
```

\<модель> --- одна из:

- tiny --- под всю программу один сегмент памяти;
- small --- по одному сегменту на данные и программу (не болеее 64Кб);
- medium --- под данные один сегмент, под программу несколько;
- compact --- под программу один сегмент, под данные несколько;
- large --- под данные и под программу выделяется по нескольку сегментов;
- huge --- позволяет использовать сегментов больше, чем потенциально может поместиться в оперативной памяти.

```asm
.model small

.stack 100h 

.data
    str1 db 'Lines1$'

.code
start:
    ; Инициализировать DS
    mov AX, @data
    mov DS, AX
    
    ; Вывести строку
    mov AH, 09h
    mov DX, offset str1
    int 21h 

    ; Выйти из программы
    mov AX, 4C00h
    int 21h 
end start
```
