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
         <script>

                $(document).ready(function () {
                    var element = $("#mynetwork"); // global variable
                    var getCanvas; // global variable
                    html2canvas(element, {
                        onrendered: function (canvas) {
                            getCanvas = canvas;
                        }
                    });
                    $("#downloadGraphic").on('click', function () {
                        var imgageData = getCanvas.toDataURL("image/png");
                        // Now browser starts downloading it instead of just showing it
                        var newData = imgageData.replace(/^data:image\/png/, "data:application/octet-stream");
                        $("#downloadGraphic").attr("download", "Result_GRN_Graphic.png").attr("href", newData);
                    });
                });
                //CON ESTO DE ABAJO LOGRO HACER LO DE LA INFOOO            
                //SI HAGO UN CLICK SOBRE UN NODO ME MUESTRA LA INFOR CONTEXTUAL 
                /*document.getElementById("pholder").innerHTML=""; ESTE FUNCIONA BIEN, NO TOCAR*/
                network.on("click", function (params) {

                    params.event = "[original event]";
                    //document.getElementById('eventSpan').innerHTML = params.nodes;
                    var nodeClick = (parseInt(params.nodes));
                    //Comienzo la lectura del archivo PARA MOSTRAR LA INFO CONTEXTUAL
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
                    var arrayJS_c = <?php echo json_encode($varios_c); ?>;//CONVIERTO EL ARREGLO DE PHP A JAVASCRIPT
                    var cant_filas = <?php echo json_encode($cant_fil); ?>;
                    var cant_columnas = <?php echo json_encode($cant_col); ?>;
                    //BORRO EL ESPACIO INICIAL Y ALGUN OTRO QUE MOLESTE

                    for (var i = 0; i < cant_filas; i++) { //
                        for (var j = 0; j < cant_columnas; j++) {
                            if (isNaN(parseInt(arrayJS_c[i][j]))) {//pregunto si el caracter es un numero, si es NO entra al if..si NO lo es entra y lo borra
                                arrayJS_c[i].splice(j, 1);//elimino en la posicion j, 1 elemento 
                                //document.write(arrayJS[i][j]+" ");
                            }
                        }
                    }

                    //document.write(nodeClick);
                    //arrayJS-->Matriz que contiene la relación entre los nodos con los pesos de ponderación
                    //arrayJS_c-->contiene los valores en los distintos instantes de tiempo.
                    //nodeClick-->Nodo donde hice click(recordar sacarle 1 ya que empieza de 1 y el arreglo de 0)

                    if (!isNaN(nodeClick)) {//ESTE IF ME DIFERENCIA SI CLICKEO EN UN NODO O ARISTA (ESTE CASO ES EN UN NODO)
                        var aux_c = arrayJS_c[nodeClick - 1]; //saco la linea del nodo donde hice click
                        var acum = [nodeClick - 1]; //Guardo primero el nodo y luego los nodos con los que se relaciona

                        //for que me saca la relación de un nodo con los que le preceden(los que le apuntan)
                        for (var i = 0; i < cant_filas; i++) {
                            if (arrayJS[i][nodeClick - 1] != 0) {
                                acum.push(i);
                            }
                        }
                        //for que me saca la relación de un nodo con los que le siguen(a los que apunta)
                        for (var i = 0; i < cant_filas; i++) {
                            if (arrayJS[nodeClick - 1][i] != 0) {
                                acum.push(i);
                            }
                        }
                        var auxtamacum = acum.length; //guardo la cantidad de nodos con los q se relaciona
                        var d1 = []; //arreglo temporal que voy usando para guardar los valores
                        var d2 = new Array(auxtamacum);//voy guardando los valores para luego graficar  
                        $(function () {
                            for (var i = 0; i < (auxtamacum); i++) {
                                aux_c = arrayJS_c[acum[i]];//saco una linea correspondiente a un nodo en particular
                                for (var j = -1; j < cant_columnas; j++) { //OBSERVACION si ponemos (cant_columnas -1) logramos que entre entrero pero al posicionarse sobre el punto no se ven las coordenadas y lo mismo sucede al poner j=0 y NO j=-1 como está ahora
                                    d1.push([(j + 1), aux_c[j]]);//armo un vector para graficar, que cuenta del instante de tiempo y el valor del mismo                       
                                }
                                if (flagLabelJS === true) {//este if es necesario si hay etiquetas
                                    //d2[i]={ label: labelJS[i].split("\n").join(" "+(acum[i]+1)), data: d1 };

                                    d2[i] = {label: labelJS[acum[i]].split(","), data: d1};
                                }
                                else {
                                    d2[i] = {label: "Gene " + (acum[i] + 1), data: d1};//etiquetado General
                                }

                                d1 = [];
                            }

                            var opciones = {points: {show: true}, //CONFIGURO LAS OPCIONES DE LA GRAFICA
                                lines: {show: true},
                                legend: {show: true, position: "nw"},
                                grid: {clickable: true, hoverable: true}

                            };
                            $.plot($("#pholder"), d2, opciones);
                        });
                    }
                    else {//PARTE DEL IF SI CLICKEO EN ARISTA
                        var edgeDoubleClick = params.edges; //aca saco en que nodo hice click! :)
                        var nodo1 = aristas[edgeDoubleClick][0];//obtengo el primer nodo de la arista
                        var nodo2 = aristas[edgeDoubleClick][1];//obtengo el segundo nodo de la arista
                        var nodo1IT = arrayJS_c[nodo1 - 1]; //saco la linea del nodo1 de la arista
                        var nodo2IT = arrayJS_c[nodo2 - 1]; //saco la linea del nodo2 de la arista
                        var d1_e = []; //arreglo temporal que voy usando para guardar los valores del nodo 1
                        var d2_e = []; //arreglo temporal que voy usando para guardar los valores del nodo 2
                        var d3 = new Array(2);//voy guardando los valores para luego graficar  

                        $(function () {
                            for (var j = -1; j < cant_columnas; j++) { //OBSERVACION si ponemos (cant_columnas -1) logramos que entre entrero pero al posicionarse sobre el punto no se ven las coordenadas y lo mismo sucede al poner j=0 y NO j=-1 como está ahora
                                d1_e.push([(j + 1), nodo1IT[j]]);//armo un vector para graficar el nodo1, que cuenta del instante de tiempo y el valor del mismo
                                d2_e.push([(j + 1), nodo2IT[j]]);//armo un vector para graficar el nodo2, que cuenta del instante de tiempo y el valor del mismo
                            }
                            if (flagLabelJS === true) {//este if es necesario si hay etiquetas
                                //d3[0]={ label: labelJS[nodo1-1].split("\n").join(" "+nodo1), data: d1_e};
                                //d3[1]={ label: labelJS[nodo2-1].split("\n").join(" "+nodo2), data: d2_e};                
                                d3[0] = {label: labelJS[nodo1 - 1], data: d1_e};
                                d3[1] = {label: labelJS[nodo2 - 1], data: d2_e};
                            }
                            else {
                                d3[0] = {label: "Gen " + nodo1, data: d1_e};//etiquetado General
                                d3[1] = {label: "Gen " + nodo2, data: d2_e};//etiquetado General
                            }

                            var opciones = {points: {show: true}, //CONFIGURO LAS OPCIONES DE LA GRAFICA
                                lines: {show: true},
                                legend: {position: "nw"},
                                grid: {clickable: true, hoverable: true}};
                            $.plot($("#pholder"), d3, opciones);
                        });

                    }

                    //FUNCION NECESARIA PARA PODER MOSTRAR LOS PUNTOS CON LAS LEYENDAS
                    function showTooltip(x, y, contents) {
                        $('<div id="tooltip">' + contents + '</div>').css({
                            position: 'absolute', display: 'none', top: y + 5, left: x + 5,
                            border: '1px solid #fdd', padding: '2px', 'background-color': '#fee', opacity: 0.80
                        }).appendTo("body").fadeIn(200);
                    }
                    $("#pholder").bind("plothover", function (event, pos, item) {
                        $("#tooltip").remove();
                        if (item) {
                            var x = item.datapoint[0].toFixed(0), y = item.datapoint[1].toFixed(5);/* En el fixed cambio los decimales*/
                            showTooltip(item.pageX, item.pageY, "point (" + x + " , " + y + ")");
                        }
                    });

                    //aca saco en que nodo hice click! :)
                });
                network.on("doubleClick", function (params) {
                    //params.event = "[original event]";
                    //document.getElementById('eventSpan').innerHTML = params.edges;

                });

                network.on("select", function (params) {
                    console.log('select Event:', params);
                });
                network.on("selectNode", function (params) {
                    console.log('selectNode Event:', params);
                });
                network.on("selectEdge", function (params) {
                    console.log('selectEdge Event:', params);
                });
                network.on("deselectNode", function (params) {
                    console.log('deselectNode Event:', params);
                });
                network.on("deselectEdge", function (params) {
                    console.log('deselectEdge Event:', params);
                });

            </script>
            <a href="<?php echo $_SESSION['nameArchResults']; ?>" style="position: absolute; top:50.5%; left: 40.5%;" download="Results GRN Matrix.csv">
                    Download GRN Matrix </a>
            <a id="downloadGraphic" href="#" style="position: absolute; top:50.5%; left: 80.5%;" download="Results GRN Graphic">
                    Download GRN Graphic </a>
    </body>
</html>
