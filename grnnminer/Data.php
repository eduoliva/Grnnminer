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
            ///VER DE REALIZAR OTRO TIPO DE VALIDACION
            if (isset($_POST['boton'])) {//determino si la variables contiene info o es null
                if (move_uploaded_file($_FILES['uploadData']['tmp_name'], './DatosCargados/' . $_SESSION['sesionId'] . $_FILES['uploadData']['name'])) {
                    $_SESSION['nameArchData'] = $_SESSION['sesionId'] . $_FILES['uploadData']['name']; /* guardo el nombre del archivo que cargo para luego poder usarlo */
                    $arhivo_subido_data = true; /* si se subio correctamente pongo esta bandera en true, la bandera sirve para poder mostrar el tilde correcto o no y ademas asi subir el archivo por detras */
                } else {
                    $arhivo_subido_data = false;
                }
                /* Compruebo que el archivo de datos poseea todos valores numéricos */
                if (file_exists('./DatosCargados/' . $_SESSION['nameArchData'])) {
                    $_SESSION['FlagSimu']=false;
                    $flagArchiDataNumber = false;
                    $archiTempData = fopen(('./DatosCargados/' . $_SESSION['nameArchData']), "r");
                    while ($targetVal = fgetcsv($archiTempData, 1000, ",")) {
                        $cantCol = count($targetVal);
                        for ($i = 0; $i < $cantCol; $i++) {
                            if (!is_numeric($targetVal[$i])) {
                                $flagArchiDataNumber = true;
                            }
                        }
                    }
                    fclose($archiTempData);
                }
                ?>

                <!-- Al cargar la página, según el valor de la variable que indica si el archivo se subió entonces mostrará el mensaje correspondiente, llamando a una función del padre. -->
                <?php if ($arhivo_subido_data): ?>
                    <script type="text/javascript">
                        parent.resultadoOkData();
                    </script>
                <?php else: ?>
                    <script type="text/javascript">
                        parent.resultadoErroneoData();
                    </script>
                <?php endif;

?>
                <?php if ($flagArchiDataNumber): ?>
                    <script type="text/javascript">
                        parent.location ="./Validaciones/ArchivoDatosIncorrecto.php";
                    </script>
                <?php else: ?>
                <?php endif;
}
?>
    </body>
</html>
