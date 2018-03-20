% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Generating scoring matrix from results table.
% 
% INPUT:
% resultsTable: table containing results data from modeling possible regulations.
% genes: all genes considered in the experiment.
% repetitions: number of repetitions in experiments.
% 
% OUTPUT:
% scoringMatrix: score assigned ??in modeling the regulations between all possible Gi --> Gj
% -----------------------------------------------------------------------%

function[scoringMatrix] = generatingScoringMatrix(resultsTable,genes,repetitions);

% updating state of experiments at command window 
  disp('--------------------');
  disp('Applying Scoring method...');


% initialiazing output variable
scoringMatrix = zeros(length(genes),length(genes));

for GjIdx=1:size(genes,2)
     Gj = genes(GjIdx);
     restG = setdiff(genes,Gj);    
     
     % obtaining row indexes in which column J has the value Gj
     colJesIdx = find(resultsTable(:,3)==Gj);
     
     pointsRow = [];
     for r=1:repetitions
         colRepIdx = find(resultsTable(:,1)== r);
         finalIdx = intersect(colJesIdx,colRepIdx);
         subTable =  sortrows(resultsTable(finalIdx,:),4);
         candidates = subTable(:,2);
         [valCand,idxCand] = unique(candidates,'first');
         orderCand = candidates(sort(idxCand));
         pointsRow = [pointsRow,orderCand(1),orderCand(1),orderCand(2)];   
     end
     
     iElements = unique(pointsRow);
     for iE = 1:length(iElements)
           GiIdx = find(genes==iElements(iE));
           scoringMatrix(GiIdx,GjIdx) = length(find(pointsRow==iElements(iE)));
     end 
     
 end
