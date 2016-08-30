(* ::Package:: *)

(* ::Subsection:: *)
(*IceCTF 2016 \[Dash] Round Rabins!*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*John gave up on RSA and moved to Rabin. ...he still did it wrong though flag.txt. What a box! *)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*This problem uses the Rabin cryptosystem, but has some implementation flaws.*)


(* ::Text:: *)
(*First, enter the values provided in flag.txt. You can enter base 16 literals into Mathematica as 16^^464C4147.*)


n = 16^^6b612825bd7972986b4c0ccb8ccb2fbcd25fffbadd57350d713f73b1e51ba9fc4a6ae862475efa3c9fe7dfb4c89b4f92e925ce8e8eb8af1c40c15d2d99ca61fcb018ad92656a738c8ecf95413aa63d1262325ae70530b964437a9f9b03efd90fb1effc5bfd60153abc5c5852f437d748d91935d20626e18cbffa24459d786601;
c = 16^^d9d6345f4f961790abb7830d367bede431f91112d11aabe1ed311c7710f43b9b0d5331f71a1fccbfca71f739ee5be42c16c6b4de2a9cbee1d827878083acc04247c6e678d075520ec727ef047ed55457ba794cf1d650cbed5b12508a65d36e6bf729b2b13feb5ce3409d6116a97abcd3c44f136a5befcb434e934da16808b0b;


(* ::Text:: *)
(*Note that p and q are actually the same, which makes this challenge very easy.*)


FactorInteger[n]


p = q = Sqrt[n];


(* ::Text:: *)
(*Because p and q are the same, we can just take the square root of c with a modulus of n. PowerMod[] can be used to take a modular root by providing a rational exponent.*)


m = PowerMod[c, 1/2, n]


(* ::Text:: *)
(*Convert the large integer to bytes by using IntegerDigits[] with a base of 256, then convert the bytes into ASCII characters with FromCharacterCode[].*)


FromCharacterCode[IntegerDigits[m, 256]]
