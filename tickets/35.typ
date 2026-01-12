= Логические выражения в директивах условной генерации

- Макрос, выполняющий сдвиг байтового значения `x` на $n$ бит вправо, если $0 < n < 8$:

  ```asm
  RShiftByte macro x, n
      if (n gt 0) and (n lt 8)
          mov CL, n
          shr x, CL
      elseif n ge 8
          mov x, byte ptr 0
      endif
  endm
  ```
- Поиск $max$ или $min$ из двух знаковых величин, хранящихся в байтовых регистрах, операция передается в `T`, результат помещается в `R1`:

  ```asm
  Max_Min macro R1, R2, T
      local L
      ifdif <R1>, <R2>
          cmp R1, R2
          ifidni <T>, <max>
              jge L
          else
              jle L
          endif
          mov R1,R2
      L: endif
  endm
  ```
