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
        session_start(); //Comienzo una sesion que me va a servir para identificar los archivos.
        $_SESSION['sesionId'] = session_id(); 
        ?>
        <form  action="../index.php" enctype="multipart/form-data">
            <h4 align="center">THE PARAMETERS FILE HAS AN INVALID CHARACTER. TRY AGAIN PLEASE</h4>    
            <input style="position: absolute;left: 46%;" type="submit" name="boton1" value="Return Home" class="boton1"/>
            <?php
                $varAux='../ParametersCargados/' . $_SESSION['nameArchParameters'];
                unlink($varAux);
                
                
            ?>
        </form>
    </body>
</html>
