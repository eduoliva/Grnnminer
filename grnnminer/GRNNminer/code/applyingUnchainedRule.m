% -----------------------------------------------------------------------%
% 201405
% Rubiolo, Milone and Stegmayer. 
% Applying SIMETRIC rule.
% 
% INPUT:
% incomingMatrix: incoming scores matrix.
% errorsMatrix: errors matrix.
% 
% OUTPUT:
% resultantMatrix: resultant matrix after the rule application.
% -----------------------------------------------------------------------%

function[resultantMatrix] = applyingUnchainedRule(incomingMatrix,errorsMatrix)

% updating experiments state on command window
disp('--------------------');
disp('Applying Unchained rule... ');


% initializing variables 
resultantMatrix = incomingMatrix;

% normalizing errors
normErrorsMatrix = normalizingMSEmatrix(errorsMatrix);

% obtaining existing chains between genes
chains = obtainingChains(incomingMatrix);

for c=1:size(chains,1)
      % scores of regulations I->J and J->K
      sIJJK = incomingMatrix(chains(c,1),chains(c,2))+...
              incomingMatrix(chains(c,2),chains(c,3));
      % scores of regulations I->J and I->K
      sIJIK = incomingMatrix(chains(c,1),chains(c,2))+...
              incomingMatrix(chains(c,1),chains(c,3));
      % errors of regulations I->J and J->K
      eIJJK = normErrorsMatrix(chains(c,1),chains(c,2))+...
              normErrorsMatrix(chains(c,2),chains(c,3));
      % errors of regulations I->J and I->K
      eIJIK = normErrorsMatrix(chains(c,1),chains(c,2))+...
              normErrorsMatrix(chains(c,1),chains(c,3));

       % calculating average between rho and epsilon values
       avgValue = calculatingAverage(sIJJK,sIJIK,eIJJK,eIJIK);
       
       % remaining the correct relations
       if avgValue > 0 
          % remains I->J and J->K regulations
          resultantMatrix(chains(c,1),chains(c,3)) = 0;
       elseif avgValue < 0 
          % remains I->J and I->k regulations
          resultantMatrix(chains(c,2),chains(c,3)) = 0;
       end
       
       % updating existing list for unchaining
       chains = obtainingChains(incomingMatrix);
end
end
