% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Calculating confusion matrix.
% 
% INPUT:
% targetTable: target table to be considered for calculating performance measures.
% resultsTable: results table used for calculating performance measures.
% 
% OUTPUT:
% values: True positive (TP), True negatives (TN), False positives (FP) and False Negatives (FN) values.
% -----------------------------------------------------------------------%

function[values] = calculatingConfusionMatrix(targetTable,resultsTable)

% updating experiments state in command window
  disp('--------------------');
  disp('Calculating performance measures...');

auxTable = resultsTable-targetTable;
numElements = size(targetTable,1);

TP = 0; TN = 0; FP = 0; FN = 0;

for rIdx=1:numElements
    for cIdx=1:numElements
        if (rIdx ~= cIdx)
            if (auxTable(rIdx,cIdx) == 0)
                if (targetTable(rIdx,cIdx) == 1)
                  TP = TP+1;
                else 
                  TN = TN+1;
                end
            end
            if (auxTable(rIdx,cIdx) > 0) 
                FP = FP+1;
            end
            if (auxTable(rIdx,cIdx) < 0)
                 FN = FN+1;
            end
        end
end
end
values=[TP,TN,FP,FN];

end


