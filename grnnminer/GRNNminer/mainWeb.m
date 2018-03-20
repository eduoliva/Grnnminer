function[grnHTML,values] = mainWeb(dataFile,targetFile,labelsFile,numOfGenes,deltaT,repetitions,NNtype,hiddenNumber,epochs,rules,theta,sesionID)
% 201609
% Rubiolo, M. 
% 
% INPUTS:
% dataFile: .csv file where rows are genes and columns are time stamps.
% labels: 
% rep:  repetitions of each experiment
% 
tic 
% path configuration
addpath('data')
%addpath('data\IRMA')
addpath('code')

% read data
data = csvread(dataFile);
trainData = data';
testData = trainData;
genesLabels = readLabels(labelsFile,numOfGenes);

conex = numOfGenes*numOfGenes;


% repetitions = 10;

% rules = ['T','S'];

genes=[0:size(trainData,1)-1];
points = size(trainData,2);
% trainData = data(:,1:realTRN*numOfTime);
% testData = data(:,(numOfTime*realTRN+1:(realTRN+realTST)*numOfTime));

[net]=mainMiner(trainData,testData,genesLabels,genes,deltaT,repetitions,NNtype,hiddenNumber,rules,points,epochs,theta);
dlmwrite('GRNNminer/out/net.csv',net)
net
net4results = generatingResultsTable(net)

if ~strcmp(targetFile,'') 
targetData = csvread(targetFile);
targetNet = generatingResultsTable(targetData);
values = calculatingConfusionMatrix(targetNet,net4results)
end

dlmwrite('GRNNminer/out/test.csv',net)%lo creo y luego lo borro para saber si hubo error o no

toc
quit; %Agrego para que funcione por consola

 %writeHTML(net4results,genesLabels);
 %grnHTML = 'out/grn.html';

