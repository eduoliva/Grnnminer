% ---------------------------------------------------------------------- %
% 201405
% Rubiolo, Stegmayer and Milone. 
%
% Drawing discovered regulations                                         %
% ---------------------------------------------------------------------- %


function[] = reportingGRN(table)

numElements = size(table,1);

for rIdx=1:numElements
    for cIdx=1:numElements
    if (table(rIdx,cIdx) ~= 0) 
        fprintf('%2d',rIdx)
        fprintf(' -->')
        fprintf('%2d',cIdx)
        disp(' ')
    end
    end
end
end
