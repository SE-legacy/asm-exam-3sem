= Директивы определения данных и памяти.
Общий вид директивы определения данных:

```asm
[<с и м в. и м я>] d X <о п е р а н д>[, ...] ;[ к о м м е н т а р и и]
```

где X — это b, w, d, f, q или t.

Операндов может быть один или несколько, каждый операнд должен быть константым выражением (числом), строковым литералом или символом ?. Директива
гарантирует выделение указанного объема оперативной памяти под операнд, инициализацию области начальным значением (если не используется ?)
```asm .data
  R1 db 0, ?, 0 ; выделено 3 байта, нулевой и второй
                ; инициализированы нулями, первый
                ; не инициализируется```
Другой вариант директивы dX, упрощающий выделение памяти под массивы:

```asm
[<с и м в. и м я>] d X <к о н с т. в ы р.> d u p(<о п е р а н д>) ;[ к о м м е н т а р и и]
```

Она выделит память под \<к о н с т. в ы р.> значений и инициализирует каждую ячейку значением \<о п е р а н д>.
Замечание: директивой db нельзя определить строковую константу длиной более
255 символов, а вместе с dw нельзя использовать строковые литералы длиной более
двух символов.
