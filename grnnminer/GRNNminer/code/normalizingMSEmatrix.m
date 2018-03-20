% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Normalizing errors matrix.
% 
% INPUT:
% errorsMatrix: errors matrix.
% 
% OUTPUT:
% normEmatrix: resultant matrix after the normalization.
% normEvector: normalized errors order as a vector.
% -----------------------------------------------------------------------%
function[normEmatrix,normEvector] = normalizingMSEmatrix(errorsMatrix)

numElements = size(errorsMatrix,1);
minMSE = min(errorsMatrix(find(errorsMatrix~=0)));
eyeMinMSE = eye(numElements)*minMSE;
auxMSEtable = errorsMatrix+eyeMinMSE;
vecAuxMSEtable = auxMSEtable(find(auxMSEtable~=0)); 
normEvector = mapminmax(vecAuxMSEtable',0,1);
normEmatrix = vec2mat(normEvector,numElements)';