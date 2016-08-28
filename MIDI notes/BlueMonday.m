(* ::Package:: *)

(* ::Subsection:: *)
(*IceCTF 2016 \[Dash] Blue Monday*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*Those who came before me lived through their vocations From the past until completion, they'll turn away no more And still I find it so hard to say what I need to say But I'm quite sure that you'll tell me just how I should feel today.*)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*Import the MIDI file into a Sound[] instance.*)


midi=Import["https://play.icec.tf/problem-static/blue_monday_ff0973317ee7c2df4225f994ad49bb4075546b9f20eb22bbc636be910f628bfd"]


(* ::Text:: *)
(*Extract the notes from the SoundNote[] instances inside the Sound[]. *)


notes = midi[[1, All, 1]]


(* ::Text:: *)
(*Mathematica cannot convert notes to pitches directly. Use some code from the Mathematica StackExchange instead: http://mathematica.stackexchange.com/a/42944/13764*)


(*Converts note string into pitch relative to middle C=0*)
stringToPitch[string_String] := 
 Module[{noteValues, noteList, pitch}, 
  noteValues = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", 
    "A#", "B"};
  noteList = StringCases[
   string, {RegularExpression["[A-G]#?"], RegularExpression["\\d+"]}];
  pitch = Position[noteValues, First[noteList]][[1, 1]] - 1;
  ((ToExpression[noteList[[2]]] - 4)*12) + pitch]


stringToPitch /@ notes


(* ::Text:: *)
(*Guess the offset for the characters. Use a Manipulate[] to easily try different offsets and preview the decoding. It should look like something alphanumeric if our guess is close.*)


Manipulate[
 FromCharacterCode[stringToPitch /@ notes + x], {x, 11, 256 + 11, 1}]

(* ::Text:: *)
(*Of course... the format is IceCTF{...}, so the first character will be "I".*)


FromCharacterCode[
 stringToPitch /@ notes + ToCharacterCode["I"][[1]] - stringToPitch[First@notes]]
