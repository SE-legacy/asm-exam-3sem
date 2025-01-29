= Структуры в ассемблере и их использование.

Структура состоит из полей различного типа и длины, занимая последовательные байты памяти.

После объявления структуры можно создавать переменные, для которых структура является прототипом.

*Описание структуры*:
#align(center)[
  ```asm
  <имя типа> struc
      <описание поля>
      ...
  <имя типа> ends
  ```
]

*\<имя типа>* --- имя, которое будет использоваться при описании переменных типа этой структуры.

Для описания полей используются директивы $d X$. Но имена, использующиеся с этими директивами, не локализованы, и поэтому должны быть уникальны для всей программы. Поля не могут иметь тип структуры. Поля могут имерть *значения по умолчанию*, а могут не иметь (?).

Пример объявления структуры:

```asm
Date struc
    y dw 2000
    m db ?
    d db 28
Date ends
```

#align(center)[
  #image("../images/img22_1.png", width: 70%)
]

Использование структуры:

#align(center)[
  ```asm
  имя_переменной имя_структуры <начальное_значение, ...>
  ```
]

\<> --- служебные символы, внутри которых через запятую указываются *начальные значения полей* (?, строковые литералы, константные выражения или ничего).

Пример объявления переменных структурного типа:


```asm
dt1 Date <?, 6, 4>
dt2 Date <1999, , >
dt3 Date < , , >
```

В приоритете всегда будет начальное значение, указанное при объявлении переменной, даже если в объявлении структуры у него есть значение по умолчанию.

При объявлении переменной, можно не указывать начальные значения *последних* полей и сразу поставить знак >. Но для *первых* полей нужно проставить запятые, означающие $quote.angle.l п у с т о т у quote.angle.r$

```asm
dt4 Date <1980>   ; то же самое, что <1980, , >
dt5 Date < , , 5> ; нельзя просто <5>
```

Можно не указывать никаких начальных значений, а просто использовать значения по умолчанию:

```asm
dt6 Date < >
```

Пример объявления массива переменных структурного типа:

```asm
; Массив из 25 элементов типа Date. Первый элемент имеет начальное значение < , 4, 1>
; Остальные 24 элемента используют значения по умолчанию.
dts Date < , 4, 1>, 24 dup(< >)
```

С начальными значениями есть сложности:

+ Нельзя присваивать начальное значение полям-массивам (arr dw 1, 2, 3). Но в случае db можно использовать в качестве начального значения строку.
+ Поле-строка, объявленное любым образом (s db 10 dup(?), t, db 21 dup(0), v db 's', 't', 'r'), может иметь начальное значение, но
  - Начальное значение не должно быть длинее значения по умолчанию.
  - Если начальное значение короче значения по умолчанию, то оно в конце дополняется пробелами.

*Обращение к полям структуры:*

#align(center)[
  ```asm
  имя_переменной.имя_поля
  ```
]

Оператор . вычисляет адрес так:

#align(center)[
  ```asm
  <адресное выфражение> + <смещение поля в структуре>
  ```
]

\<адресное выфражение> может быть любой сложности:

```asm
mov AX, (dts + 8).y
; ...
mov SI, 8
inc (dts[SI]).m 
; ...
lea BX, dt1
mov [BX].d, 10
```

Полезный оператор *type* возвращает размер типа данных в байтах:

#align(center)[
  type Date = type dt1 = 4

  type dt1.m = type m = 1

  type (dts[SI]).m = type (dts[SI].m) = 1

  type dts[SI].m = type dts = 4
]

Пример обращения к полям структуры:

```asm
.model tiny

.code

org 100h

start:
    ; Вывод "hello \r\n"
    mov AH, 9
    mov DX, offset Message
    int 21h 
    
    lea BX, st1       ; адрес первой записи
    mov CX, 2         ; кол-во повторений внешнего цикла

l2:
    push CX
    mov SI, 0
    mov CX, 3         ; кол-во повторений внутреннего цикла
l1:
    ; Вывод одного поля структуры
    push CX
    lea DX, [BX][SI]  ;адресация по базе с индексированием
    int 21h 
    

    ; поскольку первое и второе поле имеют длину 9 байт, то прибавить 9 к SI
    add SI, 9         ; переход к следующему полю
    pop CX
    loop l1
    
    add BX, type TStudent   ; переод к следующему полю
    pop CX
    loop l2

    ret

    Message db "hello", 0Dh, 0Ah, "$"

    TStudent struc          ; описание структуры TStudent
        s db 9 dup(?)
        f db 9 dup(?)
        i db 9 dup(?)
    TStudent ends

    ; Две переменные структурного типа TStudent
    st1 TStudent <"student $", "Ivanov $", "Ivan $">
    st2 TStudent <"student $", "Petrov $", "Petr $">
end start
```
