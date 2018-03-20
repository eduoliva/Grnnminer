% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Generating errors matrix from results table.
% 
% INPUT:
% resultsTable: table containing results data from modeling possible regulations.
% genes: all genes considered in the experiment.
% 
% OUTPUT:
% errorsMatrix: average errors in modeling the regulations between all possible Gi --> Gj
% -----------------------------------------------------------------------%

function[minMatrix,medMatrix,meanMatrix,stdMatrix,errorForSort] = generatingErrorMatrix(resultsTable,genes,labels);
 
% initialiazing output variable
minMatrix = zeros(length(genes),length(genes));
meanMatrix = zeros(length(genes),length(genes));
stdMatrix = zeros(length(genes),length(genes));
medMatrix = zeros(length(genes),length(genes));

% toPlot = zeros(10,length(genes)*length(genes)-length(genes));
p = 1; % counter plot
for GiIdx=1:size(genes,2)
    for GjIdx=1:size(genes,2)
        if GiIdx ~= GjIdx 
           Gi = genes(GiIdx);
           Gj = genes(GjIdx);

         % obtaining row indexes in which column 'Regulator' has the value Gi
         colIesIdx = find(resultsTable(:,2)==Gi);
         
         % obtaining row indexes in which column 'Regulated' has the value Gj
         colJesIdx = find(resultsTable(:,3)==Gj);
         
         % indexes intersection
         parIdx = intersect(colIesIdx,colJesIdx);
        
         % filtering null errors
         colErrIdx = find(resultsTable(:,4)>0);
         
         % obtaining row indexes for evaluating 
         filterIdx = intersect(parIdx,colErrIdx);
         
         subTable = resultsTable(filterIdx,:);
         % size(subTable);
         
         %toPlot(:,(GiIdx-1)*length(genes)+GjIdx) = subTable(:,4);
         %toPlot(:,p) = subTable(:,4);
         %plotLabels(1,(GiIdx-1)*length(genes)+GjIdx) = strcat('g',labels(GiIdx),'-g',labels(GjIdx));
         %plotLabels(1,p) = strcat('g',labels(GiIdx),'-g',labels(GjIdx));
         errorForSort(1,p) =  median(subTable(:,4));
%          errorForSort(1,p) =  min(subTable(:,4));
         errorForSort(2,p) = GiIdx;
         errorForSort(3,p) = GjIdx;
         p = p+1;
         
         %filling error matrix
         minMatrix(GiIdx,GjIdx) = min(subTable(:,4));
         meanMatrix(GiIdx,GjIdx) = mean(subTable(:,4));
         stdMatrix(GiIdx,GjIdx) = std(subTable(:,4));
         medMatrix(GiIdx,GjIdx) = median(subTable(:,4));
         
        end
    end
end
