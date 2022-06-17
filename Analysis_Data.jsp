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

<script>
	function Open_() {
		$(".DS_DIV").slideToggle("slow");
	}

	function Focuse(choose) {
		switch (choose) {
		case 0:
			document.getElementById('SD_DIV').focus();
			break;
		case 1:
			document.getElementById('MW_DIV').focus();
			break;
		case 2:
			document.getElementById('CH_DIV').focus();
			break;
		case 3:
			document.getElementById('logP_DIV').focus();
			break;
		}
	}
</script>

</head>
<body>
	<div class="Center_DIV">
		<a href="Analysis_Result.jsp" title="Virtual Screening results.">Results</a>
		<a href="Analysis_RD.jsp"
			title="Virtual Screening results distribution.">Results
			distribution</a>
	</div>
	<hr>
	<div style="float: left; width: 35%;">
		<h1 style="color: #642100">Introduction</h1>
		<br>
		<p>
			<font size="4">Here are the cutting ratios and the number of
				data sets when training the model, and in order to better understand
				the collected data, we check the molecular 2D structures of the
				compounds. There are three types of computed properties selected in
				this study:</font>
		</p>
		<p>
			<font size="4">1. Molecular weight: molecular size.</font>
		</p>
		<p>
			<font size="4">2. Charge: with positive and negative charges.</font>
		</p>
		<p>
			<font size="4">3. logP: distinguish between oily substances
				and water.</font>
		</p>
		<p>
			<font size="4">Using the box in the distribution center of the
				violin diagram, it is found that the distribution centers of the
				properties of the two datasets are in similar positions, so it is
				known that they have similar molecular properties.</font>
		</p>
		<br />
		<h1 style="color: #642100">Type</h1>
		<div class="Menu_DIV">
			<br /> <a onclick="Focuse(0)" style="font-size: 20px;">Split
				dataset</a><br /> <br /> <a onclick="Open_()"
				style="font-size: 20px; text-decoration: underline;">Properties
				distribution ▼</a>
			<div class="DS_DIV" style="display: none;">
				<br /> <a onclick="Focuse(1)" style="font-size: 20px;">Molecular
					weight</a><br /> <br /> <a onclick="Focuse(2)"
					style="font-size: 20px;">Charge</a><br /> <br /> <a
					onclick="Focuse(3)" style="font-size: 20px;">logP</a><br /> <br />
			</div>
		</div>
	</div>
	<div style="float: right; width: 60%;">
		<div tabindex="-1" id="SD_DIV">
			<h3 style="color: #642100">Split dataset</h3>
			<br /> <img src="Image/DataSet_Cut.png"
				style="width: 750px; height: 200px;">
		</div>
		<hr>
		<div>
			<h3 style="color: #642100">Molecular properties distribution</h3>
			<br />
			<div tabindex="-1" id="MW_DIV">
				<h4 style="color: #003D79">Molecular weight</h4>
				<img src="Image/An_MW.png" style="width: 300px; height: 250px;">
			</div>
			<br /> <br />
			<div tabindex="-1" id="CH_DIV">
				<h4 style="color: #003D79">Charge</h4>
				<img src="Image/An_Charg.png" style="width: 300px; height: 250px;">
			</div>
			<br /> <br />
			<div tabindex="-1" id="logP_DIV">
				<h4 style="color: #003D79">logP</h4>
				<img src="Image/An_logP.png" style="width: 300px; height: 250px;">
			</div>
		</div>
	</div>
</body>
</html>