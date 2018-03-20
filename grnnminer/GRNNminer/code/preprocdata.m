data = dataD410g1n5g10r21ts';
points = 21;
timeSeries = 10;

var = size(data,2);
ppdata = [];
figure
for i=1:size(data,2)
    a = data(:,i);
    ra = reshape(a,points,timeSeries);
    rma = mean(ra,2);
    ppdata = [ppdata rma];
    plot(rma), hold on
end

% plot(rma1,'b'), hold on, plot(rma2,'r'), hold on, plot(rma3,'g')
% ppdata = [rma1,rma2,rma3];
% csvwrite('dataD410g1n5g1r501ts.csv',ppdata');


