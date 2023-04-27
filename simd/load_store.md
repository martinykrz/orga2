# Load/Store
* ***MOV***e 32-bits (***D***ouble) -> xmm0
```asm
movd xmm0, eax
```
* ***MOV***e 64-bits (***Q***uad) -> xmm0
```asm
movq xmm0, rax
```
* ***MOV***e 32-bits (***S***ingle precision) -> xmm0
```asm
movss xmm0, [rax]
```
* ***MOV***e 64-bits (***D***ouble precision) -> xmm0
```asm
movsd xmm0, [rax] 
```
* ***MOV***e 128-bits (***D***ouble ***Q***uad) ***A***lign xmm1 -> xmm0
```asm
movdqa xmm0, xmm1
```
* ***MOV*** 128-bits (***D***ouble ***Q***uad) ***U***nalign xmm1 -> xmm0
```asm
movdqu xmm0, xmm1 
```
* ***MOV***e 4 ***A***lign 32-bits ***P***acked (***S***ingle precision)
```asm
movaps xmm0, xmm1 
```
* ***MOV***e 4 ***U***nalign 32-bits ***P***acked (***D***ouble precision)
```asm
movups xmm0, xmm1 
```
* ***MOV***e 2 ***A***lign 64-bits ***P***acked (***D***ouble precision)
```asm
movapd xmm0, xmm1 
```
* ***MOV***e 2 ***U***nalign 64-bits ***P***acked (***D***ouble precision)
```asm
movupd xmm0, xmm1  
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***B***yte -> ***W***ord
```asm
pmovsxbw xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***B***yte -> ***W***ord
```asm
pmovzxbw xmm0, xmm1
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***B***yte -> ***D***ouble word
```asm
pmovsxbd xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***B***yte -> ***D***ouble word
```asm
pmovzxbd xmm0, xmm1
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***B***yte -> ***Q***uad word
```asm
pmovsxbq xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***B***yte -> ***Q***uad word
```asm
pmovzxbq xmm0, xmm1
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***W***ord -> ***D***ouble word
```asm
pmovsxwd xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***W***ord -> ***D***ouble word
```asm
pmovzxwq xmm0, xmm1
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***W***ord -> ***Q***uad word
```asm
pmovsxwq xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***W***ord -> ***Q***uad word
```asm
pmovzxwq xmm0, xmm1
```
* ***P***acked, ***MOV***e with ***S***ign and e***X***tend a ***D***ouble word -> ***Q***uad word
```asm
pmovsxdq xmm0, xmm1 
```
* ***P***acked, ***MOV***e with ***Z***ero and e***X***tend a ***D***ouble word-> ***Q***uad word
```asm
pmovzxdq xmm0, xmm1
```
