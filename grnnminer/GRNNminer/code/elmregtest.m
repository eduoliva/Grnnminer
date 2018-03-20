function TY = elmregtest(D, Wi, wb, Wo, ActivationFunction)

% D: test data

% simplified from MR QIN-YU ZHU AND DR GUANG-BIN HUANG
% http://www.ntu.edu.sg/eee/icis/cv/egbhuang.htm 2004
%
% ddd 2015

Nd=size(D,1);
H=activ(Wi*D'+wb(:,ones(1,Nd)),ActivationFunction);
TY=(H'*Wo)';
