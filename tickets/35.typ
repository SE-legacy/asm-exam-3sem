= Логические выражения в директивах условной генерации.

```asm
; Макрос, выполняющий сдвиг байтового значения
; x на n бит вправо, если 0 < n < 8.
RShiftByte macro x, n
    if (n gt 0) and (n lt 8)
        mov CL, n
        shr x, CL
    elseif n ge 8
        mov x, byte ptr 0
    endif
endm
```

```asm
; Макрос вычисляет минимум или максимум из двух величин
; помещает результат в R1. Имя операции передается в T.
Max_Min macro R1, R2, T
      local L
      ifdifi <R1>, <R2>     ; R1 и R2 --- разные регистры
          cmp R1, R2
          ifidni <T>, <max> ; T == max
              jge L
          else
              jle L
          endif
L:
          mov R1, R2
      endif
endm
```
