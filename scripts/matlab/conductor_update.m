function [delta] = conductor_update(values, label, sign_, ref)

	m		= length(values);
	delta	= zeros(m,m);
	for(k=1:m)
		for(j=1:m)
			tmp			= (ref==1)*values(k, label) + (ref==2)*values(j, label);
			delta(k,j)	= sign_*(1 + 2*tmp);
		end
	end
end