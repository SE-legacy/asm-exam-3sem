= Команды двоичной арифметики: сложение, вычитание, умножение и деление.

*Сложение и вычитание *чисел выполняется по правилам, аналогичным сложению и вычитанию по модулю $2^ k$ , принятым в математике.

В Ассемблере, если в результате получается более _k_ разрядов, то _(k + 1)_-й пересылается в флаг CF.

#align(center)[
  $X + Y = (X + Y ) space m o d 2^ k = X + Y and C F = 0,$ если $X + Y < 2^ k$

  $X + Y = (X + Y ) space m o d 2^ k = X + Y − 2^ k and C F = 1,$ если $X + Y gt.eq 2$
]


Пример (для байтов):
#align(center)[
  $250 + 10 = 260 = 100000100_2,$ и результат: $00000100_2 = 4$, $C F = 1$

  $X − Y = (X − Y ) space m o d 2 ^k = X − Y and C F = 0,$ если $X gt.eq Y$

  $X − Y = (X − Y ) space m o d 2^ k = X + 2^k − Y and C F = 1,$ если $X < Y$
]

Пример (для байтов):
  $ 1 − 2 = 1 + 2^8 − 2 = 257 − 2 = 255, C F = 1 $

Важно помнить, что компьютеры не умеют «вычитать». Любая операция вычитания требует предварительного перевода вычитаемого числа в дополнительный код
(_two’s complement_).

Например, в том же примере 1 --- 2, к результату можно прийти так:
#align(center)[
  $−2 = −00000010_2$

  Доп. код: $2^8 − 2 = 11111110_2$

  $1 − 2 = 00000001_2 + 11111110_2 = 11111111_2, C F = 1,$

  так как был заем для старшего разряда.
]

Результат можно интерпретировать по-разному: как беззнаковое число 255 или как дополнительный код знакового числа −1. То есть компьютеру не важно, знаковая операция или беззнаковая. Программист сам решает это, исходя из задачи и ориентируясь на флаги.

Инструкции Ассемблера, выполняющие сложение и вычитание:
- add R/M, R/I,

  add R, M;
- xadd R/M, R (i486 и новее) --- обменять операнды местами, после выполнить
сложение;

- adc R/M, R/I,

  adc R, M --- _add with carry_, сложить два операнда, после прибавить значение
флага CF;

- inc R/M;

- sub R/M, R/I,

  sub R, M;

- sbb R/M, R/I,

  sbb R, M --- _subtract with borrow_, вычесть второй операнд из первого, после
вычесть значение флага CF;

- dec R/M;

*Умножение:*
- mul R/M --- беззнаковое умножение. В зависимости от размера операнда, выполняется одна из операций:

  - если byte, то R/M $*$ AL $->$ AX;

  - если word, то R/M $*$ AX $->$ DX:AX;

  - если dword, то R/M $*$ EAX $->$ EDX:EAX.

- imul R/M --- знаковое умножение. Есть также версии, появившиеся с i386 (imul R, R/M/I) и i186 процессором (imul R, R/M, I).
Если в результате умножения CF = OF = 1, то результат занимает двойной формат, если CF = OF = 0, то результат уместился в размере одного сомножителя.

*Деление*
- div R/M --- беззнаковое деление. В зависимости от размера операнда, значения AX, DX:AX или EDX:EAX делятся на него, и целая часть помещается в AL, AX или EAX, а остаток в AH, DX, EDX.

- idiv R/M --- знаковое деление.

Программисту нужно следить, чтобы случайно не разделить на 0.
