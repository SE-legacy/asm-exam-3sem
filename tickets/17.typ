= Команды побитовой обработки данных: логические операции, операции сдвига.

К командам побитовой обработки данных относятся логические команды, команды сдвига, установки, сброса и инверсии битов. Как и с арифметическими операциями, оба операнда не могут одновременно находиться в памяти.

*Логические операции:*
- ```asm
  and R/M, I,
  and R, R/M;
```

- ```asm
  or R/M, I,
  or R, R/M;
```

- ```asm
  xor R/M, I,
  xor R, R/M;
```

- not R/M --- not, в отличие от других логических операций, не меняет значение флагов;

Пример: 

```asm
xor EAX, EAX 
; Еще один способ обнулить значение
; регистра. При ассемблировании
; эта инструкция займет всего
; лишь 2 байта, плюс возможно
; будет работать быстрее, чем
; mov EAX, 0.
```
Общий формат команд арифметического и логического *сдвига*

#align(center)[
  ```asm 
    sXY <оп. 1>, <оп. 2> ;[ комментарий]
  ```
]

где

- X --- h (логический), a (арифметический),
- Y --- l (влево), r (вправо),
- \<оп. 1> --- регистр или память,
- \<оп. 2> --- константа или младшие 5 бит регистра CL.

#align(center)[
  #image("../images/img18_1.png", width: 70%)
]

Логический сдвиг можно также считать _беззнаковым сдвигом_. То есть при сдвиге вправо образовавшиеся пустые места заполняются 0. При арифметическом сдвиге вправо, пустые места заполняются копиями старшего (знакового) бита. Поэтому его называют _знаковым сдвигом_.

При любом типе сдвига последний «ушедший» из числа бит помещается в CF. Замечание: shl и sal синонимичны.

Расширенные инструкции сдвигов (i186 и новее):

$
  s h r d space R\/M,space R,space I 8\/C L\
  s h l d space R\/M,space R,space I 8\/C L
$
Содержимое R/M сдвигается на количество разрядов I8/CL, аналогично shr и
shl, но пустые биты заполняются битами из операнда R:
- для сдвига вправо --- начиная с самого старшего бита R/M, младшие биты R «задвигаются» в пустые ячейки;
- для сдвига влево --- начиная с самого младшего бита R/M, старшие биты R «задвигаются» в пустые ячейки.

*Циклические сдвиги:*
- rol, ror --- выполняют циклические сдвиги, причем последний вышедший из разрядной сетки бит оказывается в CF.
- rcl, rcr --- выполняют циклические сдвиги, причем значение флага CF тоже используется и в первую очередь оказывается в числе (см. картинку 2).
