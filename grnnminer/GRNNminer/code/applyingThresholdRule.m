% -----------------------------------------------------------------------%
% 201405
% Rubiolo, M. 
% Applying THRESHOLD rule.
% 
% modified: 201512

% INPUT:
% incomingMatrix: incoming scores matrix.
% errorsMatrix: errors matrix.
% percentageMSE: percentage of the lowest error to be considered for applying threshold.
% 
% OUTPUT:
% resultantMatrix: resultant matrix after the rule application.
% -----------------------------------------------------------------------%


function[resultantMatrix] = applyingThresholdRule(incomingMatrix,errorsMatrix,errorSorted,theta)

% updating experiments state on command window
disp('--------------------');
disp('Applying Threshold rule... ');
  

% initilization of output variable
resultantMatrix = incomingMatrix;

% normalization of errors
% [normErrorMatrix,eVecNorm] = normalizingMSEmatrix(medianMatrix);

if round(size(errorSorted,2)*0.05) < 1
    idxPercInit = 1;
else
    idxPercInit = round(size(errorSorted,2)*0.05);
idxPercEnd = round(size(errorSorted,2)*0.50);
valPercInit = errorSorted(idxPercInit);
valPercEnd = errorSorted(idxPercEnd);

% removing values under the threshold
for idx = 1:(size(errorsMatrix,1)*size(errorsMatrix,2))
       if (errorsMatrix(idx) > valPercEnd) | (errorsMatrix(idx) < valPercInit)
          resultantMatrix(idx) = 0;
       end 
end
end
