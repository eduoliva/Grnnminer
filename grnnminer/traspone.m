function[]=traspone(dataFile,sessionId)
archi=csvread(dataFile);

nameaux=strcat(sessionId,'_DatosInvertidos.csv');
ruta=pwd;
nameArch=[ruta '/DatosInvertidos/' nameaux];
archi2=archi';
dlmwrite(nameArch, archi2);
end
