% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Creating the training input/target datasets.
% 
% w: number of time instants of input-gene considered as input. 
% gi: input-gene index 
% gj: target-gene index
% dataFile: file containing dataset (rows: genes - columns: times
% instants). It must be loaded here.
%
% OUTPUTS: 
% inputSet: dataset to be considered as input in the training process
% targetSet: dataset to be considered as target in the training process
% -----------------------------------------------------------------------%


function [inputSet, targetSet] = creatingTSdataForGi_vs_Gj(w,gi,gj,data,points)             

% loading dataset
data = normalizingTable(data);

% parameters initialization 
dSL = size(data,2);                                                         % data Set Length
windowLength = w-1;                                                         % windows of time

% variable initialization 
inputSet = zeros(dSL-windowLength,windowLength+1);
targetSet = zeros(dSL-windowLength,1);

% input and target dataset creation considering w
for ti=0:(dSL-windowLength-1)
      for wl=1:windowLength+1                                               
            inputSet(ti+1,wl) = data(gi+1,wl+ti);
      end
      targetSet(ti+1,1)= data(gj+1,ti+1+windowLength);
end
inputSet = inputSet';
targetSet = targetSet';

end

        