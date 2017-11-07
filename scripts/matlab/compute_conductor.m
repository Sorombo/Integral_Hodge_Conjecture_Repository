function [conductors] = compute_conductor(list_in, list_out, sigma, values)
% Given the adjecency list (in-edges and out-edges of the permutation graph 
% associated to sigma and another permutation), a permutation, and a vector 
% of values. The conductors are numerically computed based on the values given.

	[vertex_number, ~] = size(list_in);
	visited     = zeros(1, vertex_number);
	marked_edge = zeros(vertex_number, 4);
	numbering   = @(x) (x+1)/2;
	% marked_edge is written in the following format
	%	- marked_edge(v, 1) = out-edge associated to permutation 1	
	%	- marked_edge(v, 2) = out-edge associated to permutation 2	
	%	- marked_edge(v, 3) = in-edge associated to permutation 1	
	%	- marked_edge(v, 4) = in-edge associated to permutation 2		

	[amount_values, ~] = size(values);
	conductors         = zeros(amount_values,amount_values, ceil(vertex_number/2 +2));

	% Conductors counting variable
	amount_conductors = 0;

	% Graph traversal
	for(t = 1:2:vertex_number)
		v = sigma(t);
		if(visited(v) == 1)
			continue
		else
			visited(v) = 1;
			amount_conductors = amount_conductors + 1;
			next_v = 0;
			keep_looping = true;
			while(keep_looping)

				%Determine unvisited neighbor
				next_v	= 0;
				v_1		= list_out(v,1);
				v_2		= list_out(v,3);
				v_3		= list_in(v,1);
				v_4		= list_in(v,3);

				if(v_1 ~= 0 && marked_edge(v,1) == 0)
					next_v = v_1;
					label  = numbering(list_out(v,2));
					marked_edge(v,1)       = 1;
					marked_edge(next_v, 3) = 1;
					visited(v) 	= 1;
					conductors(:,:,amount_conductors) = conductors(:,:, amount_conductors) + conductor_update(values, label, 1, 1);
				elseif (v_2 ~= 0 && marked_edge(v,2) == 0)
					next_v = v_2;
					label  = numbering(list_out(v,4));
					marked_edge(v,2)       = 1;
					marked_edge(next_v, 4) = 1;
					visited(v) 	= 1;
					conductors(:,:,amount_conductors) = conductors(:,:, amount_conductors) + conductor_update(values, label, 1, 2);
				elseif (v_3 ~= 0 && marked_edge(v,3) == 0)
					next_v = v_3;
					label  = numbering(list_in(v,2));
					marked_edge(v,3)       = 1;
					marked_edge(next_v, 1) = 1;
					visited(v) 	= 1;
					conductors(:,:,amount_conductors) = conductors(:,:, amount_conductors) + conductor_update(values, label, -1, 1);
				elseif (v_4 ~= 0 && marked_edge(v,4) == 0)
					next_v = v_4;
					label  = numbering(list_in(v,4));
					marked_edge(v,4)       = 1;
					marked_edge(next_v, 2) = 1;
					visited(v) 	= 1;
					conductors(:,:,amount_conductors) = conductors(:,:, amount_conductors) + conductor_update(values, label, -1, 2);
				else
					keep_looping = false;
				end

				%Move on to next vertex
				v = next_v;
			end


		end

	end

	conductors = conductors(:, :, 1:amount_conductors);

end