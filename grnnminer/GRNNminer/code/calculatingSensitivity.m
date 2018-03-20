% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Calculating sensitivity measure.
% 
% INPUT:
% values: True positive (TP), True negatives (TN), False positives (FP) and False Negatives (FN) values.
% 
% OUTPUT:
% sensitivity: sensitivity value.
% -----------------------------------------------------------------------%


function[accuracy] = calculatingSensitivity(values)

TP=values(1);
TN=values(2);
FP=values(3);
FN=values(4);
accuracy = (TP)/(TP+FN);


