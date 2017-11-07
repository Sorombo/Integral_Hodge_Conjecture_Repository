function [vec_ans] = remove_position(vec, m)
%Remove element in position m on the vector vec

	n		= length(vec);
	vec_ans	= [];
	%First, it is check that the index makes sense. If it does, then the element at that position is removed.
	if(m<1)
		error('Index less than 1')
	elseif(m>n)
		error('Index out of range')
	elseif((mod(m, 1) ~= 0))
		error('Index must be a natural number')
	elseif(m == n)
		vec_ans = [vec(1:(m-1))];
		return;
	else
		vec_ans = [vec(1:(m-1)), vec((m+1):end)];
		return;
	end
end