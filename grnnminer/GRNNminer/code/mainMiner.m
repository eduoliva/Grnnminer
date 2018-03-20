% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %
% mainMiner                                                              %
% ---------------------------------------------------------------------- %
% ---------------------------------------------------------------------- %
% 201512
% Rubiolo, M. 
% 
% ---------------------------------------------------------------------- %

function[net,orig,errorForSort,errors] = mainMiner(trainData,testData,labels,genes,thau,rep,NNtype,hidUnits,rules,points,epochs,theta)


real = 1;
% ---------------------------------------------------------------------- %
% Initializing variables...
% ----------
disp('--------------------');
disp('Initializing... ');

totalExp = (((size(genes,2))*(size(genes,2)))-size(genes,2))*rep;           % number of experiments to be done
countExp = 0;                                                               % counter of experiments initialization

errorRanking= [];
% ---------------------------------------------------------------------- %
data=trainData;
% ---------------------------------------------------------------------- %
% Generating the Pool of NN for modeling gene-to-gene relations 
% ----------
disp('--------------------');
disp('Modeling... (please wait)');

  for jidx=1:size(genes,2)
   
     j = genes(jidx);  % regulated gene j 
     ies = setdiff(genes,j); % possible regulators of gene j
   
      % evaluating genes in ies as possible regulators of gene j
     switch NNtype
     case 'MLP'
         [results,countExp] = modelingGi_vs_GjbyMLP(ies,j,thau,data,rep,real,hidUnits,epochs,countExp,totalExp);
     case 'ELM'
         [results,countExp] = modelingGi_vs_GjbyELM(ies,j,labels,thau,data,testData,rep,hidUnits,countExp,totalExp,points);
     otherwise
         [results,countExp] = modelingGi_vs_GjbyMLP(ies,j,thau,data,rep,real,hidUnits,epochs,countExp,totalExp);
     end
    
    
     % filling error ranking 
     errorRanking = [errorRanking;results];

  end;
  errors = errorRanking;
% ---------------------------------------------------------------------- %

% ---------------------------------------------------------------------- %
% Applying the Scoring method
% ----------

  % obtaining mean error for each modeled relation between genes
  [minMatrix,errorMatrix,meanMatrix,stdMatrix,errorForSort] = generatingErrorMatrix(errorRanking,genes,labels);      
  % obtaining a score for each modeled relation between genes
  scoreMatrix = generatingScoringMatrix(errorRanking,genes,rep);
  
% ---------------------------------------------------------------------- %
[errorSorted,idxSorted] = sort(errorForSort(1,:));
%idxCellSorted = mat2cell(idxSorted);
% boxplot(toPlot(:,idxSorted),'labels',plotLabels(idxCellSorted{1,1}))

%---

%---

% ---------------------------------------------------------------------- %
% Applying mining rules
% ----------
orig = scoreMatrix;
discoveredGRN = scoreMatrix;
for r=1:size(rules,2)
    switch rules(r)
        case 'T'
        discoveredGRN = applyingThresholdRule(discoveredGRN,errorMatrix,errorSorted,theta);
        case 'S'
        discoveredGRN = applyingSimetricRule(discoveredGRN,errorMatrix);
        case 'U' 
        discoveredGRN = applyingUnchainedRule(discoveredGRN,errorMatrix);
        otherwise
        discoveredGRN = discoveredGRN;
    end
end
  
  
% % ---------------------------------------------------------------------- %
net = discoveredGRN;



