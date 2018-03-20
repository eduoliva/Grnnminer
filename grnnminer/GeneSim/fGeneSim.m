% connect: red con los pesos de cada conexion (0 = conexion inexsitente)
% obs: cantidad de instantes de tiempo simulados de una variable
% inv: cada cuántas obs se toma como muestra para el la salida

%data1: matriz salida (obs x genes)

function [data1] = fGeneSim(archi,obs,inv,sessionId)             

connect=csvread(archi);

influence_bin = .05; 
influence_number = 4;

% mpr
nodes = size(connect,1);

% nodes = 14;
% connect = zeros(nodes,nodes);
% edges = 8 + floor(rand*5);
% i = 0;
% while i < edges
%    num = floor(rand*77);
%    to = num;
%    for j = 0:12
%       tmp = to - (12-j);
%       if tmp < 0
%          from = j;
%          break;
%       else
%          to = tmp;
%       end;
%    end;
%    to = to + from + 1;
%    if floor(rand*2) > 0
% 	   if ((connect(to+1, from+1) == 0) & (connect(from+1, to+1) == 0))
%            if floor(rand*2) > 0
%                connect(to+1, from+1) = influence_bin * ceil(rand *
%                influence_number);
%            else
%                connect(to+1, from+1) = -influence_bin * ceil(rand *
%                influence_number);
%            end;
%            i = i + 1;
%        end;
%    else
%        if ((connect(from+1, to+1) == 0) & (connect(to+1, from+1) == 0))
%            if floor(rand*2) > 0
%                connect(from+1, to+1) = influence_bin * ceil(rand *
%                influence_number);
%            else
%                connect(from+1, to+1) = -influence_bin * ceil(rand *
%                influence_number);
%            end;
%            i = i + 1;
%        end;
%    end;
% end;

%1% 
% connect(3,1) = .05;
% connect(4,5) = -.05;
% connect(6,3) = .2;
% connect(7,2) = .2;
% connect(8,6) = .2;
% connect(9,5) = -.05;
% connect(10,2) = .2;
% connect(10,7) = .15;
% connect(11,10) = -.1;
% connect(12,11) = -.15;
% connect(13,4) = .15;
% connect(13,8) = .05;

%2
%connect(2,11) = .05;
%connect(3,7) = .05;
%connect(5,9) = -.05;
%connect(7,2) = .05;
%connect(7,10) = -.05;
%connect(8,3) = .05;
%connect(8,5) = -.1;
%connect(9,3) = .1;
%connect(9,4) = -.15;
%connect(12,11) = -.1;
%connect(13,3) = -.05;


%3
%connect(4,1) = .1;
%connect(7,11) = -.05;
%connect(9,1) = .05;
%connect(9,8) = -.05;
%connect(10,6) = .05;
%connect(11,8) = -.2;
%connect(12,7) = .15;
%connect(12,10) = -.2;


%4
%connect(1,7) = -.05;
%connect(3,5) = -.2;
%connect(6,2) = .15;
%connect(7,9) = .05;
%connect(8,11) = .2;
%connect(11,5) = .05;
%connect(12,6) = -.1;
%connect(13,1) = .1;
%connect(13,4) = -.2;

%5
%connect(1,12) = -.15;
%connect(2,3) = -.05;
%connect(3,1) = -.2;
%connect(7,8) = -.2;
%connect(11,3) = .1;
%connect(12,4) = -.1;
%connect(12,11) = -.05;
%connect(13,7) = -.2;
%connect(13,10) = -.1;

%6
%connect(1,4) = .2;
%connect(1,9) = .05;
%connect(1,10) = -.15;
%connect(2,8) = .05;
%connect(3,10) = -.15;
%connect(4,9) = .05;
%connect(5,12) = -.1;
%connect(7,10) = -.05;
%connect(8,3) = .1;
%connect(8,4) = .2;
%connect(10,11) = .15;
%connect(12,10) = -.1;

%7
%connect(1,9) = -.15;
%connect(2,7) = -.2;
%connect(4,7) = .05;
%connect(5,6) = .1;
%connect(8,1) = -.05;
%connect(8,5) = -.1;
%connect(10,13) = .2;
%connect(11,4) = .2;
%connect(11,9) = -.15;
%connect(12,7) = .1;

%8
% connect(1,7) = 0.05; %0.15; %.05;
% connect(2,12) = 0.05; %0.15; %.2;
% connect(4,10) = 0.05; %0.15; %.2;
% connect(5,1) = 0.05; %0.15;  %0.2;%-.15;
% connect(5,3) = 0.05; %0.15; %0.01;%.15;
% connect(6,3) = 0.05; %0.15;% .2;
% connect(10,6) = 0.05; %0.15; %-.05;
% connect(13,4) = 0.05; %0.15; %-.05;

%9
%connect(1,6) = .2;
%connect(2,8) = .05;
%connect(2,10) = -.05;
%connect(5,3) = -.2;
%connect(5,10) = -.1;
%connect(5,11) = -.1;
%connect(6,5) = .1;
%connect(8,1) = .2;
%connect(10,7) = .1;
%connect(11,2) = -.15;
%connect(12,7) = .1;

%10
%connect(1,7) = .1;
%connect(2,1) = -.2;
%connect(5,1) = .2;
%connect(5,7) = .15;
%connect(6,13) = -.1;
%connect(7,12) = .2;
%connect(10,12) = -.1;
%connect(11,5) = -.2;
%connect(13,3) = -.1;
%connect(13,5) = .1;



%nodes = 20;
%obs = 500;
%inv = 5;
points = obs/inv;
Smax = ones(nodes,1)*100;
Th = .5*Smax;
OneObs = rand(nodes,1).*Smax;

data1 = [];
for i = 1:obs
   if mod(i,inv) == 0
      data1 = [data1; OneObs'];
   end;
   OneObs = OneObs + connect*(OneObs-Th) + (rand(nodes, 1)*.2-0.1).*Smax; 
   OneObs = min([OneObs'; Smax'])';
   OneObs = max([OneObs'; zeros(1, nodes)])';
end;

% figure;
%  for i = 1:13
%    subplot(13,1,i);
%    plot(data1(:,i));
%  end;

[m,n] = size(data1);

nameaux=strcat(sessionId,'_Datos_Simulados.csv');
ruta=pwd;
nameArch=[ruta '/DatosSimulados/' nameaux];

fid = fopen(nameArch, 'w');
%for i = 1:nodes
%    for j = 1:nodes
%        if connect(i,j) ~= 0
%            fprintf(fid, '%d -> %d\t%1.2f\n', j-1, i-1, connect(i,j));
%        end;
%    end;
%end;

%fprintf(fid, '\n');

for i = 1:m
   for j = 1:n
      fprintf(fid, '%1.10f', data1(i,j));
      if j<(n)
	fprintf(fid,',');
      end;
   end;
   fprintf(fid, '\n');
end;

fclose(fid);

