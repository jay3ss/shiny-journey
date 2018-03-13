function  [a_opt] = gradient_algorithm(X,C,eps,gamma,M)
% 
% This subroutine performs the minimization of the function 
% norm(Xa-C).^2 using the gradient algorithm and estimates the 
% coordinates of the minimum 
% gamma: algorithm step
% eps: stopping parameter
% M: maximum number of search steps
%
NN=size(X);
Nw=NN(2);
a=zeros(Nw,M);
steps=1;

for index=1:M
    grad=2*((X')*X)*a(:,index)-2*X'*C;  % gradient at previous coordinate
    a(:,index+1)=a(:,index)-gamma*grad; % new coordinate
    steps=index+1;
    if norm(a(:,index+1)-a(:,index))<eps % stopping criterion
        break
    end
end
a_opt=a(:,index);   % optimal (final) coordinate
steps
end




