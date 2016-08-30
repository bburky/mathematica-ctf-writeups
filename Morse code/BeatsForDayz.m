(* ::Package:: *)

(* ::Subsection:: *)
(*TUCTF 2016 \[Dash] Beatz for Dayz*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*Flag hidden in a FLAC file.*)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*Download the FLAC file into a SampledSoundList[] instance. This sound primitive contains samples that represent the amplitude and it is easy to work with.*)


sampledSoundList = Import[
  "http://ctf.asciioverflow.com/static/uploads/63811a1fd9fc936477585d0c67415fb0/2108dd8652498e179096eecf746ea8301c3cbe0b.flac",
  "SampledSoundList"];


(* ::Text:: *)
(*We can easily view the waveform easily with Sound[]. Notice there is a strange bump in one channel of the waveform. We will isolate it and see what it looks like.*)


Sound[sampledSoundList]


(* ::Text:: *)
(*Next, extract the left and right channels of the audio. Mathematica's destructuring can be used to unpack the list.*)


{left, right} = First@sampledSoundList;


(* ::Text:: *)
(*We can plot the waveforms manually too.*)


GraphicsColumn[ListLinePlot[#, PlotRange -> {-1, 1}] & /@ {left, right}]


(* ::Text:: *)
(*Take difference of the channels by simply subtracting one list (channel) from the other. Examine the result by graphing by plotting it.*)


ListLinePlot[left - right, PlotRange -> {-1, 1}]


(* ::Text:: *)
(*Examine the interesting portion of the waveform by graphing a portion of the list.*)


ListLinePlot[(left - right)[[39150 ;; 39300]], PlotRange -> {-1, 1.2}]


(* ::Text:: *)
(*Isolate the interesting portion of the signal by taking the Threshold[] of it at 0.5 and stretching the rest of signal to the minimum and maximum range with Unitize[]. This will produce a list of only 1's and 0's.*)


diff = Unitize@Threshold[left - right, {"Hard", 0.5}];


(* ::Text:: *)
(*Graph the new list.*)


ListLinePlot[diff[[39150 ;; 39300]]]


(* ::Text:: *)
(*Split[] the waveform into a list of segments where the value is the same (1 or 0). Then replace each sublist with the value repeated in the list and the length of the run of values.*)


{First[#], Length[#]} & /@ Split@diff


(* ::Text:: *)
(*Convert each value and run to a character representation of its Morse value.*)


StringJoin[({First[#], Length[#]} & /@ Split@diff)[[2 ;; -4]] /. {
   {1, 4} -> "-",
   {1, 1} -> ".",
   {0, 1} -> "",
   {0, 4} -> " ",
   {0, 8} -> "  "}]


(* ::Text:: *)
(*Mathematica cannot decode Morse Code directly, so use WolframAlpha instead.*)


(* ::WolframAlphaShort:: *)
(*-- --- .-. ... .  .. ...  ..-. ..- -.*)
