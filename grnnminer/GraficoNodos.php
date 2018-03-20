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
                
                var arrayJS =<?php echo json_encode($varios); ?>;//CONVIERTO EL ARREGLO DE PHP A JAVASCRIPT
                var flagLabelJS =<?php echo json_encode($flagLabel); ?>;//convierto la bandera
                var labelJS_aux =<?php echo json_encode($labelArchi); ?>;//convierto el arreglo de labels de php a javascript
                if (flagLabelJS === true) {
                    var labelJS = labelJS_aux[0].split(",");
                }
                //BORRO EL ESPACIO INICIAL Y ALGUN OTRO QUE MOLESTE
                for (var i = 0; i < arrayJS.length; i++) {
                    for (var j = 0; j < arrayJS.length; j++) {
                        if (isNaN(parseInt(arrayJS[i][j]))) {//pregunto si el caracter es un numero, si es NO entra al if..si NO lo es entra y lo borra
                            arrayJS[i].splice(j, 1);//elimino en la posicion j, 1 elemento 
                            //document.write(arrayJS[i][j]+" ");
                        }
                    }
                    //document.write("<br>");
                }

                // create an array with nodes
                var nodes = new vis.DataSet();//creo un vector vacio de nodos con ese constructor
                for (var i = 0; i < (arrayJS.length); i++) {//comienzo el for donde voy a ir metiendo todos los nodos
                    if (flagLabelJS === true) {//con este if veo que etiqueta pongo la del archivo o una generica si no hay archivo
                        //nodes.add({id: (i + 1), label: labelJS[i].split("\n").join(" "+(i + 1))});//agrego nodo por nodo, con el split elimino el enter final
                        nodes.add({id: (i + 1), label: labelJS[i]});//agrego nodo por nodo, con el split elimino el enter final
                    }
                    else {
                        nodes.add({id: (i + 1), label: 'Gene ' + (i + 1)});//agrego nodo por nodo
                    }
                }
                //{id: 1, label: 'Node 1'},

                // create an array with edges
                var edges = new vis.DataSet();
                var aristas = [];//Vector que me guarda las aristas
                var k = 1;//Contador para asignar ID a la arista
                for (var i = 0; i < (arrayJS.length); i++) {//RECORDAR QUE EL ARREGLO EMPIEZA DE CERO OJOOO
                    for (var j = 0; j < (arrayJS.length); j++) {
                        if (arrayJS[i][j] != 0) {
                            edges.add({id: k, from: (i + 1), to: (j + 1), label: arrayJS[i][j].toString()});//agrego las aristas
                            aristas[k] = [(i + 1), (j + 1)];//guardo las aristas para luego poder sacar los nodos para graficar cuando clickeo
                            k = k + 1;//aumento el contador
                        }
                    }
                }
                //{from: 1, to: 3},


                // create a network

                var container = document.getElementById('mynetwork');



                // provide the data in the vis format
                var data = {
                    nodes: nodes,
                    edges: edges
                };
                var options = {
                    edges: {
                        arrows: {
                            to: {enabled: true, scaleFactor: 1},
                            middle: {enabled: false, scaleFactor: 1},
                            from: {enabled: false, scaleFactor: 1},
                            id: {enabled: true}
                        },
                        label: {
                            enabled: true,
                            min: 14,
                            max: 30,
                            maxVisible: 100,
                            drawThreshold: 5
                        },
                        font: {
                            align: 'top'
                        },
                    },
                    interaction: {
                        dragNodes: true,
                        dragView: true,
                        hideEdgesOnDrag: false,
                        hideNodesOnDrag: false,
                        hover: true,
                        hoverConnectedEdges: true,
                        keyboard: {
                            enabled: true,
                            speed: {x: 10, y: 10, zoom: 0.02},
                            bindToWindow: true
                        },
                        navigationButtons: true,
                        selectable: true,
                        selectConnectedEdges: true,
                        tooltipDelay: 300,
                        zoomView: true,
                    },
                    nodes: {
                        color: {
                            border: '#2EFEC8',
                            background: '#A9F5E1',
                            highlight: {
                                border: '#2B7CE9',
                                background: '#D2E5FF'},
                        },
                    },
                };

                //network.setOptions(options);
                // initialize your network!
                var network = new vis.Network(container, data, options);

            </script>
  
    </body>
</html>
