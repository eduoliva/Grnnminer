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
                    /*Seteo los parámetros a través de un archivo que el usuario carga*/
                    if (isset($_POST['botonLoadParameters'])) {
                        $archiTempParam = fopen(('./ParametersCargados/'.$_SESSION['nameArchParameters']), "r");
                        $index=0;
                            while(!feof($archiTempParam)){    
                                $contenido= fgets($archiTempParam);
                                $contenido_aux=explode(" ", $contenido);
                                $AcumuladorParam[$index] = $contenido_aux[1];                                  
                                $index=$index+1;
                            }
                        fclose($archiTempParam);
                        $_SESSION['DeltaT'] = trim($AcumuladorParam[0]);
                        $_SESSION['Repetitions'] = trim($AcumuladorParam[1]);
                        $_SESSION['HiddenUnits'] = trim($AcumuladorParam[2]);
                        $_SESSION['Epochs'] = trim($AcumuladorParam[3]);
                        $_SESSION['NeuralNetwork'] = trim($AcumuladorParam[4]);
                        $_SESSION['threshold'] = trim($AcumuladorParam[5]);
                        $_SESSION['theta'] = trim($AcumuladorParam[6]);
                        $_SESSION['simetric'] = trim($AcumuladorParam[7]);
                        $_SESSION['unchained'] = trim($AcumuladorParam[8]);
                
                         $_SESSION['flagValArchiParam']=false;
                        if(!is_numeric($_SESSION['DeltaT'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(!is_numeric($_SESSION['Repetitions'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(!is_numeric($_SESSION['HiddenUnits'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(!is_numeric($_SESSION['Epochs'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(is_numeric($_SESSION['NeuralNetwork'])){
                           $_SESSION['flagValArchiParam']=true;
                        }
                        if(is_numeric($_SESSION['threshold'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(!is_numeric($_SESSION['theta'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(is_numeric($_SESSION['simetric'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                        if(is_numeric($_SESSION['unchained'])){
                            $_SESSION['flagValArchiParam']=true;
                        }
                     ?>   
                      
                    <?php if ($_SESSION['flagValArchiParam']): ?>
                        <script type="text/javascript">
                            parent.location = "./Validaciones/ArchivoParametrosIncorrectos.php";
                        </script>
                    <?php else: ?>
                    <?php
                        endif;
                    ?>
                  <?php  
                        $varRulesAcum = "["; /* Me sirve para acumular y armar bien el vector que va a tener las reglas */
                    /*Realizo las validaciones necesarias para cargar las reglas provenientes del archivo de parámetros*/
                    if ($_SESSION['threshold']==='on') {
                        $varRulesAcum.="'T'";
                        if ($_SESSION['simetric']==='on') {
                        $varRulesAcum.= ","."'S'";
                            if ($_SESSION['unchained']==='on') {
                            $varRulesAcum.=","."'U'";
                            $varRulesAcum.="]";}
                            else{
                            $varRulesAcum.="]";    
                            }
                        } else {
                            if ($_SESSION['unchained']==='on') {
                            $varRulesAcum.=","."'U'";
                            $varRulesAcum.="]";}
                            else{
                            $varRulesAcum.="]";    
                            }
                        }
                    }
                    else{
                        if ($_SESSION['simetric']==='on') {
                        $varRulesAcum.= "'S'";
                            if ($_SESSION['unchained']==='on') {
                            $varRulesAcum.=","."'U'";
                            $varRulesAcum.="]";}
                            else{
                            $varRulesAcum.="]";    
                            }
                        }
                        else{
                            if ($_SESSION['unchained']==='on') {
                            $varRulesAcum.="'U'";
                            $varRulesAcum.="]";}
                            else{
                             $varRulesAcum.="]";   
                            }
                        }
                    }
                    
                    $_SESSION['Rules'] = $varRulesAcum; /* Vector definitivo de reglas */
                    $_SESSION['FlagParameters'] = true;    
                    }
                    
                /*Si el usuario decide guardar los parámetros y no utilizar un archivo de configuración*/                   
                if (isset($_POST['botonParameters'])) {
                    $varRulesAcum = "["; /* Me sirve para acumular y armar bien el vector que va a tener las reglas */
                    if (isset($_POST['thres'])) {
                        $_SESSION['threshold'] = $_POST['thres'];
                        $_SESSION['theta'] = $_POST['tita'];
                        $varRulesAcum.="'T'" . ",";
                    } else {
                        $_SESSION['threshold'] = 'off';
                        $_SESSION['theta'] = 0; /* Aclarar que le puse cero...preguntar que valor iria */
                    }
                    /* simetric */
                    if (isset($_POST['sim'])) {
                        $_SESSION['simetric'] = $_POST['sim'];
                        $varRulesAcum.="'S'" . ",";
                    } else {
                        $_SESSION['simetric'] = 'off';
                    }
                    /* unchained */
                    if (isset($_POST['unch'])) {
                        $_SESSION['unchained'] = $_POST['unch'];
                        $varRulesAcum.="'U'";
                    } else {
                        $_SESSION['unchained'] = 'off';
                    }
                    $varRulesAcum.="]";
                    $_SESSION['Rules'] = $varRulesAcum; /* Vector definitivo de reglas */
                    
                    $AcumuladorParameters= "DeltaT: " . $_POST['delta'] . PHP_EOL;
                    $AcumuladorParameters.= "Repetitions: " . $_POST['rep'] . PHP_EOL;
                    $AcumuladorParameters.= "HiddenUnits: " . $_POST['hu'] . PHP_EOL;
                    $AcumuladorParameters.= "Epochs: " . $_POST['epcs'] . PHP_EOL;
                    $AcumuladorParameters.= "NeuralNetwork: " . $_POST['NN'] . PHP_EOL;
                    $AcumuladorParameters.= "Threshold: " . $_SESSION['threshold'] . PHP_EOL;
                    $AcumuladorParameters.= "Theta: " . $_SESSION['theta'] . PHP_EOL;
                    $AcumuladorParameters.= "Simetric: " . $_SESSION['simetric'] . PHP_EOL;
                    $AcumuladorParameters.= "Unchained: " . $_SESSION['unchained'] . PHP_EOL;
                    $filenameParameters = "./ParametrosExportados/" . $_SESSION['sesionId'] . "Parameters.txt";
                    $fileParameters = fopen($filenameParameters, "w+");
                    fwrite($fileParameters, $AcumuladorParameters . PHP_EOL);
                    fclose($fileParameters);
                    $_SESSION['nameArchParameters'] = "./ParametrosExportados/" . $_SESSION['sesionId'] . "Parameters.txt";
                    $_SESSION['DeltaT'] = $_POST['delta'];
                    $_SESSION['Repetitions'] = $_POST['rep'];
                    $_SESSION['HiddenUnits'] = $_POST['hu'];
                    $_SESSION['Epochs'] = $_POST['epcs'];
                    $_SESSION['NeuralNetwork'] = $_POST['NN'];
                    $_SESSION['FlagParameters'] = true;
                    }
                    ?>
                
                <?php if (isset($_POST['botonParameters'])): ?>
                    <script type="text/javascript">
                        parent.resultadoExportarParametros();
                    </script>
                <?php else: ?>
                <?php
                    endif;
                ?>
                   
                     
    </body>
</html>
