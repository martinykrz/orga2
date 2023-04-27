# Aritmeticas

## Table of Content
- [Integers](#integers)
    - [Addition](#addition)
        - [Roll Over](#roll-over)
        - [Saturation](#saturation)
            - [With Sign](#with-sign)
            - [Without Sign](#without-sign)
    - [Subtraction](#subtraction)
        - [Roll Over](#roll-over-1)
        - [Saturation](#saturation-1)
            - [With Sign](#with-sign-1)
            - [Without Sign](#without-sign-1)
    - [Multiplication](#multiplication)
        - [Low part](#low-part)
        - [High part](#high-part)
    - [Minimum](#minimum)
        - [With Sign](#with-sign-2)
        - [Without Sign](#without-sign-2)
    - [Maximum](#maximum)
        - [With Sign](#with-sign-3)
        - [Without Sign](#without-sign-3)
    - [Absolute](#absolute)
    - [Horizontal](#horizontal)
        - [Addition](#addition-1)
        - [Subtraction](#subtraction-1)
- [Float Point](#float-point)
    - [Addition](#addition-2)
        - [Packed](#packed)
        - [Scalar](#scalar)
    - [Subtraction](#subtraction-2)
        - [Packed](#packed-1)
        - [Scalar](#scalar-1)
    - [Multiplication](#multiplication-1)
        - [Packed](#packed-2)
        - [Scalar](#scalar-2)
    - [Division](#division-1)
        - [Packed](#packed-3)
        - [Scalar](#scalar-3)
    - [Maximum](#maximum-1)
        - [Packed](#packed-4)
        - [Scalar](#scalar-4)
    - [Minimum](#minumum-1)
        - [Packed](#packed-5)
        - [Scalar](#scalar-5)
    - [Square root](#square-root)
        - [Packed](#packed-6)
        - [Scalar](#scalar-6)
    - [Horizontal](#horizontal-1)
        - [Addition](#addition-3)
        - [Subtraction](#subtraction-3)

## Integers 

### Addition 

### Roll Over 
* ***P***acked, ***ADD*** ***B***yte by byte
```asm
paddb xmm0, xmm1
```
* ***P***acked, ***ADD*** ***W***ord by word
```asm
paddw xmm0, xmm1
```
* ***P***acked, ***ADD*** ***D***ouble by double
```asm
paddd xmm0, xmm1
```
* ***P***acked, ***ADD*** ***Q***uad by ***Q***uad
```asm
paddq xmm0, xmm1
```

### Saturation 

#### With Sign 
* ***P***acked, ***ADD*** ***S***aturated ***B***yte by byte
```asm
paddsb xmm0, xmm1
```
* ***P***acked, ***ADD*** ***S***aturated ***W***ord by word
```asm
paddsw xmm0, xmm1
```

#### Without Sign 
* ***P***acked, ***ADD*** ***U***nsign ***S***aturated ***B***yte by byte
```asm
paddusb xmm0, xmm1
```
* ***P***acked, ***ADD*** ***U***nsign ***S***aturated ***W***ord by word
```asm
paddusw xmm0, xmm1
```

## Subtraction

### Roll Over 
* ***P***acked, ***SUB*** ***B***yte by byte
```asm
psubb xmm0, xmm1
```
* ***P***acked, ***SUB*** ***W***ord by word
```asm
psubw xmm0, xmm1
```
* ***P***acked, ***SUB*** ***D***ouble by double
```asm
psubd xmm0, xmm1
```
* ***P***acked, ***SUB*** ***Q***uad by ***Q***uad
```asm
psubq xmm0, xmm1
```

### Saturation 

#### With Sign 
* ***P***acked, ***SUB*** ***S***aturated ***B***yte by byte
```asm
psubsb xmm0, xmm1
```
* ***P***acked, ***SUB*** ***S***aturated ***W***ord by word
```asm
psubsw xmm0, xmm1
```

#### Without Sign 
* ***P***acked, ***SUB*** ***U***nsign ***S***aturated ***B***yte by byte
```asm
psubusb xmm0, xmm1
```
* ***P***acked, ***SUB*** ***U***nsign ***S***aturated ***W***ord by word
```asm
psubusw xmm0, xmm1
```

## Multiplication

### Low part
* ***P***acked, ***MUL***tiply and store the ***L***ow 16-bits (***W***ord) of the 32-bit product
```asm
pmullw xmm0, xmm1
```
* ***P***acked, ***MUL***tiply and store the ***L***ow 32-bits (***D***ouble) of the 64-bit product
```asm
pmulld xmm0, xmm1
```

### High part
* ***P***acked, ***MUL***tiply and store the ***H***igh 16-bits (***W***ord) of the 32-bit product
```asm
pmulhw xmm0, xmm1
```
* ***P***acked, ***MUL***tiply and store the ***H***igh 32-bits (***D***ouble) of the 64-bit product
```asm
pmulhd xmm0, xmm1
```

### Minimum

#### With Sign 
* ***P***acked, find ***MIN***imum ***S***ign ***B***yte between xmm0 and xmm1
```asm
pminsb xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***S***ign ***W***ord between xmm0 and xmm1
```asm
pminsw xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***S***ign ***D***ouble between xmm0 and xmm1
```asm
pminsd xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***S***ign ***Q***uad between xmm0 and xmm1
```asm
pminsq xmm0, xmm1
```

#### Without Sign 
* ***P***acked, find ***MIN***imum ***U***nsign ***B***yte between xmm0 and xmm1
```asm
pminsb xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***U***nsign ***W***ord between xmm0 and xmm1
```asm
pminsw xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***U***nsign ***D***ouble between xmm0 and xmm1
```asm
pminsd xmm0, xmm1
```
* ***P***acked, find ***MIN***imum ***U***nsign ***Q***uad between xmm0 and xmm1
```asm
pminsq xmm0, xmm1
```
### Maximum

#### With Sign 
* ***P***acked, find ***MAX***imum ***S***ign ***B***yte between xmm0 and xmm1
```asm
pmaxsb xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***S***ign ***W***ord between xmm0 and xmm1
```asm
pmaxsw xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***S***ign ***D***ouble between xmm0 and xmm1
```asm
pmaxsd xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***S***ign ***Q***uad between xmm0 and xmm1
```asm
pmaxsq xmm0, xmm1
```

#### Without Sign 
* ***P***acked, find ***MAX***imum ***U***nsign ***B***yte between xmm0 and xmm1
```asm
pmaxsb xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***U***nsign ***W***ord between xmm0 and xmm1
```asm
pmaxsw xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***U***nsign ***D***ouble between xmm0 and xmm1
```asm
pmaxsd xmm0, xmm1
```
* ***P***acked, find ***MAX***imum ***U***nsign ***Q***uad between xmm0 and xmm1
```asm
pmaxsq xmm0, xmm1
```

### Absolute
* ***P***acked, make ***ABS***olute for 8-bits (***B***yte)
```asm
pabsb xmm0, xmm1
```
* ***P***acked, make ***ABS***olute for 16-bits (***W***ord)
```asm
pabsw xmm0, xmm1
```
* ***P***acked, make ***ABS***olute for 32-bits (***D***ouble)
```asm
pabsd xmm0, xmm1
```

### Horizontal

#### Addition
* ***P***acked, ***H***orizontal ***ADD*** of 16-bit (***W***ord)
```asm
phaddw xmm0, xmm1
```
* ***P***acked, ***H***orizontal ***ADD*** of 32-bit (***D***ouble)
```asm
phaddd xmm0, xmm1
```
* ***P***acked, ***H***orizontal ***ADD*** ***S***aturated of 16-bit (***W***ord)
```asm
phaddsw xmm0, xmm1
```

#### Subtraction
* ***P***acked, ***H***orizontal ***SUB*** of 16-bit (***W***ord)
```asm
phsubw xmm0, xmm1
```
* ***P***acked, ***H***orizontal ***SUB*** of 32-bit (***D***ouble)
```asm
phsubd xmm0, xmm1
```
* ***P***acked, ***H***orizontal ***SUB*** ***S***aturated of 16-bit (***W***ord)
```asm
phsubsw xmm0, xmm1
```

## Float Point

### Addition 

#### Packed 
* ***ADD*** ***P***acked 32-bit float (***S***ingle precision)
```asm
addps xmm0, xmm1
```
* ***ADD*** ***P***acked 64-bit float (***D***ouble precision)
```asm
addpd xmm0, xmm1
```

#### Scalar
* ***ADD*** ***S***calar 32-bit float (***S***ingle precision)
```asm
addss xmm0, xmm1
```
* ***ADD*** ***S***calar 64-bit float (***D***ouble precision)
```asm
addsd xmm0, xmm1
```

### Subtraction

#### Packed
* ***SUB*** ***P***acked 32-bit float (***S***ingle precision)
```asm
subps xmm0, xmm1
```
* ***SUB*** ***P***acked 64-bit float (***D***ouble precision)
```asm
subpd xmm0, xmm1
```

#### Scalar
* ***SUB*** ***S***calar 32-bit float (***S***ingle precision)
```asm
subss xmm0, xmm1
```
* ***SUB*** ***S***calar 64-bit float (***D***ouble precision)
```asm
subsd xmm0, xmm1
```

### Multiplication

#### Packed
* ***MUL***tiply ***P***acked 32-bit float (***S***ingle precision)
```asm
mulps xmm0, xmm1
```
* ***MUL***tiply ***P***acked 64-bit float (***D***ouble precision)
```asm
mulpd xmm0, xmm1
```

#### Scalar
* ***MUL***tiply ***S***calar 32-bit float (***S***ingle precision)
```asm
mulss xmm0, xmm1
```
* ***MUL***tiply ***S***calar 64-bit float (***D***ouble precision)
```asm
mulsd xmm0, xmm1
```

### Division

#### Packed
* ***DIV***ide ***P***acked 32-bit float (***S***ingle precision)
```asm
divps xmm0, xmm1
```
* ***DIV***ide ***P***acked 64-bit float (***D***ouble precision)
```asm
divpd xmm0, xmm1
```

#### Scalar
* ***DIV***ide ***S***calar 32-bit float (***S***ingle precision)
```asm
divss xmm0, xmm1
```
* ***DIV***ide ***S***calar 64-bit float (***D***ouble precision)
```asm
divsd xmm0, xmm1
```

### Maximum

#### Packed
* ***MAX***imum ***P***acked 32-bit float (***S***ingle precision) between xmm0 and xmm1
```asm
maxps xmm0, xmm1
```
* ***MAX***imum ***P***acked 64-bit float (***D***ouble precision) between xmm0 and xmm1
```asm
maxpd xmm0, xmm1
```

#### Scalar
* ***MAX***imum ***S***calar 32-bit float (***S***ingle precision) between xmm0 and xmm1
```asm
maxss xmm0, xmm1
```
* ***MAX***imum ***S***calar 64-bit float (***D***ouble precision) between xmm0 and xmm1
```asm
maxsd xmm0, xmm1
```

### Minimum

#### Packed
* ***MIN***imum ***P***acked 32-bit float (***S***ingle precision) between xmm0 and xmm1
```asm
minps xmm0, xmm1
```
* ***MIN***imum ***P***acked 64-bit float (***D***ouble precision) between xmm0 and xmm1
```asm
minpd xmm0, xmm1
```

#### Scalar
* ***MIN***imum ***S***calar 32-bit float (***S***ingle precision) between xmm0 and xmm1
```asm
minss xmm0, xmm1
```
* ***MIN***imum ***S***calar 64-bit float (***D***ouble precision) between xmm0 and xmm1
```asm
minsd xmm0, xmm1
```

### Square root

#### Packed
* ***SQRT*** of ***P***acked 32-bit float (***S***ingle precision)
```asm
sqrtps xmm0, xmm1
```
* ***SQRT*** of ***P***acked 64-bit float (***D***ouble precision)
```asm
sqrtpd xmm0, xmm1
```

#### Scalar
* ***SQRT*** of ***S***calar 32-bit float (***S***ingle precision)
```asm
sqrtss xmm0, xmm1
```
* ***SQRT*** of ***S***calar 64-bit float (***D***ouble precision)
```asm
sqrtsd xmm0, xmm1
```

### Horizontal

#### Addition
* ***H***orizontal ***ADD*** ***P***acked 32-bit float (***S***ingle precision)
```asm
haddps xmm0, xmm1
```
* ***H***orizontal ***ADD*** ***P***acked 64-bit float (***D***ouble precision)
```asm
haddpd xmm0, xmm1
```

#### Subtraction
* ***H***orizontal ***SUB*** ***P***acked 32-bit float (***S***ingle precision)
```asm
hsubps xmm0, xmm1
```
* ***H***orizontal ***SUB*** ***P***acked 64-bit float (***D***ouble precision)
```asm
hsubpd xmm0, xmm1
```

