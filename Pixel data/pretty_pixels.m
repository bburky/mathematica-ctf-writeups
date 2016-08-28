(* ::Package:: *)

(* ::Subsection:: *)
(*IceCTF 2016 \[Dash] Pretty Pixels*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*Don't get me wrong, I love pretty colors as much as the next guy... but what does it mean? *)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*If we preview the image, it is just pure multicolored noise.*)


image = Import["https://play.icec.tf/problem-static/pretty_pixels_604e889db44de75ea4541a23e344b80eb315f0faf4136abc6d40e1fff8802c9f.png"]


(* ::Text:: *)
(*We want the values for each pixel. We could use ImageData[image,"byte"], or we can specify "Data" when downloading the image to get the byte data of each pixel.*)


imageData =
  Import[
   "https://play.icec.tf/problem-static/pretty_pixels_604e889db44de75ea4541a23e344b80eb315f0faf4136abc6d40e1fff8802c9f.png",
   "Data"];


(* ::Text:: *)
(*Lets try to interpret the first 100 pixels (300 RGB values) of the image as ASCII bytes.*)


FromCharacterCode[Flatten[imageData][[;; 300]]]


(* ::Text:: *)
(*That looks like the PNG header. Let's interpret pixel of the image as bytes and convert it into a string of binary data. Then use ImportString[] to import the data as if it were a file of binary data.*)


ImportString[FromCharacterCode[Flatten@imageData]]
