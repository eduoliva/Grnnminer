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

function [results,countExp] = modelingGi_vs_GjbyMLP(ies,j,thau,data,rep,real,hid,epochs,countExp,totalExp)

% Variables initialization
Goal=1e-150;
MinGrad = 1e-100;
results = [];
r = 1;

patterns = size(data,2)/real;

for i=1:size(ies,2)
     
               
           %-----------------------------------------%
           % configurating first training of the net %            
           %-----------------------------------------%
           
           % create the dataset for modeling regulation between i and j  
           [inNormData, outNormData] = creatingTSdataForGi_vs_Gj(thau+1,ies(i),j,data(:,1:patterns));   

           % seting number of hidden neurons
%            hiddenNeurons = round(size(inNormData,1)*hid/100);    
            hiddenNeurons = hid;    

           for rep = 1:rep
                        
                         % MLP creation. 
                         % Parameter initialization using Nguyen-widrow by default.
                         % Activation function at hidden layer: log-sigmoid.
                         % Activation function at output layer: linear.
                         MLP = newff(inNormData,outNormData,hiddenNeurons,{'logsig' 'purelin'},'trainlm');
                         MLP.trainParam.epochs = epochs;
                         MLP.trainParam.min_grad = MinGrad; 
                         MLP.trainParam.goal = Goal; 
                         MLP.trainParam.showWindow=0; 
                         MLP.trainParam.showCommandLine=0;
						 MLP.trainParam.showWindow=false;
                         
                         [MLP,trMLP] = train(MLP,inNormData,outNormData);
                         
                         % retraning the net with other realizations
                         for rz = 2:real

%                            dataSetFile = [dataSet,'',int2str(rz),'.mat'];
                           % creating dataset for other realizations 
%                            [inNormData,outNormData] = creatingTSdataForGi_vs_Gj(thau+1,ies(i),j,dataSetFile);
                             initIdx = ((rz-1)*patterns)+1;
                             endIdx = patterns*rz;
                             [inNormData,outNormData] = creatingTSdataForGi_vs_Gj(thau+1,ies(i),j,data(:,initIdx:endIdx));
                           
                            [MLP,trMLP] = train(MLP,inNormData,outNormData);
                         end

                        % Error of modeling Gi as regulator of Gj
                        MSE = trMLP.perf(size(trMLP.perf,2));

                        % Filling results table
                        results(r,1) = rep;                                 % repetition
                        results(r,2) = ies(i);                              % Gi possible regulator
                        results(r,3) = j;                                   % Gj regulated
                        results(r,4) = MSE;                                 % modeling error
                        
                        r=r+1;                        
           end
   
end
end



