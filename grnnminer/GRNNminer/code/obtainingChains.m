% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Obtaining existing chains in scores matrix.
% 
% INPUT:
% scoreMatrix: incoming scores matrix.
% 
% OUTPUT:
% chains: a list of existing chains.
% -----------------------------------------------------------------------%

function[chains] = obtainingChains(scoreMatrix)

chains = [];

for cIdx = 1:size(scoreMatrix,2)
pRlist = find(scoreMatrix(:,cIdx)');                                         

if size(pRlist,2) > 0

    for pr=1:size(pRlist,2)

        pRlist2 = find(scoreMatrix(:,pRlist(pr))');
        
        if size(pRlist2,2) ~= 0 
            
            for pr2 = 1:size(pRlist2,2)
              if scoreMatrix(pRlist2(pr2),cIdx) ~= 0
                chains = [chains; [pRlist2(pr2) pRlist(pr) cIdx]]; 
              end
             end
            
         end
    end
end
end
