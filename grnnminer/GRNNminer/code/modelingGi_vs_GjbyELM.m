% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Stegmayer and Milone. 
% Modeling possible regulators of Gj.  
% To evaluate gene i as a potential regulator of gene j. 
% All posibilities are evaluated.
% 
% INPUT:
% ies: posssible regulators of j.
% j: target gene data.
% repNumber: number of repetitions.
% realNumber: number of realizations (only for artificial datasets).
% hidPercentage: percentage of inputs number to set number of hidden units.
% epochs: number of epochs used in training.
% countExp: counter for updating experiment state.
% totalExp: all experiments to be done for updating experiment state.
% 
% OUTPUT:
% results: table of experiment results (Repetition, Gi, Gj and error)
% countExp: counter for updating experiment state.
% -----------------------------------------------------------------------%

function [results,countExp] = modelingGi_vs_GjbyELM(ies,j,labels,thau,trainData,testData,rep,hid,countExp,totalExp,points)
                                                  
% Variables initialization
results = [];
r = 1; 
% patterns = size(trainData,2)/real;
realTRN = size(trainData,2)/points;
realTST = size(testData,2)/points;

    for i=1:size(ies,2)
           inNormData = [];
           outNormData = [];
           inNormTestData = [];
           outNormTestData = [];
           
           % create the dataset for modeling regulation between i and j 
           
           for reTr=1:realTRN
           iniPoint = 1 + points*(reTr-1);
           endPoint = points + points*(reTr-1);
           TRNdata = trainData(:,1:points);
           [inTRNdata, tgtTRNdata] = creatingTSdataForGi_vs_Gj(thau+1,ies(i),j,TRNdata,points);   
           inNormData = [inNormData, inTRNdata];
           outNormData = [outNormData, tgtTRNdata];
           end
           
           for reTs= 1:realTST
           iniPoint = 1 + points*(reTs-1);
           endPoint = points + points*(reTs-1);
           TSTdata = trainData(:,1:points);
           [inTSTdata, tgtTSTdata] = creatingTSdataForGi_vs_Gj(thau+1,ies(i),j,TSTdata,points);   
           inNormTestData = [inNormTestData, inTSTdata];
           outNormTestData = [outNormTestData, tgtTSTdata];
           end
           
           % seting number of hidden neurons
%            hiddenNeurons = round(size(inNormData,1)*hid/100);    
            hiddenNeurons = hid;
            
           for rep = 1:rep
               
                        % ELM model
                        output = modelingByELM(inNormData,outNormData,inNormTestData,hiddenNeurons,'sig',rep);
                        
                        error = errorMSE(output,outNormTestData);
    
                        % Filling results table
                        results(r,1) = rep;          % repetition
                        results(r,2) = ies(i);       % Gi possible regulator
                        results(r,3) = j;            % Gj regulated
                        results(r,4) = error;        % modeling error
                        results(r,5) = thau;        
                        results(r,6) = hid;        
                        
                        r=r+1;                       % counter
           end
    end
end



