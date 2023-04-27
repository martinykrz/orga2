# Desempaquetado
* ***P***acked, ***UNPCK*** ***L***ow part in 8 ints of ***B***ytes -> ***W***ords
```asm
punpcklbw xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***L***ow part in 4 ints of ***W***ords -> ***D***oubles
```asm
punpcklwd xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***L***ow part in 2 ints of ***D***oubles -> ***Q***uad
```asm
punpckldq xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***L***ow part in 1 int of ***Q***uad -> ***D***ouble ***Q***uad
```asm
punpcklqdq xmm0, xmm1
```
* ***UNPCK*** ***L***ow part of ***P***acked ***S***ingle precision
```asm
unpcklps xmm0, xmm1
```
* ***UNPCK*** ***L***ow part of ***P***acked ***D***ouble precision
```asm
unpcklpd xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***H***igh part in 8 ints of ***B***ytes -> ***W***ords
```asm
punpckhbw xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***H***igh part in 4 ints of ***W***ords -> ***D***oubles
```asm
punpckhwd xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***H***igh part in 2 ints of ***D***oubles -> ***Q***uad
```asm
punpckhdq xmm0, xmm1
```
* ***P***acked, ***UNPCK*** ***H***igh part in 1 int of ***Q***uad -> ***D***ouble ***Q***uad
```asm
punpckhqdq xmm0, xmm1
```
* ***UNPCK*** ***H***igh part of ***P***acked ***S***ingle precision
```asm
unpckhps xmm0, xmm1
```
* ***UNPCK*** ***H***igh part of ***P***acked ***D***ouble precision
```asm
unpckhpd xmm0, xmm1
```

