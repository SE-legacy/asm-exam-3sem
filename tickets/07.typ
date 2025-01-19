= Команды пересылки, особенности их использования.

*Команды пересылки* позволяют копировать данные из регистра в регистр, из памяти в регистр и из регистра в память. Но у них есть свои особенности использоавния:

+ Нельзя переслать информацию из памяти в память.
+ Нельзя переслать информацию из одного сегментного регистра в другой.
+ Нельзя переслать константное выражение в сегментный регистр напрямую.
+ Значение в *CS* не может быть изменено командой *mov*.
+ Байты в памяти хранятся в прямом порядке, а регистрах --- в обратном

  (Следующий абзац от создателя прошлой pdf, хз насколько он нужен)

  Да, кончено, некорректно говорить, что в регистрах байты хранятся $quote.angle.l$в обратном порядке$quote.angle.r$. Здесь, точно так же, как и в памяти, байты хранятся в порядке увеличения их номеров. Просто память обычно изображается как вещь, растущаю справа налево, а регистр --- как вещь, имеющая младшие байты справа, а старшие слева.

  ```asm
  ; ...
  R dw 1234h  ; В байте с адресом R --- 34h
              ; В байте с адресом (R + 1) --- 12h
  ; ...
  mov AX, R   ; AH = 12h, AL = 34h
  ```
+ Размер передаваемых данных определеятся типом операндов в команде.

  Это важно, поскольку команда *mov [SI]*, 0 вызовет ошибку сборки. В этом случае надо использовать оператор
  ```asm
  <тип> ptr <выражение>
  ```
  Выражение --- константное или адресное, тип --- размер области памяти: byte, word, dword, qword.
  
  Тогда следующие команды будут допустимыми и эквивалентными:
  ```asm
  mov byte ptr [SI], 0
  или 
  mov [SI], byte ptr 0
  ```
+ В командах с двумя операндами, тип одного операнда должен совпадать с типом другого.
