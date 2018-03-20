% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer.
% Normalizing table
% -----------------------------------------------------------------------%


function[newTable] = normalizingTable(table)

numRows = size(table,1);
numCols = size(table,2);
% Normalization

vec = reshape(table,1,numRows*numCols); 

vecNorm = mapminmax(vec,0,1);

newTable = reshape(vecNorm,numRows,numCols);


