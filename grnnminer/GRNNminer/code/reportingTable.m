% ---------------------------------------------------------------------- %
% 201405
% Rubiolo, Stegmayer and Milone. 
%
% Drawing discovered regulations                                         %
% ---------------------------------------------------------------------- %


function[discoveredFile] = reportingTable(table)

numElements = size(table,1);

discoveredFile = ['discovered',int2str(numElements),'gGRN.txt'];
diary(discoveredFile)

for rIdx=1:numElements
    for cIdx=1:numElements
         if table(rIdx,cIdx) > 0
             fprintf(['gene',int2str(rIdx),' --> gene',int2str(cIdx)]);
             disp(' ')
         end
     end
diary off;
end
