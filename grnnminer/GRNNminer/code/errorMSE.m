function [error] = errorMSE(output,target)
error = sqrt(mean((target-output).^2));
end