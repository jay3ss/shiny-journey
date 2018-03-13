function  [a_opt] = steepest_algorithm(X,C,eps,M)
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
    grad=2*((X')*(X*a(:,index)-C));
    hess=4*(X'*X);
    num=norm(grad).^2;
    den=grad'*hess*grad;
    gammai=(num/den);
    a(:,index+1)=a(:,index)-gammai*grad; % new coordinate
    steps=index+1;
    if norm(a(:,index+1)-a(:,index))<eps % stopping criterion
        break
    end
end
a_opt=a(:,index);   % optimal (final) coordinate
steps
end




