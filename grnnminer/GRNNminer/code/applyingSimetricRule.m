% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Applying SIMETRIC rule.
% 
% INPUT:
% incomingMatrix: incoming scores matrix.
% errorsMatrix: errors matrix.
% 
% OUTPUT:
% resultantMatrix: resultant matrix after the rule application.
% -----------------------------------------------------------------------%

function[resultantMatrix] = applyingSimetricRule(incomingMatrix,errorsMatrix)

% updating experiments state on command window
disp('--------------------');
disp('Applying Simetric rule... ');

% Variables initialization
resultantMatrix = incomingMatrix;
numElements = size(incomingMatrix,1);

for rIdx=2:numElements
     for cIdx=1:rIdx-1

        if (incomingMatrix(rIdx,cIdx) > 0) && (incomingMatrix(cIdx,rIdx) > 0)
            
            % obtaining error and score values 
            eIJ = errorsMatrix(rIdx,cIdx);
            eJI = errorsMatrix(cIdx,rIdx);
            sIJ = incomingMatrix(rIdx,cIdx);
            sJI = incomingMatrix(cIdx,rIdx);
           
            % calculating average bewteen related errors and scores
            avgValue = calculatingAverage(sIJ,sJI,eIJ,eJI);
            
            % remaining the correct relation
            if avgValue > 0 
                % gene i regulates gene j
                resultantMatrix(cIdx,rIdx) = 0;
            elseif avgValue < 0 
                % gene j regulates gene i
                resultantMatrix(rIdx,cIdx) = 0;
            end
        end
     end
end
end
