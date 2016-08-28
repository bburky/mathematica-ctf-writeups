# IceCTF 2016 – Round Rabins!

## Problem

John gave up on RSA and moved to Rabin. ...he still did it wrong though flag.txt. What a box!

## Solution

This problem uses the [Rabin cryptosystem](https://en.wikipedia.org/wiki/Rabin_cryptosystem), but has some implementation flaws.

First, enter the values provided in flag.txt. You can enter base 16 literals into Mathematica as `16^^464C4147`.

```mathematica
n = 16^^6b612825bd7972986b4c0ccb8ccb2fbcd25fffbadd57350d713f73b1e51ba9\
fc4a6ae862475efa3c9fe7dfb4c89b4f92e925ce8e8eb8af1c40c15d2d99ca61fcb018\
ad92656a738c8ecf95413aa63d1262325ae70530b964437a9f9b03efd90fb1effc5bfd\
60153abc5c5852f437d748d91935d20626e18cbffa24459d786601;

c = 16^^d9d6345f4f961790abb7830d367bede431f91112d11aabe1ed311c7710f43b\
9b0d5331f71a1fccbfca71f739ee5be42c16c6b4de2a9cbee1d827878083acc04247c6\
e678d075520ec727ef047ed55457ba794cf1d650cbed5b12508a65d36e6bf729b2b13f\
eb5ce3409d6116a97abcd3c44f136a5befcb434e934da16808b0b;
```

Note that *p* and *q* are actually the same, which makes this challenge very easy.

```mathematica
FactorInteger[n]
```

```
{{8683574289808398551680690596312519188712344019929990563696863014403818356652403139359303583094623893591695801854572600022831462919735839793929311522108161, 2}}
```


```mathematica
p = q = Sqrt[n];
```

Because *p* and *q* are the same, we can just take the square root of *c* with a modulus of *n*. `PowerMod[]` can be used to take a modular root by providing a rational exponent.

```mathematica
m = PowerMod[c, 1/2, n]
```

```
1650837364105066647631553257917166784887536976618652603404055059848204\
6342664905996230383084538167023824865582697144027817783294645253096476\
527422927208975717661053
```

Convert the large integer to bytes by using `IntegerDigits[]` with a base of 256, then convert the bytes into ASCII characters with `FromCharacterCode[]`.

```mathematica
FromCharacterCode[IntegerDigits[m, 256]]
```

```
IceCTF{john_needs_to_get_his_stuff_together_and_do_things_correctly}
```
