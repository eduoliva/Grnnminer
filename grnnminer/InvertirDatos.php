<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
     /* Con esto creo el archivo de DATOS INVERTIDO para poder graficar */
    $MATLAB_inverter = "error_txt='';" . PHP_EOL;
    $MATLAB_inverter.="try" . PHP_EOL;
    $MATLAB_inverter.="input1='" . $_SESSION['nameArchData'] . "';" . PHP_EOL;
    $MATLAB_inverter.="input2='" . $_SESSION['sesionId'] . "';" . PHP_EOL;
    $MATLAB_inverter.="addpath('DatosCargados')" . PHP_EOL;
    $MATLAB_inverter.="addpath('DatosSimulados')" . PHP_EOL;
    $MATLAB_inverter.="traspone(input1,input2);" . PHP_EOL;
    $MATLAB_inverter.="quit;" . PHP_EOL;
    $MATLAB_inverter.="end" . PHP_EOL;

    $filenameInverter = "temp_inverter.m";
    $filetInverter = fopen($filenameInverter, "w+");
    fwrite($filetInverter, $MATLAB_inverter . PHP_EOL);
    fclose($filetInverter);

    $origenPath = './run.sh temp_inverter';
    exec($origenPath, $res, $status);



    $archi_c = file("./DatosInvertidos/" . $_SESSION['sesionId'] . "_DatosInvertidos.csv"); //guardo el archivo invertido en esta variable
    foreach ($archi_c as $num_linea_c => $linea_c) {//voy recorriendo las lineas y guardandolas en el arreglo
        $varios_c[$num_linea_c] = preg_split("/[\s,]+/", $linea_c); //es un arreglo multidimensional
    }
    $cant_fil = count($varios_c); //saco la cantidad de filas del archivo
    $cant_col = count($varios_c[0]); //saco la cantidad de columnas del archivo
        ?>
    </body>
</html>
