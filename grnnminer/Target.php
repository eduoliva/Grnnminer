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
            if (isset($_POST['botontarget'])) {//determino si la variables contiene info o es null
                if (move_uploaded_file($_FILES['uploadTarget']['tmp_name'], './TargetCargadas/' . $_SESSION['sesionId'] . "_Target.csv")) {
                    $arhivo_subido_target = true;
                } else {
                    $arhivo_subido_target = false;
                }
                /*Comienza la validación si el archivo posee un caracter NO válido*/
                if (isset($_SESSION['nameArchTarget'])) {
                        if (file_exists('./TargetCargadas/' . $_SESSION['nameArchTarget'])) {
                            $flagArchiTargetNumber = false;
                            $cantFilTarget = 0;
                            $archiTempTarget = fopen(('./TargetCargadas/' . $_SESSION['nameArchTarget']), "r");
                            while ($targetVal = fgetcsv($archiTempTarget, 1000, ",")) {
                                $cantColTarget = count($targetVal);
                                
                                for ($i = 0; $i < $cantColTarget; $i++) {
                                    if (!is_numeric($targetVal[$i])) {
                                        $flagArchiTargetNumber = true;
                                    }
                                }
                                $cantFilTarget=$cantFilTarget+1;
                            }
                            fclose($archiTempTarget);
                            if($cantColTarget!=$cantFilTarget){
                                    $flagArchiTargetNumber = true;
                            }  
                        }
                    }
                ?>
                <?php if ($arhivo_subido_target): ?>
                    <script type="text/javascript">
                        parent.resultadoOkTarget();
                    </script>

                <?php else: ?>
                    <script type="text/javascript">
                        parent.resultadoErroneoTarget();
                    </script>
                <?php
                   endif;
                ?>
                    <!-- Muestro si el archivo no posee un caracter  NO válido-->
                <?php if ($flagArchiTargetNumber): ?>
                    <script type="text/javascript">
                        parent.location = "./Validaciones/ArchivoTargetIncorrecto.php";
                    </script>
                <?php else: ?>
                   
                <?php
                   endif;
                }
                ?>
    </body>
</html>
