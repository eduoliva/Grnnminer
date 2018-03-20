function [Wi wb Wo] = elmregtrain(D, T, Nh, ActivationFunction,seed)

% D: train data
% T: train targets

% simplified from MR QIN-YU ZHU AND DR GUANG-BIN HUANG
% http://www.ntu.edu.sg/eee/icis/cv/egbhuang.htm 2004
%
% ddd 2015

[Nd,Ni]=size(D);
rng(seed);
Wi=rand(Nh,Ni)*2-1;
rng(seed);
wb=rand(Nh,1);
H=activ(Wi*D'+wb(:,ones(1,Nd)),ActivationFunction);
Wo=pinv(H')*T;
