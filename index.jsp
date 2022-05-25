<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>ALDH1A1_Activity</title>
<jsp:include page="Head_.jsp" />
<link rel="stylesheet" type="text/css" href="Style/Unite.css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="Style/jquery-ui.css">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script src="https://d3js.org/d3.v3.min.js"></script>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>


<script src="jsmol/JSmol.min.js"></script>
<script src="jsmol/js/Jmol2.js"></script>
<script>jmolInitialize("jsmol");</script>
<script>
function Load_Structure()
{
	var script = 'load "4wj9.pdb";spin on;'
Info = {
	    spin:true,			
		j2sPath: "jsmol/j2s",
		use: "HTML5",
		readyFunction: null,
	        script
	        }
	$("#ALDH1A1_Structure").html(Jmol.getAppletHtml("jmolApplet0",Info))	
}
</script>
</head>
<body onload="Load_Structure()">
<div style="float: left; width:50%">
	<h1>INTRODUCTION</h1>
			<p>
				<font size="4">Protein is considered to be in different
					stages during the folding process and the structure conformational
					change is from an unfolding state to a folded state (native state)
					of the lowest energy of configuration. During the state transition,
					there is a high-energy transient may occur, called “transition
					state”. The study of transition state can improve the understanding
					of protein folding interactions.</font>
			</p>
			<p>
				<font size="4">Φ-value analysis is one of the most commonly
					used method to probe the transition state structures in protein
					folding. The Φ-value is calculated by the difference in energy
					between the each states of the mutant protein and the wild-type
					protein during protein folding process. This method is mainly used
					to analyze the change of the transition state energy caused by the
					mutated residue, and to evaluate the effects of the mutated residue
					in the transition state structure.</font>
			</p>
			<p>
				<font size="4">Since the Φ-value analysis requires
					biochemical experiments to obtain data, it is time consuming and
					high cost. Therefore, collating experimental data from the
					literature becomes another way, but it takes a lot of time to read
					the literature to obtain.</font>
			</p>
			<p>
				<font size="4">So we collect the literature related to
					Φ-value in the past, integrate Φ-value experimental data and use
					these data to establish a database. This database provide
					researchers efficiently get the Φ-value data to fulfill
					requirements by searching. To resolve the difficulty of
					time-consuming and high-cost by the traditional Φ-value data
					acquisition method.</font>
			</p>
</div>
<div style="float:right;width:35%;padding-top:10%">
<span id="ALDH1A1_Structure"></span>
</div>
</body>
</html>