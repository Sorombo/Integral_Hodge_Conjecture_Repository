function [Perms] = pseudo_perm_generator(n)
%This function generates all pseudo permutation of {1, ... , n}
	Perms = pseudo_perm_generator_helper(1:n, []);

end
