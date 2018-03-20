% function writeHTML(pathway, name)
function writeHTML(grn,label)

%pathway = Pathway2JSON(geneticPool, Individual, COMPOUNDS, name);


% OPEN THE HTML FILE
eval(sprintf('fid = fopen(''GRNNminer/out/grn.html'',''w'');'));

%==========================================================================
fprintf(fid,'<!DOCTYPE html>\n');
fprintf(fid,'<html lang="en">\n');
fprintf(fid,'<meta charset="utf-8">\n');
fprintf(fid,'    <head>\n');

fprintf(fid,'        <title>Discovered GRN</title>\n');
        
fprintf(fid,'        <meta charset="utf-8">\n');
fprintf(fid,'        <script type="text/javascript" src="d3.v3.min.js"></script>\n');
% fprintf(fid,'        <link href="styles.css" rel="stylesheet" type="text/css" />\n');
%fprintf(fid,'        <script type="text/javascript" src="upclick-min.js"></script>\n');
%fprintf(fid,'        <script type="text/javascript" src="plotpathway.js"></script>\n');


%.........................
% WRITE CSS
%.........................

fprintf(fid,'<style>\n');

fprintf(fid,'svg{\n');
fprintf(fid,'  background: #EEE;\n');
fprintf(fid,'  margin: 0 auto;\n');
fprintf(fid,'}\n');


fprintf(fid,'.node.fixed {\n');
fprintf(fid,'  fill: #000;\n');
fprintf(fid,'}\n');

fprintf(fid,'.substrate {\n');
fprintf(fid,'  fill: none;\n');
fprintf(fid,'  stroke: #666;\n');
fprintf(fid,'  stroke-width: 2px;\n');
fprintf(fid,'}\n');

fprintf(fid,'.product {\n');
fprintf(fid,'  fill: none;\n');
fprintf(fid,'  stroke: #999;\n');
fprintf(fid,'  stroke-width: 2px;\n');
fprintf(fid,'  stroke-dasharray: 3,3;\n');
fprintf(fid,'}\n');


fprintf(fid,'.available {\n');
fprintf(fid,'  fill: #00C618;\n');
fprintf(fid,'  stroke: #008110;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');

fprintf(fid,'.source {\n');
fprintf(fid,'  fill: #FF8673;\n');
fprintf(fid,'  stroke: #FF2300;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');

fprintf(fid,'.target {\n');
fprintf(fid,'  fill: #FFF273;\n');
fprintf(fid,'  stroke: #FFCA00;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');

fprintf(fid,'.compound {\n');
fprintf(fid,'  fill: #5DC8CD;\n');
fprintf(fid,'  stroke: #006064;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');


fprintf(fid,'.external {\n');
fprintf(fid,'  fill: #9F3ED5;\n');
fprintf(fid,'  stroke: #48036F;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');

fprintf(fid,'.reaction {\n');
fprintf(fid,'  fill: #1B1BB3;\n');
fprintf(fid,'  stroke: #006064;\n');
fprintf(fid,'  stroke-width: 1.5px;\n');
fprintf(fid,'}\n');


fprintf(fid,'text {\n');
fprintf(fid,'  fill: #000;\n');
fprintf(fid,'  font: 12px arial;\n');
fprintf(fid,'  pointer-events: none;\n');
fprintf(fid,'  background-color: #159;\n');
fprintf(fid,'}\n');

fprintf(fid,'</style>\n');
%..........................

fprintf(fid,'    </head>\n\n');

fprintf(fid,'    <body>\n');
    
%fprintf(fid,'    <h1> PATHWAY </h1>\n\n');
    
fprintf(fid,'    <noscript>\n');
fprintf(fid,'    Para utilizar las funcionalidades completas de este sitio es necesario tener\n');
fprintf(fid,'    JavaScript habilitado. Aquí están las <a href="http://www.enable-javascript.com/es/"\n');
fprintf(fid,'    target="_blank"> instrucciones para habilitar JavaScript en tu navegador web</a>.\n');
fprintf(fid,'    </noscript>\n\n');
    
  
fprintf(fid,'    <script type="text/javascript">\n');

%..........................................................................
% WRITE DATA IN JSON FORMAT

fprintf(fid,'json = {\n');
fprintf(fid,'	"nodes": [\n');

for ii = 1:size(grn,1)
    
    fprintf(fid,'		{\n');
    
%     text = sprintf('    			"name": "%s",\n',grn.nodes{ii}.name);
    text = sprintf('    			"name": "g%d",\n',ii);
    fprintf(fid,text);
    
%     text = sprintf('    			"label": "%s",\n',grn.nodes{ii}.label);
%     text = sprintf('    			"label": "gene %d",\n',ii);
    text = sprintf('    			"label": "%s",\n',label{ii});
    fprintf(fid,text);

    text = sprintf('    			"class": "compound"\n');
    fprintf(fid,text);

    fprintf(fid,'		},\n');
    
end
% 
% ii = ii + 1;
% fprintf(fid,'		{\n');
% text = sprintf('    			"name": "%s",\n',grn.nodes{ii}.name);
% fprintf(fid,text);
% text = sprintf('    			"label": "%s",\n',grn.nodes{ii}.label);
% fprintf(fid,text);
% text = sprintf('    			"class": "%s"\n',grn.nodes{ii}.class);
% fprintf(fid,text);
% fprintf(fid,'		}\n');

fprintf(fid,'	],\n');

%......................

fprintf(fid,'	"links": [\n');

for ii = 1:size(grn,1)
    for jj = 1:size(grn,2)
        if grn(ii,jj) > 0
    
    fprintf(fid,'		{\n');
    
%     text = sprintf('    			"source": "%s",\n',grn.links{ii}.source);
    text = sprintf('    			"source": "g%d",\n',ii);
    fprintf(fid,text);
    
%     text = sprintf('    			"target": "%s",\n',grn.links{ii}.target);
    text = sprintf('    			"target": "g%d",\n',jj);
    fprintf(fid,text);

%     text = sprintf('    			"class": "%s"\n',grn.links{ii}.class);
    text = sprintf('    			"class": "substrate"\n');
    fprintf(fid,text);

    fprintf(fid,'		},\n');
        end
    end
end

% ii = ii + 1;
% fprintf(fid,'		{\n');
% text = sprintf('    			"source": "%s",\n',grn.links{ii}.source);
% fprintf(fid,text);
% text = sprintf('    			"target": "%s",\n',grn.links{ii}.target);
% fprintf(fid,text);
% text = sprintf('    			"class": "%s"\n',grn.links{ii}.class);
% fprintf(fid,text);
% fprintf(fid,'		}\n');

fprintf(fid,'	],\n');


text = sprintf('	"Nnodes": %d,\n',size(grn,1));
fprintf(fid,text);
text = sprintf('	"Nlinks": %d\n',size(find(grn>0),1));
fprintf(fid,text);

fprintf(fid,'}\n');



%..........................................................................

%--------------------------
fprintf(fid,'var w = window,\n');
fprintf(fid,'    d = document,\n');
fprintf(fid,'    e = d.documentElement,\n');
fprintf(fid,'    g = d.getElementsByTagName(''body'')[0],\n');
fprintf(fid,'    x = w.innerWidth || e.clientWidth || g.clientWidth,\n');
% fprintf(fid,'    x = w.innerWidth,\n');
fprintf(fid,'    y = w.innerHeight|| e.clientHeight|| g.clientHeight;\n');
%     fprintf(fid,'    y = w.innerHeight;\n');

    fprintf(fid,'var width = 0.99*x;\n');
fprintf(fid,'var height = 0.96*y;\n');
% fprintf(fid,'var margin = {top: 20, right: 20, bottom: 30, left: 40};\n');
% fprintf(fid,'var width = 0.8*x;\n');
% fprintf(fid,'var height = 0.8*y;\n');

    
fprintf(fid,'d3.select("#layout").remove();\n\n');
    
fprintf(fid,'var svg = d3.select("body").append("svg")\n');
fprintf(fid,'		.attr("id","layout")\n');
fprintf(fid,'		.attr("display","block")\n');
fprintf(fid,'		.attr("margin","auto")\n');
fprintf(fid,'		.attr("width", width)\n');
fprintf(fid,'		.attr("height", height);\n');

fprintf(fid,'var force = d3.layout.force()\n');
fprintf(fid,'			 .gravity(.005)\n');
fprintf(fid,'			 .distance(50)\n');
fprintf(fid,'			 .charge(-200)\n');
fprintf(fid,'			 .size([width, height]);\n');
    
			 
			 
fprintf(fid,'    function dragstart(d) {\n');
fprintf(fid,'			    d.fixed = true;\n');
fprintf(fid,'			    d3.select(this).classed("fixed", true);\n');
fprintf(fid,'			  }\n');
				    
				    
				    
fprintf(fid,'		function findById(source, name)\n');
fprintf(fid,'		{\n');
fprintf(fid,'		    for (var ii = 0; ii < source.length; ii++)\n');
fprintf(fid,'		    {\n');
fprintf(fid,'			if (source[ii].name === name)\n');
fprintf(fid,'			{\n');
fprintf(fid,'			    return ii;\n');
fprintf(fid,'			}\n');
fprintf(fid,'		    }\n');
fprintf(fid,'		}\n');
		
		
fprintf(fid,'		// build the arrow.\n');
fprintf(fid,'		var marker = svg.append("defs").selectAll("marker")\n');
fprintf(fid,'				.data(["substrate","product"])\n');
fprintf(fid,'				.enter()\n');
fprintf(fid,'				.append("marker")\n');
fprintf(fid,'				.attr("id", String)\n');
fprintf(fid,'				.attr("viewBox", "0 -5 10 10")\n');
% fprintf(fid,'				.attr("viewBox", "0 0 0 0")\n');
fprintf(fid,'				.attr("refX", function(d){ if(d == "substrate"){ return 24; } else{ return 19; }})\n');
fprintf(fid,'				.attr("refY", 0)\n');
fprintf(fid,'				.attr("markerWidth", 6)\n');
fprintf(fid,'				.attr("markerHeight", 6)\n');
fprintf(fid,'				.attr("orient", "auto")\n');
fprintf(fid,'				.append("path")\n');
fprintf(fid,'				.attr("d", "M0,-5L10,0L0,5");\n');
		
%text = sprintf('            d3.json(%s.json, function(error, json) {',name);
%fprintf(fid, text);
		
fprintf(fid,'		// REPLACE NAMES by IDs\n');
fprintf(fid,'		for (var ii = 0; ii < json.links.length; ii++)\n');
fprintf(fid,'		{\n');
fprintf(fid,'		    json.links[ii].source = findById(json.nodes,json.links[ii].source);\n');
fprintf(fid,'		    json.links[ii].target = findById(json.nodes,json.links[ii].target);\n');
fprintf(fid,'		}\n');
		
		
		
fprintf(fid,'		force.nodes(json.nodes)\n');
fprintf(fid,'		     .links(json.links)\n');
fprintf(fid,'		     .start();\n');
		     
		     
fprintf(fid,'		var link = svg.selectAll(".link")\n');
fprintf(fid,'			      .data(json.links)\n');
fprintf(fid,'			      .enter()\n');
fprintf(fid,'			      .append("line")\n');
fprintf(fid,'			      .attr("class", function(d){return d.class;})\n');
fprintf(fid,'			      .attr("marker-end", function(d){return "url(#" + d.class + ")";});\n');
			      
			      
		
fprintf(fid,'		var node = svg.selectAll(".node")\n');
fprintf(fid,'			      .data(json.nodes)\n');
fprintf(fid,'			      .enter()\n');
fprintf(fid,'			      .append("g")\n');
fprintf(fid,'			      .call(force.drag().on("dragstart", dragstart));\n');
			      
			      
			      
fprintf(fid,'		node.append("circle")\n');
fprintf(fid,'		    .attr("r", 10)\n');
fprintf(fid,'		    .attr("class", function(d){return d.class;});\n');
		
		
		
fprintf(fid,'		svg.selectAll("circle").attr("r",function(d){if (d.class == "reaction"){return 15;}else{return 10;}});\n');
		
		
		
fprintf(fid,'		node.append("text")\n');
fprintf(fid,'		    .attr("dx", 15)\n');
fprintf(fid,'		    .attr("dy", ".45em")\n');
fprintf(fid,'		    .text(function(d) { return d.label });\n');
		
		
		
fprintf(fid,'		force.on("tick", function() {\n');
fprintf(fid,'					      link.attr("x1", function(d) { return d.source.x; })\n');
fprintf(fid,'						  .attr("y1", function(d) { return d.source.y; })\n');
fprintf(fid,'						  .attr("x2", function(d) { return d.target.x; })\n');
fprintf(fid,'						  .attr("y2", function(d) { return d.target.y; });\n');
					      
fprintf(fid,'					      node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });\n');
fprintf(fid,'					    });\n');
	    
	    
	    
fprintf(fid,'		resize();\n');
fprintf(fid,'		d3.select(window).on("resize", resize);\n');
		
		
		
fprintf(fid,'		function resize() {\n');
fprintf(fid,'				    //width = window.innerWidth, height = window.innerHeight;\n');
fprintf(fid,'				    svg.attr("width", width).attr("height", height);\n');
fprintf(fid,'				    force.size([width, height]).resume();\n');
fprintf(fid,'				  }\n');
		
		
		
fprintf(fid,'		node.on("dblclick", function(d) {\n');
fprintf(fid,'						  d3.select(this).classed("fixed", d.fixed = false);\n');
fprintf(fid,'						});\n');
		
		
		
fprintf(fid,'		node.on("click", function(d) {\n');
fprintf(fid,'      // 				        d3.select(this).select("circle")\n');
fprintf(fid,'      // 					  .attr(''fill-opacity'', 0.8);\n');
fprintf(fid,'      // 				        d3.select(this).select("circle")\n');
fprintf(fid,'      // 				          .classed("fixed", true);\n');
fprintf(fid,'					});\n');
		
		
		
		
fprintf(fid,'		node.on("mouseover", function(d) {\n');
fprintf(fid,'						    d3.select(this).select("circle")\n');
fprintf(fid,'						      .transition()\n');
fprintf(fid,'						      .duration(250)\n');
fprintf(fid,'						      .attr("r", function(h) {if (h.class == "reaction"){return 20;}else{return 15;}})\n');
fprintf(fid,'						    //.attr("r", function() {return circ.attr("r") * 1.5;})\n');
fprintf(fid,'						      .style("stroke-width", "3.5px");\n');
						        
fprintf(fid,'						    d3.select(this).select("text")\n');
fprintf(fid,'						      .transition()\n');
fprintf(fid,'						      .duration(250)\n');
fprintf(fid,'						      .attr("class", function(d){return d.class;})\n');
fprintf(fid,'						      .attr("dx", 20);\n');
fprintf(fid,'						 });\n');
						 
						 
						 
fprintf(fid,'		node.on("mouseout", function(d) {\n');
fprintf(fid,'						  d3.select(this).select("circle")\n');
fprintf(fid,'						    .transition()\n');
fprintf(fid,'						    .duration(250)\n');
fprintf(fid,'						    .attr("r", function(h) { if (h.class == "reaction"){return 15;}else{return 10;}})\n');
fprintf(fid,'						    //.attr("r", function() {return circ.attr("r") / 1.5;})\n');
fprintf(fid,'						    .style("stroke-width", "1.5px");\n');
						  
fprintf(fid,'						  d3.select(this).select("text")\n');
fprintf(fid,'						    .transition()\n');
fprintf(fid,'						    .duration(250)\n');
fprintf(fid,'						    .attr("class", "text")\n');
fprintf(fid,'						    .attr("dx", 15);\n');
fprintf(fid,'						 });\n');

%----------------------



fprintf(fid,'    </script>\n\n');

fprintf(fid,'</body>\n');
fprintf(fid,'</html>\n');
%==========================================================================

fclose(fid);



end % FUNCTION