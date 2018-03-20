function H = activ(V,ActivationFunction)

switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        H = 1 ./ (1 + exp(-V));
    case {'sin','sine'}
        H = sin(V);        
    case {'hardlim'}
        H = hardlim(V);        
    case {'tribas'}
        H = tribas(V);        
    case {'radbas'}
        H = radbas(V);        
end
