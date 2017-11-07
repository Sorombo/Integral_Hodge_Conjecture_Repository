(* ::Package:: *)

(* 

Computing Smith Forms for gcd version of
	-- Hodge Cycles Matrices
	-- Primitive Intersection Matrices
*)

(* Required files to work

	-- hodge cycles matrices (auxiliar_data/hodge_cycles/matrix_format/gcd_hodge_cycles_matrix)
	-- vanishing intersection matrices (auxiliar_data/hodge_cycles/matrix_format/vanishing_intersection_matrix)

*)

(* Setting directory and name variables *)

(* Dont forget to add / at the end of the string*)
parentDir = "";

dirHodgeCycles = StringJoin[parentDir, "auxiliar_data/hodge_cycles/matrix_format/hodge_cycles_matrix/"];
dirVanInt = StringJoin[parentDir, "auxiliar_data/hodge_cycles/matrix_format/vanishing_intersection_matrix/"];

resultFolder = StringJoin[parentDir, "main_data/"];
resultFolderSmith = StringJoin[resultFolder, "hodge_cycles/smith_form/"];
resultMatrixFolder = StringJoin[parentDir, "auxiliar_data/hodge_cycles/matrix_format/"];

resultFolderHodgeCycles = StringJoin[resultFolderSmith, "hodge_cycles_matrix/"];

resultFolderPrimitiveInt = StringJoin[resultMatrixFolder, "primitive_intersection_matrix/"];
resultFolderPrimitiveIntSubmatrix = StringJoin[resultMatrixFolder, "primitive_intersection_submatrix/"];

resultFolderSmithPrimitiveInt = StringJoin[resultFolderSmith, "primitive_intersection_matrix/"];
resultFolderSmithPrimitiveIntSubmatrix = StringJoin[resultFolderSmith, "primitive_intersection_submatrix/"];

extInv       = "_inv_factors";
extInvSimple = "_inv_factors_diag";
extU         = "_U";
extV         = "_V";
fileExt      = ".txt";

 
DIMS = {2, 4};
MINDEG = {4, 3};
MAXDEG = {10, 6};	
length = Length[DIMS];	
length = Length[DIMS];
For[k = 1, k <= length, k++,
	n = DIMS[[k]];
	For[d = MINDEG[[k]], d<=MAXDEG[[k]], d++,

		hodgeCyclesPrefix = "hodge_cycles_";
		basicFilename = StringJoin["n_", ToString[n], "_d_", ToString[d]];

		(* 
		=============================================
		=========== HODGE CYCLE MATRIX ==============
		=============================================
		 *)

		HodgeCyclesFilename	= StringJoin[dirHodgeCycles, hodgeCyclesPrefix, basicFilename, fileExt];
		HodgeCycles			= Import[HodgeCyclesFilename, "Table"]; 

		{U, invFactors, V} = SmithDecomposition[HodgeCycles];

		filenameInv		= StringJoin[resultFolderHodgeCycles, basicFilename, extInv, fileExt];
		filenameInvDiag	= StringJoin[resultFolderHodgeCycles, basicFilename, extInvSimple,fileExt];
		filenameU		= StringJoin[resultFolderHodgeCycles, basicFilename, extU, fileExt];
		filenameV		= StringJoin[resultFolderHodgeCycles, basicFilename, extV, fileExt];
				
		Export[filenameInv, invFactors, "Table"];
		Export[filenameInvDiag, Diagonal[invFactors], "Table"];
		Export[filenameV, V, "Table"];
		Export[filenameU, U, "Table"];

		(* 
		=============================================
		======= PRIMITIVE INTERSECTION MATRIX =======
		=============================================
		 *)
		vanishingIntPrefix = "vanishing_intersection_";
		primitiveIntPrefix = "primitive_intersection_";
		primitiveIntSubPrefix = "primitive_intersection_submatrix_";
		
		vanishingIntFilename = StringJoin[dirVanInt, vanishingIntPrefix, basicFilename, fileExt];
		psi = Import[vanishingIntFilename, "Table"];
		m = Count[Diagonal[invFactors],x_/;x!=0];
		mu = (d-1)^(n+1);
		
		(* Calculating X *)
		tmpY1 = ConstantArray[0, {mu - m, m}];
		tmpY2 = IdentityMatrix[mu-m];
		Y = Join[tmpY1, tmpY2, 2];
		X = Y.U;
		
		primitiveInt = X.psi.Transpose[X];
		
		(* Primitive intersection matrix is exported*)
		primitiveFilename = StringJoin[resultFolderPrimitiveInt, primitiveIntPrefix, basicFilename, fileExt];
		Export[primitiveFilename, primitiveInt, "Table"];
		
		(* Smith Form of primitive intersection matrix *)
		{UPrim, invFactorsPrim, VPrim} = SmithDecomposition[primitiveInt];
		
		filenameInv		= StringJoin[resultFolderSmithPrimitiveInt, primitiveIntPrefix, basicFilename, extInv, fileExt];
		filenameInvDiag	= StringJoin[resultFolderSmithPrimitiveInt, primitiveIntPrefix, basicFilename, extInvSimple,fileExt];
		filenameU		= StringJoin[resultFolderSmithPrimitiveInt, primitiveIntPrefix, basicFilename, extU, fileExt];
		filenameV		= StringJoin[resultFolderSmithPrimitiveInt, primitiveIntPrefix, basicFilename, extV, fileExt];
		
		Export[filenameInv, invFactorsPrim, "Table"];
		Export[filenameInvDiag, Diagonal[invFactorsPrim], "Table"];
		Export[filenameV, VPrim, "Table"];
		Export[filenameU, UPrim, "Table"];
		
		(* Smith form of submatrix of primitive intersection*)
		rankPrim = Count[Diagonal[invFactorsPrim],x_/;x!=0];
		tmpZ = Inverse[VPrim].Transpose[UPrim];
		Z = tmpZ[[1;;rankPrim, 1;;rankPrim]];
		
		(* Export submatrix associated to smith decomposition of primitive intersection *)
		primitiveSubFilename = StringJoin[resultFolderPrimitiveIntSubmatrix, primitiveIntSubPrefix, basicFilename, fileExt];
		Export[primitiveSubFilename, Z, "Table"];
		
		(* Smith decomposition of associated submatrix *)
		{UPrimSub, invFactorsPrimSub, VPrimSub} = SmithDecomposition[Z];
		
		filenameInv		= StringJoin[resultFolderSmithPrimitiveIntSubmatrix, primitiveIntSubPrefix, basicFilename, extInv, fileExt];
		filenameInvDiag	= StringJoin[resultFolderSmithPrimitiveIntSubmatrix, primitiveIntSubPrefix, basicFilename, extInvSimple,fileExt];
		filenameU		= StringJoin[resultFolderSmithPrimitiveIntSubmatrix, primitiveIntSubPrefix, basicFilename, extU, fileExt];
		filenameV		= StringJoin[resultFolderSmithPrimitiveIntSubmatrix, primitiveIntSubPrefix, basicFilename, extV, fileExt];
		
		Export[filenameInv, invFactorsPrimSub, "Table"];
		Export[filenameInvDiag, Diagonal[invFactorsPrimSub], "Table"];
		Export[filenameV, VPrimSub, "Table"];
		Export[filenameU, UPrimSub, "Table"];
	]
]
