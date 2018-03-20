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
        <!-- Pregunto si subo un archivo de Parametros-->
                <?php
                if (isset($_POST['botonLoadParameters'])) {//determino si la variables contiene info o es null
                    if (move_uploaded_file($_FILES['uploadParameters']['tmp_name'], './ParametersCargados/' . $_SESSION['sesionId'] . $_FILES['uploadParameters']['name'])) {
                        $_SESSION['nameArchParameters'] = $_SESSION['sesionId'] . $_FILES['uploadParameters']['name']; //guardo el nombre del archivo que cargo para luego poder usarlo
                        $arhivo_subido_parameters = true;
                    } else {
                        $arhivo_subido_parameters = false;
                    }
                    ?>
                    <!-- Al cargar la página, según el valor de la variable que indica si el archivo se subió entonces mostrará el mensaje correspondiente, llamando a una función del padre. -->
                <?php if ($arhivo_subido_parameters): ?>
                        <script type="text/javascript">
                            parent.resultadoImportarParametros();
                        </script>

                <?php else: ?>
                      
                    <?php endif;
                }
                ?>
    </body>
</html>
