% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Calculating the average between epsilon and rho.
% 
% INPUT:
% sIJ: score obtained in relation I --> J
% sJI: score obtained in relation J --> I
% eIJ: error obtained in relation I --> J
% eJI: error obtained in relation J --> I
% 
% OUTPUT:
% average: average value between scores and errors
% -----------------------------------------------------------------------%

function[average] = calculatingAverage(sIJ,sJI,eIJ,eJI)

% Calculating RHO considering sIJ and sJI.
rho = (sIJ-sJI)/max(sIJ,sJI);

% Calculating EPSILON considering eIJ and eJI.
if(eIJ == 0) && (eJI == 0)
    epsilon = 0;
else
    epsilon = (eJI-eIJ)/max(eIJ,eJI);
end

% Calculating the AVERAGE.
average = (rho + epsilon)/2;

