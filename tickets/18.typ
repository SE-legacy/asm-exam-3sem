= Работа с массивами в Ассемблере.

*Массивы* создаются при помощи директив определения данных (чаще всего с использованием dup(?)):

```asm
Arr dw 30 dup(?)
```

Адресация в одномерных массимвах:

#align(center)[
  ```asm
  адрес (Arr[i]) = Arr + i * размер (Arr[i])
  ```
]

Адресация в двумерных массивах (двумерный массив $n times m$):

#align(center)[
  ```asm
  адрес(Arr[i][j]) = Arr + i * m * размер (Arr[i][j]) + j * размер(Arr[i][j])
  ```
]

*размер()* --- число, соответствующее размеру в байтах одного элемента массива. Например, если массив был задан при помощи $d d$, то размер каждого элемента будет 4.

Для одномерных массивов удобнее всего будет использовать аресацию *прямую с индексированием:*

#align(center)[
  ```asm
  Arr[i]
  ```
]

Для двумерных массивов --- *по базе с индексированием:*


```asm
Arr dd 64 dup(128 dup(?))
; ...
Arr[BX][DI]   ; Две переменные:
              ; BX = i * 128 * размер(Arr[i][j])
              ; DI = j * размер(Arr[i][j])
```
