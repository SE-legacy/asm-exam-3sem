= Директивы внешних ссылок, организация межмодульных связей.

Директивы внешних ссылок позволяют организовать связь между различными
модулями и файлами, расположенными на диске.
#align(center)[$p u b l i c <и м я>[, ...] [; к о м м е н т а р и и]$]
Директива public определяет указанные имена как глобальные величины, к которым можно обратиться из других модулей. <$и м я>$ — метка или имя переменной.
Чтобы обратиться к имени из другого модуля, можно использовать директиву
extrn:
#align(center)[$e x t r n <и м я>:<т и п>[, ...]$]

Если $<и м я>$ соответствует переменной, то $<т и п>$ — это один из byte, word, dword,
fword, …
Если $<и м я>$ — это метка, то $<т и п>$ — это near или far.
Пример организации межмодульной связи:

```asm
; Модуль A
public Value
.data
Value dw 0
; ...
; Модуль B
extrn Value:word
; ...
```