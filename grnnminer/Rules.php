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
        <?php if (isset($_POST['botonSubmit'])) { 
            /* debo hacer si o si este tipo de validación para poder saber si esta tildada o no, ya que sino no reconoce el estado off */
            /* threshold */
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
            /* ESTA validación es solo para guardar el archivo, no es necesaria */

            $Acu = "Rules" . PHP_EOL;
            $Acu.="Threshold: " . $_SESSION['threshold'] . PHP_EOL;
            $Acu.="Theta: " . $_SESSION['theta'] . PHP_EOL;
            $Acu.="Simetric: " . $_SESSION['simetric'] . PHP_EOL;
            $Acu.="Unchained: " . $_SESSION['unchained'] . PHP_EOL;
            $filena = "./Rules/" . $_SESSION['sesionId'] . "rules.txt";
            $filer = fopen($filena, "w+");
            fwrite($filer, $Acu . PHP_EOL);
            fclose($filer);
        }
        ?>
    </body>
</html>
