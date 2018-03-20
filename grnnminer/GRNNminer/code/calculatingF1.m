% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Calculating accuracy measure.
% 
% INPUT:
% values: True positive (TP), True negatives (TN), False positives (FP) and False Negatives (FN) values.
% 
% OUTPUT:
% accuracy: accuracy value.
% -----------------------------------------------------------------------%

function[F1] = calculatingF1(values)


PR = calculatingPrecision(values);
RC = calculatingSensitivity(values);

F1 =(2*PR*RC)/(PR+RC)
