function [permutations] = pseudo_perm_generator_helper(vec, tmp)
%Helper to generate pseudo permutations

	permutations = [];
	if(numel(vec) == 0)
		permutations = tmp;
	else
		%First entry is assigned
		[minimo, pos] = min(vec);
		tmp	= [tmp, minimo];
		vec	= remove_position(vec, pos);
		n 	= length(vec);

		%Recursive call
		for(k=1:n)
			tmp_update		= [tmp, vec(k)];
			vec_update		= remove_position(vec, k);
			permutations	= [permutations; pseudo_perm_generator_helper(vec_update, tmp_update)]; 
		end
	end
end
