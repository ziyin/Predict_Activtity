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
	<div style="float: left; width: 50%">
		<h1>INTRODUCTION</h1>
		<p>
			<font size="4">In the process of ethanol metabolism,
				acetaldehyde dehydrogenase (ALDH) is an aldehyde deoxygenase,
				responsible for catalyzing the formation of harmless acetic acid
				from acetaldehyde, and ALDH1A1 in the ALDH family is widely
				expressed in various organs and tissues of the human body, such as
				brain, liver, kidney et al, whose role is to oxidize acetaldehyde to
				retinoic acid, forming a transcriptional regulator essential for
				normal cell growth and differentiation.In recent years, a large
				number of studies have shown that the activity of ALDH1A1 is related
				to diseases such as cancer, obesity and Alzheimer's disease.
				Therefore, the development of drugs targeting ALDH1A1 has market
				potential.</font>
		</p>
		<p>
			<font size="4">Drug development is a time-consuming research,
				and in order to ensure the safety of drugs, all clinical trials have
				no possibility of substitution. Therefore, shortening the time for
				early drug discovery and improving the efficiency of lead compound
				screening can accelerate the overall drug development. Predicting
				molecular compounds that are active against a target is a critical
				step in drug discovery, and the traditional approach is to scan
				large compound sample libraries to test for biological activity
				against the target, but it is a time-consuming and expensive
				process, so researchers began Using virtual screening technology,
				computer simulations are used to screen out compounds that are
				active against the target for subsequent experiments, thereby
				reducing the required development cost and time.</font>
		</p>
		<p>
			<font size="4">We used a graph convolutional neural network to
				construct a classification model that can predict the active and
				inactive compounds of ALDHA1. When developing drugs targeting
				ALDH1A1 in the future, we can screen out the active compounds to
				facilitate the discovery of lead compounds. , to achieve the goal of
				shortening the time of drug development, improving the probability
				of research and development and reducing the cost of research and
				development.</font>
		</p>
		<p>
			<font size="4">And constructed this website to let more people
				know about the results of this research. This website consists of
				the following three subsystems:</font>
		<p>
			<font size="4">1 : Browsing subsystem: for users to browse the
				public information of the website, including: website introduction,
				latest news and contact information.</font>
		<p>
			<font size="4">2 :Analysis subsystem: for users to understand
				the data sets and data used by the model The results of virtual
				screening of commercially available compounds.</font>
		<p>
			<font size="4">3 : Prediction subsystem: for users to predict
				the active compounds of ALDH1A1 online, making it easy to discover
				active compounds during drug development.</font>
		</p>
	</div>
	<div style="float: right; width: 35%; padding-top: 10%">
		<span id="ALDH1A1_Structure"></span>
	</div>
</body>
</html>