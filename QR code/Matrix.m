(* ::Package:: *)

(* ::Subsection:: *)
(*IceCTF 2016 \[Dash] Matrix*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text::Italic:: *)
(*I like to approach problems with a fresh perspective and try to visualize the problem at hand.*)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*Import the challenge file as a list of strings.*)


matrix = Import["https://play.icec.tf/problem-static/matrix_adf1a8f010f541cb171910f7afe1f86d41ce1669c51e318bb84c3c2e4397e2f4.txt","List"]


(* ::Text:: *)
(*Convert each hex number to a list of binary digits.*)


binary = IntegerDigits[FromDigits[StringTrim[#, "0x"], 16], 2, 32] & /@ matrix


(* ::Text:: *)
(*Attempt to create a QR code from the data. There is some corruption that looks like duplicated rows or columns.*)


ColorNegate@Image@binary


(* ::Text:: *)
(*Delete duplicate rows, then transpose the matrix to delete duplicate columns.*)


cleaned = DeleteDuplicates@Transpose@DeleteDuplicates@binary;


(* ::Text:: *)
(*Create an image from the cleaned up data.*)


image = ColorNegate@Image[cleaned]


(* ::Text:: *)
(*Read the QR code.*)


BarcodeRecognize[image]
