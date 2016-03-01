(* ::Package:: *)

(* ::Subsection:: *)
(*Casting types*)


ConvertInt8TOInt64[int8_List]:=Total[int8*256^Range[0,7]]


ConvertInt8TOInt32[int8_List]:=Total[int8*256^Range[0,3]]


(* ::Subsection:: *)
(*ReadBinary*)


(* ::Text:: *)
(*returns a list of binary reads of "stream" at "startPosition" to "startPosition"+"size"*)


ReadBinary[stream_,startPosition_,size_]:=Block[{},SetStreamPosition[stream,startPosition];Table[BinaryRead[stream],{n,size}]]


AdvanceStreamPosition[stream_,advanceNumber_]:=SetStreamPosition[stream,StreamPosition@stream+advanceNumber]


(* ::Subsection:: *)
(*CZIBlockTable*)


(* ::Text:: *)
(*returns a list of {header title, block location(at the header title), allocated size, actual size}*)


CZIBlockTable[fileName_]:=Module[{resultList={},inStr=OpenRead[fileName,BinaryFormat->True],currentHeaderLocation=0,currentBlockSize,currentHeaderTitle,currentBlockSizeActual},

While[currentHeaderLocation<(FileByteCount@fileName),

currentHeaderTitle=(FromCharacterCode@DeleteCases[ReadBinary[inStr,currentHeaderLocation,16],0]);
currentBlockSize=(ConvertInt8TOInt64@ReadBinary[inStr,currentHeaderLocation+16,8]);
currentBlockSizeActual=(ConvertInt8TOInt64@ReadBinary[inStr,StreamPosition@inStr,8]);

resultList=Append[resultList,{StringTrim@currentHeaderTitle,
currentHeaderLocation,currentBlockSize,currentBlockSizeActual}];
currentHeaderLocation=StreamPosition@inStr+currentBlockSize;
If[(StreamPosition@inStr+currentBlockSize+8)<FileByteCount@fileName,AdvanceStreamPosition[inStr,currentBlockSize+8],Break[]];
];Close[inStr];
resultList]


(* ::Subsection:: *)
(*CZIMetaData*)


(* ::Text:: *)
(*returns xml metadata in xml object*)


CZIMetaData[fileName_]:=Module[{resultList,inStr,xmlSize,metaInfo=Cases[CZIBlockTable[fileName],{"ZISRAWMETADATA",_,_,_}][[1]]},
inStr=OpenRead[fileName,BinaryFormat->True];
xmlSize=ConvertInt8TOInt32@ReadBinary[inStr,metaInfo[[2]]+32,4];
resultList=FromCharacterCode@DeleteCases[ReadBinary[inStr,metaInfo[[2]]+32+256,xmlSize],0];
Close[inStr];
ImportString[resultList,"XML"]
]
