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
        

        <script type="text/javascript">    
                $(document).ready(function () {
                    var flagGen=false;
                    $("#botonGen").click(function () {
                        flagGen=true;
                        cambiarPestanna(pestanas,pestana2);
                        $("#optionSimulated").show();
                        $("#optionData").hide();
                    });
                    if(flagGen){
                    cambiarPestanna(pestanas,pestana1);
                        $("#optionSimulated").hide();
                        $("#optionData").show();
                    }
                });
            </script>
            
            <?php
            //Comienzo la comprobación del archivo de etiquetas 
            if (isset($_SESSION['nameArchLabel'])) {//pregunto si la variable esta seteada para saber si hay archivo o no
                if (file_exists("./LabelCargadas/" . $_SESSION['nameArchLabel'])) {//pregunto si el archivo existe
                    $labelArchi = file("./LabelCargadas/" . $_SESSION['nameArchLabel']);
                    $flagLabel = true;
                } else {?>
            
            <?php

                    /* Con esto creo el archivo de Label Predeterminados */
                    $MATLAB_label = "error_txt='';" . PHP_EOL;
                    $MATLAB_label.="try" . PHP_EOL;
                    $MATLAB_label.="input1='" . $_SESSION['nameArchData'] . "';" . PHP_EOL;
                    $MATLAB_label.="input2='" . $_SESSION['sesionId'] . "';" . PHP_EOL;
                    $MATLAB_label.="addpath('DatosCargados')" . PHP_EOL;
                    $MATLAB_label.="addpath('DatosSimulados')" . PHP_EOL;
                    $MATLAB_label.="archiLabel(input1,input2);" . PHP_EOL;
                    $MATLAB_label.="quit;" . PHP_EOL;
                    $MATLAB_label.="end" . PHP_EOL;

                    $filenameLabel = "temp_label.m";
                    $filetLabel = fopen($filenameLabel, "w+");
                    fwrite($filetLabel, $MATLAB_label . PHP_EOL);
                    fclose($filetLabel);

                    $origenPath = './run.sh "temp_label"';
                    exec($origenPath, $res, $status);

                    $labelArchi = [];
                    $flagLabel = false;
                    $_SESSION['nameArchLabelPredeterminadas'] = $_SESSION['sesionId'] . "_LabelsPredeterminadas.csv";
                }
            } else {?>
        
            <?php
                /* Con esto creo el archivo de Label Predeterminados */
                $MATLAB_label = "error_txt='';" . PHP_EOL;
                $MATLAB_label.="try" . PHP_EOL;
                $MATLAB_label.="input1='" . $_SESSION['nameArchData'] . "';" . PHP_EOL;
                $MATLAB_label.="input2='" . $_SESSION['sesionId'] . "';" . PHP_EOL;
                $MATLAB_label.="addpath('DatosCargados')" . PHP_EOL;
                $MATLAB_label.="addpath('DatosSimulados')" . PHP_EOL;
                $MATLAB_label.="archiLabel(input1,input2);" . PHP_EOL;
                $MATLAB_label.="quit;" . PHP_EOL;
                $MATLAB_label.="end" . PHP_EOL;

                $filenameLabel = "temp_label.m";
                $filetLabel = fopen($filenameLabel, "w+");
                fwrite($filetLabel, $MATLAB_label . PHP_EOL);
                fclose($filetLabel);



                $origenPath = './run.sh temp_label';
                exec($origenPath, $res, $status);


                $labelArchi = [];
                $flagLabel = false;
                $_SESSION['nameArchLabelPredeterminadas'] = $_SESSION['sesionId'] . "_LabelsPredeterminadas.csv";
            }
            /* COMIENZO A LLAMAR LOS ALGORITMOS DE GRNNMINER */


            $MATLAB_miner = "error_txt='';" . PHP_EOL;
            $MATLAB_miner.="try" . PHP_EOL;

            /* DATOS */

            $MATLAB_miner.="input1='" . $_SESSION['nameArchData'] . "';" . PHP_EOL; /* path del archivo de datos Generados */


            /* TARGET */
            if (file_exists("./TargetCargadas/" . $_SESSION['nameArchTarget'])) {
                $MATLAB_miner.="input2='" . $_SESSION['nameArchTarget'] . "';" . PHP_EOL; /* path del archivo Target */
                $flagTarget = true;
            } else {
                $MATLAB_miner.="input2='';" . PHP_EOL;
                $flagTarget = false;
            }
            /* LABELS */
            if ($flagLabel) {/* Necesario agregarlo por si no hay archivo de etiquetas */

                $MATLAB_miner.="input3='" . $_SESSION['nameArchLabel'] . "';" . PHP_EOL; /* path del archivo Labels */
            } else {
                $MATLAB_miner.="input3='" . $_SESSION['nameArchLabelPredeterminadas'] . "';" . PHP_EOL; /* No hay archivo de Labels cargado */
            }

            /* GENESIM */
            if (isset($_SESSION['nameArchData'])) {
                if (file_exists("./DatosCargados/" . $_SESSION['nameArchData']) || file_exists("./DatosSimulados/" . $_SESSION['nameArchData'])) {/* la variable 'nameArchGeneSim se setea siempre por eso pregunto si existe el archivo, en cambio 'nameArchData' solo se setea cuando cargo un archivo */
                    $flagArchi = true;
                } else {
                    $flagArchi = false;
                }
            } else {
                $flagArchi = false;
            }?>
            <!--Falta cargar archivo Datos -->
            <script type="text/javascript">
                var flagData =<?php echo json_encode($flagArchi); ?>;
                if (flagData === false) {
                    window.location = "./Validaciones/CargueArchivoData.php";
                }
                else {
                    flagData = true;
                }
            </script>
        <?php
            /* para sacar la cantidad de genes que hay */
            if (file_exists("./DatosCargados/" . $_SESSION['nameArchData'])) {
                $archiTempFilas=file("./DatosCargados/" . $_SESSION['nameArchData']);
                foreach ($archiTempFilas as $num_linea_t => $linea_t) {//voy recorriendo las lineas y guardandolas en el arreglo
                   $archiTempFilas_t[$num_linea_t] = preg_split("/[\s,]+/", $linea_t); //es un arreglo multidimensional
                }
                $_SESSION['CantGenes'] = count($archiTempFilas_t[0])-1; /* saco la cantidad de filas del archivo target y obtengo el número de genes. */
                $_SESSION['FlagSimu']=false;
                
                }
            if (file_exists("./DatosSimulados/" . $_SESSION['nameArchData'])) {
                $archiTempFilas=file("./DatosSimulados/" . $_SESSION['nameArchData']);
                foreach ($archiTempFilas as $num_linea_t => $linea_t) {//voy recorriendo las lineas y guardandolas en el arreglo
                   $archiTempFilas_t[$num_linea_t] = preg_split("/[\s,]+/", $linea_t); //es un arreglo multidimensional
                }
                $_SESSION['CantGenes'] = count($archiTempFilas_t[0])-1;
                $_SESSION['FlagSimu']=true;
            }

            /* $_SESSION['CantGenes']=count(file("./TargetCargadas/".$_SESSION['nameArchTarget']));/*saco la cantidad de filas del archivo target y obtengo el número de genes. */
            $MATLAB_miner.="input4=" . $_SESSION['CantGenes'] . ";" . PHP_EOL;   /* numero de genes */
            $MATLAB_miner.="input5=" . $_SESSION['DeltaT'] . ";" . PHP_EOL;   /* retardo temporal considerado */
            $MATLAB_miner.="input6=" . $_SESSION['Repetitions'] . ";" . PHP_EOL;   /* repeticiones del modelado gen a gen */
            $MATLAB_miner.="input7='" . $_SESSION['NeuralNetwork'] . "';" . PHP_EOL;   /* tipo de red neuronal */
            $MATLAB_miner.="input8=" . $_SESSION['HiddenUnits'] . ";" . PHP_EOL;   /* numero de entradas en la capa oculta */
            $MATLAB_miner.="input9=" . $_SESSION['Epochs'] . ";" . PHP_EOL;   /* numero de épocas */
            $MATLAB_miner.="input10=" . $_SESSION['Rules'] . ";" . PHP_EOL;   /* reglas */
            $MATLAB_miner.="input11=" . $_SESSION['theta'] . ";" . PHP_EOL;   /* valor asignado a threshold */
            $MATLAB_miner.="addpath('GRNNminer')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('GRNNminer/data')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('GRNNminer/data/IRMA')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('GRNNminer/code')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('GRNNminer/out')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('DatosCargados')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('LabelCargadas')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('TargetCargadas')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('DatosSimulados')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="addpath('LabelPredeterminadas')" . PHP_EOL;   /* agrego al path el directorio donde se va a ejecutar el miner */
            $MATLAB_miner.="[output1,output2]=mainWeb(input1,input2,input3,input4,input5,input6,input7,input8,input9,input10,input11);" . PHP_EOL;
            $MATLAB_miner.="quit;" . PHP_EOL;
            $MATLAB_miner.="end" . PHP_EOL;

            $filenameMiner = "temp_miner.m";
            $fileMiner = fopen($filenameMiner, "w+");
            fwrite($fileMiner, $MATLAB_miner . PHP_EOL);
            fclose($fileMiner);

            $origenPathMiner = './run.sh temp_miner';
            exec($origenPathMiner, $res, $status);
            if(!file_exists("./GRNNminer/out/test.csv")){?>
                <script type="text/javascript">
                    window.location = "./Validaciones/ErrorGrnnminer.php";
                </script>
            <?php  
            }
            else{
                unlink("./GRNNminer/out/test.csv");
            }
            /* RENOMBRO Y REDIRECCIONO ARCHIVO FINAL CON LA RED PARA LUEGO GRAFICAR */
            $_SESSION['Results'] = $_SESSION['sesionId'] . "Results.csv";
            copy("./GRNNminer/out/net.csv", "./Results/" . $_SESSION['Results']);
            $archi = file("./Results/" . $_SESSION['Results']); //guardo el archivo en esa variable
            foreach ($archi as $num_linea => $linea) {//voy recorriendo las lineas y guardandolas en el arreglo
                $varios[$num_linea] = preg_split("/[\s,]+/", $linea); //es un arreglo multidimensional
            }
            ?>
             
            


    </body>
</html>
