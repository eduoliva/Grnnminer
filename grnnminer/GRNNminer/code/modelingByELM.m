% Rubiolo, M
% 201512
% modeling a gen-to-gen relationship by using ELM model

function [pred] = modelingByELM(inNormData,outNormData,testData,hiddenNeurons,actFunc,seed) 

    % ELM  training
    [Wi wb Wo]=elmregtrain(inNormData',outNormData',hiddenNeurons,actFunc,seed);
    % ELM  prediction
    pred=elmregtest(testData',Wi,wb,Wo,actFunc);

end