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
            if (isset($_POST['botonlabel'])) {//determino si la variables contiene info o es null
                if (move_uploaded_file($_FILES['uploadLabel']['tmp_name'], './LabelCargadas/' . $_SESSION['sesionId'] . $_FILES['uploadLabel']['name'])) {
                    $_SESSION['nameArchLabel'] = $_SESSION['sesionId'] . $_FILES['uploadLabel']['name']; //guardo el nombre del archivo que cargo para luego poder usarlo
                    $arhivo_subido_label = true;
                } else {
                    $arhivo_subido_label = false;
                }
                ?>
                <!-- Al cargar la página, según el valor de la variable que indica si el archivo se subió entonces mostrará el mensaje correspondiente, llamando a una función del padre. -->
                <?php if ($arhivo_subido_label): ?>
                    <script type="text/javascript">
                        parent.resultadoOkLabel();

                    </script>

                <?php else: ?>
                    <script type="text/javascript">
                        parent.resultadoErroneoLabel();

                    </script>
                <?php endif;
            }
            ?>
    </body>
</html>
