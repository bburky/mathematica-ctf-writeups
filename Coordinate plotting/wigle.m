(* ::Package:: *)

(* ::Subsection:: *)
(*picoCTF 2017 \[Dash] Connect The Wigle*)


(* ::Subsubsection:: *)
(*Problem*)


(* ::Text:: *)
(*Identify the data contained within wigle and determine how to visualize it. Update 16:26 EST 1 Apr If you feel that you are close, make a private piazza post with what you have, and an admin will help out.*)


(* ::Text:: *)
(*Hints*)


(* ::Item:: *)
(*Perhaps they've been storing data in a database. How do we access the information?*)


(* ::Item:: *)
(*How can we visualize this data? Maybe we just need to take a step back to get the big picture?*)


(* ::Item:: *)
(*Try zero in the first word of the flag, if you think it's an O.*)


(* ::Item:: *)
(*If you think you're super close, make a private piazza post with what you think it is.*)


(* ::Subsubsection:: *)
(*Solution*)


(* ::Text:: *)
(*The wigle file is a SQLite database. Mathematica can load a SQLite database directly using JDBC.*)


Needs["DatabaseLink`"]
db = OpenSQLConnection[
  JDBC["SQLite", FileNameJoin[{NotebookDirectory[], "wigle"}]]];


(* ::Text:: *)
(*Preview the data. We will be using the lon and lat columns.*)


Grid[SQLExecute[db, "SELECT * FROM location LIMIT 15", 
  "ShowColumnHeadings" -> True], Dividers -> {False, {False, True}}]


(* ::Text:: *)
(*Let's just plot the lon and lat columns as points.*)


Graphics@Point@SQLExecute[db, "SELECT lon, lat FROM location"]


(* ::Text:: *)
(*The flag is easily readable. The flag is: FLAG{F0UND_M3_3C32EF91}*)
