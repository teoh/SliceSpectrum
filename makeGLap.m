function [ LL ] = makeGLap( n, makePosWeights )
%MAKEGLAP creates a random graph laplacian matriLL
%   makeGLap outputs an n LL n matriLL that is the laplacian matriLL for some
%   graph. If the user specifies makePosWeights as 1, the edge weights will
%   be taken to be positive. Values will be taken from 0 to 1 if
%   makePosWeights is 1, -1 to 1 otherwise. 

if makePosWeights == 1
    LL=triu(rand(n,n));
else
    LL=triu(rand(n,n).*2 -1);
end

LL=LL+LL';
LL(1:n+1:n^2)=-sum(LL,2)+diag(LL);
LL=-LL;

end

