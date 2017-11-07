(* ::Package:: *)

(* Computing Smith Forms*)


(*Set parent directory*)
parentDir = "";

dir = StringJoin[parentDir, "/auxiliar_data/linear_cycles/primitive/"];
resultDir = StringJoin[parentDir, "/main_data/linear_cycles/"];
dirSmith = StringJoin[resultDir, "smith_form/primitive/"];

(*Choose matrix to decompose*)
DIMS = {2, 4};
MINDEG = {3, 3};
MAXDEG = {10, 6};	
length = Length[DIMS];
For[k = 1, k <= length, k++,
	n = DIMS[[k]];
	For[d = MINDEG[[k]], d<=MAXDEG[[k]], d++,
		(* Loading matrix file *)
		suffix         = StringJoin["n_", ToString[n], "_d_", ToString[d], ".txt"];
		matrixFilename = StringJoin["prim_linear_cycles_", suffix];
		filename       = StringJoin[dir, matrixFilename];
		newBicycle     = Import[filename, "Table"];

		(* Calculating smith decomposition *)
		{U, invFactors, V} = SmithDecomposition[newBicycle];

		(* Setting filenames *)
		suffixResult = StringJoin["n_", ToString[n], "_d_", ToString[d]];
		extInv       = "_inv_factors";
		extU         = "_U";
		extV         = "_V";
		fileExt      = ".txt";
		filenameInv       = StringJoin[dirSmith, suffixResult, extInv, fileExt];
		filenameInvSimple = StringJoin[dirSmith, suffixResult, extInv, "_diag", fileExt];
		filenameU         = StringJoin[dirSmith, suffixResult, extU, fileExt];
		filenameV         = StringJoin[dirSmith, suffixResult, extV, fileExt];
		
		(* Exporting data *)
		Export[filenameInv, invFactors, "Table"];
		Export[filenameInvSimple, Diagonal[invFactors], "Table"];
		Export[filenameU, U, "Table"];
		Export[filenameV, V, "Table"];
		
		(* Data of submatrix *)
		rankMatrix = Count[Diagonal[invFactors],x_/;x!=0];
		tmpZ = Inverse[V].Transpose[U];
		Z = tmpZ[[1;;rankMatrix, 1;;rankMatrix]];
		
		(* Export submatrix associated to smith decomposition of primitive intersection *)
		submatrixLinearCycles = StringJoin[dir, "submatrix/submatrix_", matrixFilename];
		Export[submatrixLinearCycles, Z, "Table"];
		
		{USubmatrix, InvFactorsSubmatrix, VSubmatrix} = SmithDecomposition[Z];
		
		filenameInv       = StringJoin[dirSmith, "submatrix/", suffixResult, extInv, fileExt];
		filenameInvSimple = StringJoin[dirSmith, "submatrix/", suffixResult, extInv, "_diag", fileExt];
		filenameU         = StringJoin[dirSmith, "submatrix/", suffixResult, extU, fileExt];
		filenameV         = StringJoin[dirSmith, "submatrix/", suffixResult, extV, fileExt];
		
		(* Exporting data *)
		Export[filenameInv, InvFactorsSubmatrix, "Table"];
		Export[filenameInvSimple, Diagonal[InvFactorsSubmatrix], "Table"];
		Export[filenameU, USubmatrix, "Table"];
		Export[filenameV, VSubmatrix, "Table"];
	]
]







