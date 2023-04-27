# Logicas
* ***P***acked, xmm0 ***AND*** xmm1
```asm
pand xmm0, xmm1
```
* ***P***acked, xmm0 ***ANDN*** xmm1 
```asm
pandn xmm0, xmm1
```
* ***P***acked, xmm0 ***OR*** xmm1
```asm
por xmm0, xmm1
```
* ***P***acked, xmm0 ***XOR*** xmm1
```asm
pxor xmm0, xmm1
```
* xmm0 ***AND*** xmm1 for ***P***acked 32-bit float (***S***ingle precision)
```asm
andps xmm0, xmm1
```
* xmm0 ***ANDN*** xmm1 for ***P***acked 32-bit float (***S***ingle precision)
```asm
andnps xmm0, xmm1
```
* xmm0 ***OR*** xmm1 for ***P***acked 32-bit float (***S***ingle precision)
```asm
orps xmm0, xmm1
```
* xmm0 ***XOR*** xmm1 for ***P***acked 32-bit float (***S***ingle precision)
```asm
xorps xmm0, xmm1
```
* xmm0 ***AND*** xmm1 for ***P***acked 64-bit float (***D***ouble precision)
```asm
andps xmm0, xmm1
```
* xmm0 ***ANDN*** xmm1 for ***P***acked 64-bit float (***D***ouble precision)
```asm
andnps xmm0, xmm1
```
* xmm0 ***OR*** xmm1 for ***P***acked 64-bit float (***D***ouble precision)
```asm
orps xmm0, xmm1
```
* xmm0 ***XOR*** xmm1 for ***P***acked 64-bit float (***D***ouble precision)
```asm
xorps xmm0, xmm1
```
* ***P***acked, ***S***hift ***L***eft ***L***ogical each ***W***ord by bit
```asm
psllw xmm0, CTE
```
* ***P***acked, ***S***hift ***L***eft ***L***ogical each ***D***ouble by bit
```asm
pslld xmm0, CTE
```
* ***P***acked, ***S***hift ***L***eft ***L***ogical each ***Q***uad by bit
```asm
psllq xmm0, CTE
```
* ***P***acked, ***S***hift ***L***eft ***L***ogical each ***D***ouble ***Q***uad by byte
```asm
pslldq xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***L***ogical each ***W***ord by bit
```asm
psllw xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***L***ogical each ***D***ouble by bit
```asm
pslld xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***L***ogical each ***Q***uad by bit
```asm
psllq xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***L***ogical each ***D***ouble ***Q***uad by byte
```asm
pslldq xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***A***ritmethically each ***W***ord by bit
```asm
psraw xmm0, CTE
```
* ***P***acked, ***S***hift ***R***ight ***A***ritmethically each ***D***ouble by bit
```asm
psrad xmm0, CTE
```

