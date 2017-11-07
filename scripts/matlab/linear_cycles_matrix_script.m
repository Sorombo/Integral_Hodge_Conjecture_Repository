% ===========================================
% Computing Linear Cycles Matrices
% ===========================================

%Set parent_dir (do not add '/' at the end of the string)
parent_dir			= '';

nonprim_linear_dir	= 'auxiliar_data/linear_cycles/nonprimitive/';
prim_linear_dir		= 'auxiliar_data/linear_cycles/primitive/';

%Fix variables
N_array		= [2, 4];				%Dimension
D_array_min	= [3, 3];				% Fix minimum d for each n
D_array_max	= [10, 5];				% Fix maximum d for each n
tolerance	= 1e-6;					% Tolerance


for(r = 1:numel(N_array))
	%Fix dimension
	n = N_array(r);

	%Choose d
	for(d=D_array_min(r):D_array_max(r))
		%Generating all desired permutations and vectors 
		alphabet   = 0:(d-1);
		max_length = n/2 + 1;
		Perms      = pseudo_perm_generator(n+2);
		values     = sequence_generator(alphabet, max_length);

		%Declaring variables
		[N, ~] = size(Perms);
		[M, ~] = size(values);
		Bicycles = zeros(N*M);		% Nonprimitive version
		prim_bic = zeros(N*M);		% Primitive version
		tau      = [];
		sigma    = [];
		
		%Function for numbering the rows and columns of matrix
		row_column_num = @(x,y) M*(x-1) + y;

		%Calculating matrix
		for(i = 1:N)
			sigma = Perms(i, :);
			for(j = 1:N)
				tau = Perms(j, :);
				%====================================================
				% Find bicycles
				%====================================================
				% We generate a graph. We have used list representation
				
				[list_in, list_out] = permutation_graph(sigma, tau);  

				%========================================
				% Calculate the conductor of each bicycle
				%========================================
				% Value of conductors
				conductors = compute_conductor(list_in, list_out, sigma, values);

				% Counting new bicycles
				conductors = (abs(mod(conductors, 2*d)) < tolerance);
				[no_conductors, ~] = size(conductors);
				for(k=1:no_conductors)
					for(l=1:no_conductors)
						amount_new_bic = sum(conductors(k,l,:));
						ind_1 = row_column_num(i,k);
						ind_2 = row_column_num(j,l);
						Bicycles(ind_1, ind_2) = (1/d)*(1 - (-d+1)^amount_new_bic);

						% Alternative form of the bicycle matrix
						% Bicycles(ind_1, ind_2) = (-d+1)^amount_new_bic;		

					end
				end
			end
		end

		%Desired rank
		desired_rank = rank(Bicycles)

		%Saving data
		[dimension, ~]	= size(Bicycles);
		foldername		= strcat(parent_dir,'/auxiliar_data/linear_cycles/nonprimitive/');
		basic_filename 	= sprintf('n_%d_d_%d', n, d);
		filename		= strcat('nonprim_linear_cycles_', basic_filename);
		
		filename		= strcat(foldername, filename);
		filename_txt	= strcat(filename, '.txt');
		
		print(filename_txt, Bicycles);


		% Calculate primitive version
		for(k = 1:N*M)
			for(l = 1:N*M)
				new_bic(k,l) = Bicycles(k,l) - Bicycles(1, k) - Bicycles(1,l) + Bicycles(1,1);  
			end
		end

		prim_filename = strcat(parent_dir, prim_linear_dir, 'prim_linear_cycles_', basic_filename, '.txt');
		print(prim_filename, new_bic);
	end
end


