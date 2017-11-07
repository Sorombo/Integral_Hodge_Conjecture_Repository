function [ sequences ] = sequence_generator_helper(alphabet, tmp, Length)
%Helper to generate sequences

	sequences = [];
	if(Length == 0)
		sequences = tmp;
	else
		%First entry value is assigned
		n = length(alphabet);
		for(k=1:n)
			element_added = [tmp, alphabet(k)];
			sequences     = [sequences; sequence_generator_helper(alphabet, element_added, Length-1)]; 
		end
	end

end