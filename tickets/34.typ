= Примеры использования директив условной генерации

*Пример использования* ДУА --- включение/отключение отладочного вывода программы:

```asm
DEBUG equ 1     ; отладка

    mov x, AX
  if DEBUG
    PrintInt x
  endif
    mov BX, 0
```

Другие примеры использования ДУА:

```asm
; Очень плохой пример, но он был в презентации, поэтому лучше ознакомиться с ним, чем нет.

; Макрос, выполняющий операцию логического сдвига значения переменной x на n разрядов вправо.

Shift macro x, n
    ife n - 1
        shr x, 1
    else
        mov CL, n
        shr x, CL
    endif
endm

    Shift A, 5    ; mov CL, 5
                  ; shr A, CL
```

```asm
; Макрос, устанавливающий в переменную x значение 0.

Set_0 macro x
    if type x eq dword
        mov dword ptr x, 0
    elseif type x eq word
        mov word ptr x, 0
    else
        mov byte ptr x, 0
    endif
endm
```
