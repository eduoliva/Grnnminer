% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Generating results table
% -----------------------------------------------------------------------%

function[auxTable] = generatingResultsTable(table)

auxTable = table;
numElements = size(table,1);

for rIdx=1:numElements
    for cIdx=1:numElements
    if (table(rIdx,cIdx) ~= 0) 
        auxTable(rIdx,cIdx) = 1;
    end
end
end

