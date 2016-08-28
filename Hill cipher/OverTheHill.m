(* ::Package:: *)

(* ::Subsection:: *)
(*IceCTF 2016 \[Dash] Over the Hill*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*Over the hills and far away... many times I've gazed, many times been bitten. Many dreams come true and some have silver linings, I live for my dream of a decrypted flag.*)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*As hinted at by the name, this challenge uses the Hill Cipher.*)


(* ::Text:: *)
(*Enter the alphabet, matrix and ciphertext values provided with the problem. The matrix is entered as a Mathematica Matrix for clarity, but it is parsed into a list of lists.*)


alphabet="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789_{}";
matrix=\!\(\*
TagBox[
RowBox[{"(", "", GridBox[{
{"54", "53", "28", "20", "54", "15", "12", "7"},
{"32", "14", "24", "5", "63", "12", "50", "52"},
{"63", "59", "40", "18", "55", "33", "17", "3"},
{"63", "34", "5", "4", "56", "10", "53", "16"},
{"35", "43", "45", "53", "12", "42", "35", "37"},
{"20", "59", "42", "10", "46", "56", "12", "61"},
{"26", "39", "27", "59", "44", "54", "23", "56"},
{"32", "31", "56", "47", "31", "2", "29", "41"}
},
GridBoxAlignment->{"Columns" -> {{Center}}, "ColumnsIndexed" -> {}, "Rows" -> {{Baseline}}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}},
GridBoxSpacings->{"Columns" -> {Offset[0.27999999999999997`], {Offset[0.7]}, Offset[0.27999999999999997`]}, "ColumnsIndexed" -> {}, "Rows" -> {Offset[0.2], {Offset[0.4]}, Offset[0.2]}, "RowsIndexed" -> {}, "Items" -> {}, "ItemsIndexed" -> {}}], "", ")"}],
Function[BoxForm`e$, MatrixForm[BoxForm`e$]]]\);
ciphertext="7Nv7}dI9hD9qGmP}CR_5wJDdkj4CKxd45rko1cj51DpHPnNDb__EXDotSRCP8ZCQ";


(* ::Text:: *)
(*Get the index of each ciphertext character using the alphabet. We assume 0 based indexes (Mathematica uses 1 based indexes normally. Wikipedia used 0 based indexes and the highest index in the key was 63, so this challenge probably uses 0 based indexes.*)


(* ::Text:: *)
(*Characters[] will split a string into a list of single character strings, whose index can be looked up in alphabet using StringPosition[].*)


ciphertextIndexes = StringPosition[alphabet, #][[1, 1]] - 1 & /@ Characters@ciphertext


(* ::Text:: *)
(*Split the ciphertext into vertical matrices the size of the key matrix.*)


ciphertextParts = Partition[List /@ ciphertextIndexes, Length@matrix]


(* ::Text:: *)
(*Just do a dot product of the message parts with the inverse of the matrix. Everything is done with a modulus of the length of the alphabet.*)


messageParts = Mod[
  Inverse[matrix, Modulus -> StringLength@alphabet].#,
  StringLength@alphabet] & /@ ciphertextParts


(* ::Text:: *)
(*Flatten[] the nested list of indexes into a one dimensional list, then convert the indexes back into characters, and join the single character strings back together.*)


StringJoin[StringPart[alphabet, # + 1] & /@ Flatten@messageParts]
