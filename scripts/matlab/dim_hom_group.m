function [ dimension] = dim_hom_group(n, d)
% This function calculates de dimension of the homology group
% H_n(X, Q) for a fermat variety of degree d and dimension n
	dimension = 1;
	for(i = 0:n)
		dimension = dimension + (-1)^(i)*(d-1)^(n+1-i);
	end
end