<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page language="java" import="java.math.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>ALDH1A1_Activity</title>
<jsp:include page="Head_.jsp" />
<link rel="stylesheet" type="text/css" href="Style/Unite.css"
	media="screen" />
<script src="https://d3js.org/d3.v4.min.js"></script>

<style>
.Menu_Choose {
	border-width: 3px;
	border-style: solid;
	border-color: #D26900;
	padding: 5px;
}
</style>

<script>
	function Load_Bar() {
		var Count_ = [ 146991, 15463, 9804, 7668, 6542, 6180, 6385, 7212, 9628,
				33582 ];
		var count = 0;
		var data = new Array();
		for (var num = 0; num < 0.9; num += 0.1) {

			var dbData = new Array();
			dbData["No"] = count;
			dbData["From"] = num.toFixed(1)
			dbData["To"] = (num + 0.1).toFixed(1)
			dbData["count"] = Count_[count];
			data.push(dbData);
			count += 1;
		}

		var padding = {
			top : 20,
			right : 20,
			bottom : 50,
			left : 40
		};
		var width = 910, height = 400;

		var svg = d3.select("#Bar").append("svg").attr('width',
				width + padding.left + padding.right).attr('height',
				height + padding.top + padding.bottom);

		svg.selectAll("rect").data(data).enter().append("rect").attr("y",
				function(d) {
					return height - (d["count"] / 400);
				}).attr("x", function(d) {
			return d["No"] * 60;
		}).attr("height", function(d) {
			return (d["count"] / 400) - 5;
		}).attr("width", 30).attr("fill", "#5F4B8B").on("click", function(d) {
			document.total_inform.Act1.value = d["From"];
			document.total_inform.Act2.value = d["To"];
			document.total_inform.submit();
		});

		var texts = svg.selectAll("text").data(data).enter();

		texts.append("text").text(function(d) {
			return d["From"] + "~" + d["To"];
		}).attr("x", function(d) {
			return (d["No"] * 60) + 10;
		}).attr("y", height).attr("font-family", "sans-serif").attr(
				"font-size", "12px").attr("fill", "black").attr("style",
				"writing-mode: tb; glyph-orientation-vertical: 0");

		texts.append("text").text(function(d) {
			return d["count"];
		}).attr("x", function(d) {
			var resi = d["count"] / 400;
			if (resi > 10)
				return d["No"] * 60;
			else if (resi > 1)
				return (d["No"] * 60) + 2;
			else
				return (d["No"] * 60) + 7;

		}).attr("y", function(d) {
			return height - (d["count"] / 400) - 2;
		}).attr("font-family", "sans-serif").attr("font-size", "12px").attr(
				"fill", "#444444").on("click", function(d) {
			document.total_inform.Act1.value = d["From"];
			document.total_inform.Act2.value = d["To"];
			document.total_inform.submit();
		});
		;
	}
</script>

</head>
<body onload="Load_Bar()">
	<form id="total_inform" name="total_inform"
		action="Analysis_Result.jsp" method="POST">
		<input type='hidden' name='showop' id='showop' value=""> <input
			type='hidden' name='shownum' id='shownum' value="10"> <input
			type='hidden' name='now_page' id='now_page' value='1'> <input
			type='hidden' name='ordsort' id='ordsort' value=""> <input
			type='hidden' name='Act1' id='Act1' value=""> <input
			type='hidden' name='Act2' id='Act2' value="">
	</form>
	<div class="Center_DIV">
		<a href="Analysis_Result.jsp" title="Virtual Screening results." class="Menu_Choose">VS results</a>
		<font class="Menu_Choose" style="color: #0072E3; text-decoration: none; font-size: 20px; font-weight: bold; padding: 5px 10px;">Results distribution</font>
		<a href="Analysis_Data.jsp" title="Data set analysis for model training." class="Menu_Choose">DataSet Analysis</a> 
	</div>
	<hr>
	<div style="float: left; width: 35%;">
		<h1 style="color: #642100">Introduction</h1>
		<br>
		<p>
			<font size="4">By directly observing the distribution of
				predicted probability of active compounds through the numerical
				interval, it can be found that most of them are less than 0.1, and
				only about 25% are found to be predicted to be active with a
				probability greater than 0.5, and most of the compounds are still
				predicted to be inactive with a higher probability.</font>
		</p>
	</div>
	<div style="float: right; width: 60%;">
		<div id="Bar"></div>
	</div>
</body>
</html>