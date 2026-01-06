= Передача параметров через стек, пример

#figure()[
  #image("../images/img26_1.png", width: 80%)
]

Адрес возврата --- адрес следующей за *call* команды. На рисунке отображено состояние стека до и после вызова процедуры, принимающей _n_ параметров через стек.

*Важно*: Стоит помнить, что команда *push* принимает в качестве единственного операнда только регистры, там не может использоваться имя переменной. Кроме того, с помощью команды *push* нельзя положить в стек значение меньше машинного слова.

Обращение к таким переменным в процедуре:

```asm
Func proc near
    push BP   ; Сохраним старое значение BP в стеке
    mov BP, SP
    ; [BP + 4] = n-й параметр
    ; [BP + 6] = (n - 1)-й параметр
    ; ...
    pop BP 
    ret 2 * n 
Func endp
```

#figure()[
  #image("../images/img26_2.png", width: 80%)
]

Пример подпрограммы, обнуляющей переданный ей массив байтов. Адрес массива передается первым параметром, размер массива --- вторым. Вызывающая программа должна положить эти значения в стек в обратном порядке.
```asm
ArrZero proc
    Param_Arr equ [BP + 4]
    Param_Size equ [BP + 6]
    
    push BP
    mov BP, SP

    push AX
    push BX
    push CX

    xor AX, AX
    mov BX, Param_Arr
    mov CX, Param_Size
l1:
    mov [BX], AX
    inc BX
    loop l1

    pop CX
    pop BX
    pop AX

    pop BP
    ret 2 * 2 
ArrZero endp

; Вызов:
mov AX, ArrSize
push AX
lea AX, Arr 
push AX
call ArrZero
```
