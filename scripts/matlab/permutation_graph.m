function [List_in, List_out] = permutation_graph(sigma, tau)
	
	[~, n] = size(sigma);
	[~, m] = size(tau);
	if(n ~= m)
		error('Both permutations must be of the same size.');
	end
	%Variables are declared
	List_in	= zeros(n, 4);
	List_out= zeros(n, 4);

	%Adjacency list is filled
	for(t = 1:2:n)
		v_1 = sigma(t);
		v_2 = sigma(t+1);
		List_in(v_2, 1)	= v_1;
		List_in(v_2, 2)	= t;
		List_out(v_1, 1)= v_2;
		List_out(v_1, 2)= t;

		v_1 = tau(t);
		v_2 = tau(t+1);
		List_in(v_2, 3)	= v_1;
		List_in(v_2, 4)	= t;
		List_out(v_1, 3)= v_2;
		List_out(v_1, 4)= t;
	end
end