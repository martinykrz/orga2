# Comparacion
* ***P***acked, ***CMP*** xmm0 ***EQ***ual xmm1 by ***B***yte
```asm
pcmpeqb xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***EQ***ual xmm1 by ***W***ord
```asm
pcmpeqw xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***EQ***ual xmm1 by ***D***ouble
```asm
pcmpeqd xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***EQ***ual xmm1 by ***Q***uad
```asm
pcmpeqq xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***G***reater ***T***han xmm1 by ***B***yte
```asm
pcmpgtb xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***G***reater ***T***han xmm1 by ***W***ord
```asm
pcmpgtw xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***G***reater ***T***han xmm1 by ***D***ouble
```asm
pcmpgtd xmm0, xmm1
```
* ***P***acked, ***CMP*** xmm0 ***G***reater ***T***han xmm1 by ***Q***uad
```asm
pcmpgtq xmm0, xmm1
```
* ***CMP*** xmm0 ***XX*** xmm1 ***P***acked ***S***ingle precision
* ***CMP*** xmm0 ***XX*** xmm1 ***S***calar ***S***ingle precision
* ***CMP*** xmm0 ***XX*** xmm1 ***P***acked ***D***ouble precision
* ***CMP*** xmm0 ***XX*** xmm1 ***S***calar ***D***ouble precision
| ***XX*** | ***CMP*** |
| :---: | :---: |
| ***EQ*** | `A = B` |
| ***LT*** | `A < B` |
| ***LE*** | `A <= B` |
| ***UNORD*** | `A, B = unordered` |
| ***NEQ*** | `A != B` |
| ***NLT*** | `not(A < B)` |
| ***NLE*** | `not(A <= B)` |
| ***ORD*** | `A, B = ordered` |
* ***COM***pare if ***I***n order a ***S***calar ***S***ingle precision
```asm
comiss xmm0, xmm1
```
* ***COM***pare if ***I***n order a ***S***calar ***D***ouble precision
```asm
comisd xmm0, xmm1
```
