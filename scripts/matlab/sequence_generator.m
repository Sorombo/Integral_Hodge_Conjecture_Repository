function [ sequences ] = sequence_generator(alphabet, Length)
%This function generates all sequences on the alphabet indicated
% of a given length
	sequences = sequence_generator_helper(alphabet, [], Length);

end