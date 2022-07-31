<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="com.mysql.jdbc.Driver"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>ALDH1A1_Activity</title>
<jsp:include page="Head_.jsp" />

<link rel="stylesheet" type="text/css" href="Style/Unite.css"
	media="screen" />
<link rel="stylesheet" type="text/css" href="Style/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="Style/nouislider.css">
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/14.0.1/nouislider.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.2/jquery-ui.min.js"></script>
<script src="Change_Page.js"></script>

<style>
.Menu_Choose {
	border-width: 3px;
	border-style: solid;
	border-color: #D26900;
	padding: 5px;
}
</style>

<%
//Init
//DB
String driverName = "com.mysql.jdbc.Driver";
String DB_URL = "jdbc:mysql://localhost:3306/zinc250k?serverTimezone=UTC";
String Account = "root";
String Password = "root";
Connection connDB = null;
//Item
String[] ob = {"DB ID","ZINC ID","SMILES", "LogP", "QED", "SAS", "Active probability", "Inactive probability"};
String sortdataop[] = {"DB ID","ZINCID", "SMILES", "LogP", "QED", "SAS", "Active", "Inactive"};
String sortop[] = {"DB ID","ZINCID", "SMILES", "LogP", "QED", "SAS", "Active", "Inactive"};
String Condition_Sql = "", SqlCommand = "";
//Condition

String ZINCID="",SMILES = "";
String LogP1_s = "", LogP2_s = "", QED1_s = "", QED2_s = "", SAS1_s = "", SAS2_s = "", Act1_s = "", Act2_s = "",
		Inact1_s = "", Inact2_s = "";
Double LogP1 = -7.0, LogP2 = -7.0, QED1 = 0.0, QED2 = 0.0, SAS1 = 10.0, SAS2 = 10.0, Act1 = -1.0, Act2 = -1.0,
		Inact1 = -1.0, Inact2 = -1.0;

//Show condition
String[] column = {"1", "2", "3", "4", "5", "6","7"}, Sort = null;
int now_page = 1, total_page = 0, show_num = 10;
String queue = "", resi_sort = "", resi_column = "";
%>

<%
//Get Previously Data

if (request.getParameter("showop") != null) {
	if (!request.getParameter("showop").equals("")) {
		resi_column = request.getParameter("showop");
		resi_column = new String(resi_column.getBytes("iso-8859-1"), "UTF-8");
		column = resi_column.split(",");
	}
	if (request.getParameter("shownum") != null)
		show_num = Integer.valueOf(request.getParameter("shownum"));
	if (request.getParameter("now_page") != null)
		now_page = Integer.valueOf(request.getParameter("now_page"));
	if (!request.getParameter("ordsort").equals("")) {
		resi_sort = request.getParameter("ordsort");
		resi_sort = new String(resi_sort.getBytes("iso-8859-1"), "UTF-8");
		Sort = resi_sort.split(",");
	}
}
if (request.getParameter("ZINCID") != null) {
	if (!request.getParameter("ZINCID").equals("")) {
		ZINCID = request.getParameter("ZINCID");
		ZINCID = new String(ZINCID.getBytes("iso-8859-1"), "UTF-8").trim();
	}
}

if (request.getParameter("SMILES") != null) {
	if (!request.getParameter("SMILES").equals("")) {
		SMILES = request.getParameter("SMILES");
		SMILES = new String(SMILES.getBytes("iso-8859-1"), "UTF-8").trim();
	}
}

if (request.getParameter("LogP1") != null) {
	if (!request.getParameter("LogP1").equals("") && !request.getParameter("LogP2").equals("")) {
		LogP1_s = request.getParameter("LogP1");
		LogP1_s = new String(LogP1_s.getBytes("iso-8859-1"), "UTF-8");
		LogP2_s = request.getParameter("LogP2");
		LogP2_s = new String(LogP2_s.getBytes("iso-8859-1"), "UTF-8");
		LogP1 = Double.valueOf(LogP1_s).doubleValue();
		LogP2 = Double.valueOf(LogP2_s).doubleValue();
	}
}

if (request.getParameter("QED1") != null) {
	if (!request.getParameter("QED1").equals("") && !request.getParameter("QED2").equals("")) {
		QED1_s = request.getParameter("QED1");
		QED1_s = new String(QED1_s.getBytes("iso-8859-1"), "UTF-8");
		QED2_s = request.getParameter("QED2");
		QED2_s = new String(QED2_s.getBytes("iso-8859-1"), "UTF-8");
		QED1 = Double.valueOf(QED1_s).doubleValue();
		QED2 = Double.valueOf(QED2_s).doubleValue();
	}
}

if (request.getParameter("SAS1") != null) {
	if (!request.getParameter("SAS1").equals("") && !request.getParameter("SAS2").equals("")) {
		SAS1_s = request.getParameter("SAS1");
		SAS1_s = new String(SAS1_s.getBytes("iso-8859-1"), "UTF-8");
		SAS2_s = request.getParameter("SAS2");
		SAS2_s = new String(SAS2_s.getBytes("iso-8859-1"), "UTF-8");
		SAS1 = Double.valueOf(SAS1_s).doubleValue();
		SAS2 = Double.valueOf(SAS2_s).doubleValue();
	}
}

if (request.getParameter("Act1") != null) {
	if (!request.getParameter("Act1").equals("") && !request.getParameter("Act2").equals("")) {
		Act1_s = request.getParameter("Act1");
		Act1_s = new String(Act1_s.getBytes("iso-8859-1"), "UTF-8");
		Act2_s = request.getParameter("Act2");
		Act2_s = new String(Act2_s.getBytes("iso-8859-1"), "UTF-8");
		Act1 = Double.valueOf(Act1_s).doubleValue();
		Act2 = Double.valueOf(Act2_s).doubleValue();
	} else {
		Act1 = 0.0;
		Act2 = 1.0;
	}
} else {
	Act1 = 0.0;
	Act2 = 1.0;
}

if (request.getParameter("Inact1") != null) {
	if (!request.getParameter("Inact1").equals("") && !request.getParameter("Inact2").equals("")) {
		Inact1_s = request.getParameter("Inact1");
		Inact1_s = new String(Inact1_s.getBytes("iso-8859-1"), "UTF-8");
		Inact2_s = request.getParameter("Inact2");
		Inact2_s = new String(Inact2_s.getBytes("iso-8859-1"), "UTF-8");
		Inact1 = Double.valueOf(Inact1_s).doubleValue();
		Inact2 = Double.valueOf(Inact2_s).doubleValue();
	} else {
		Inact1 = 0.0;
		Inact2 = 1.0;
	}
} else {
	Inact1 = 0.0;
	Inact2 = 1.0;
}
%>

<%
//SQL COMMAND
if (!ZINCID.equals("")) {
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND predict.ZINCID LIKE '" + ZINCID + "%'";
	else
		Condition_Sql += " WHERE predict.ZINCID LIKE '" + ZINCID + "%'";
}

if (!SMILES.equals("")) {
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND predict.SMILES LIKE '" + SMILES + "%'";
	else
		Condition_Sql += " WHERE predict.SMILES LIKE '" + SMILES + "%'";
}

if (LogP1 != -7.0 && LogP2 != -7.0) {
	String phiv_sql = "";

	if (LogP1 == -7.0) {
		phiv_sql = "(predict.logP <=" + LogP2 + ")";
		LogP1 = -7.0;
	} else if (LogP2 == -7.0) {
		phiv_sql = "(predict.logP >=" + LogP1 + ")";
		LogP2 = -7.0;
	} else
		phiv_sql = " (predict.logP >=" + LogP1 + " AND predict.logP<=" + LogP2 + ")";
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND " + phiv_sql;
	else
		Condition_Sql += " WHERE " + phiv_sql;
}

if (QED1 != -0.0 && QED2 != -0.0) {
	String phiv_sql = "";

	if (QED1 == 0.0) {
		phiv_sql = "(predict.QED <=" + QED2 + ")";
		QED1 = -0.0;
	} else if (QED2 == 0.0) {
		phiv_sql = "(predict.QED >=" + QED1 + ")";
		QED2 = -0.0;
	} else
		phiv_sql = " (predict.QED >=" + QED1 + " AND predict.QED<=" + QED2 + ")";
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND " + phiv_sql;
	else
		Condition_Sql += " WHERE " + phiv_sql;
}

if (SAS1 != 10.0 && SAS2 != 10.0) {
	String phiv_sql = "";

	if (SAS1 == 10.0) {
		phiv_sql = "(predict.SAS <=" + SAS2 + ")";
		SAS1 = 10.0;
	} else if (SAS2 == 10.0) {
		phiv_sql = "(predict.SAS >=" + SAS1 + ")";
		SAS2 = 10.0;
	} else
		phiv_sql = " (predict.SAS >=" + SAS1 + " AND predict.SAS<=" + SAS2 + ")";
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND " + phiv_sql;
	else
		Condition_Sql += " WHERE " + phiv_sql;
}

if (Act1 != -1.0 && Act2 != -1.0) {
	String phiv_sql = "";

	if (Act1 == -1.0) {
		phiv_sql = "(predict.Active <=" + Act2 + ")";
		Act1 = -1.0;
	} else if (Act2 == -1.0) {
		phiv_sql = "(predict.logP >=" + Act1 + ")";
		Act2 = -1.0;
	} else
		phiv_sql = " (predict.Active >=" + Act1 + " AND predict.Active<=" + Act2 + ")";
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND " + phiv_sql;
	else
		Condition_Sql += " WHERE " + phiv_sql;
}

if (Inact1 != -1.0 && Inact2 != -1.0) {
	String phiv_sql = "";

	if (Inact1 == -1.0) {
		phiv_sql = "(predict.Inactive <=" + Inact2 + ")";
		Inact1 = -1.0;
	} else if (Inact2 == -1.0) {
		phiv_sql = "(predict.Inactive >=" + Inact1 + ")";
		Inact2 = -1.0;
	} else
		phiv_sql = " (predict.Inactive >=" + Inact1 + " AND predict.Inactive<=" + Inact2 + ")";
	if (!Condition_Sql.equals(""))
		Condition_Sql += " AND " + phiv_sql;
	else
		Condition_Sql += " WHERE " + phiv_sql;
}

if (Sort != null) {
	switch (Integer.parseInt(Sort[1])) {
		case 0 :
	queue = "";
	break;
		case 1 :
	queue = " ORDER BY predict." + Sort[0] + " ASC";
	break;
		case 2 :
	queue = " ORDER BY predict." + Sort[0] + " DESC";
	break;
	}
}
if (!Condition_Sql.equals("")) {
	SqlCommand = "SELECT * FROM predict" + Condition_Sql + queue;
} else {
	SqlCommand = "SELECT * FROM predict" + queue;
}
%>
<script>
	function Advanced_search() {
		$(".Adv_DIV").slideToggle("slow");
	}

	function Adv_search() {
		Adv_tran();
		document.total_inform.submit()
	}
	
	function Search_()
	{
		keyword = document.getElementById("KeyWord");
		if (keyword.value == "") {
			alert("Please enter keyword");
		} else {
			$("#advanced form input").each(function() {
				$(this).val('');
			});
			$("#Persious_inform form input").each(function() {
				$(this).val('');
			});
			
			choose= document.getElementById("SearchFrom").value;
			switch (choose) {
			  case 'SMILES':
				  document.total_inform.SMILES.value = keyword.value;
			    break;
			  case 'ZINC':
				  document.total_inform.ZINCID.value = keyword.value;
			    break;
			  break;
			}
			
			
			document.total_inform.showop.value = "1,2,3,4,5,6,7";
			document.total_inform.shownum.value = "10";
			document.total_inform.now_page.value = "1";
			document.total_inform.submit()
			keyword.value="";
		}
	}
</script>

<script>
function init_value()
{
	document.total_inform.now_page.value=1;
	var resi1,resi2;
		
	resi1="<%=LogP1%>";
	resi2="<%=LogP2%>";
	if(resi1==-7.0 || resi2==-7.0)
	{
		document.Advanced.LogP1.value="";
		document.Advanced.LogP2.value="";
	}
	else
	{
		document.Advanced.LogP1.value=resi1;
		document.Advanced.LogP2.value=resi2;
	}
	
	resi1="<%=QED1%>";
	resi2="<%=QED2%>";
	if(resi1==0.0 || resi2==0.0)
	{
		document.Advanced.QED1.value="";
		document.Advanced.QED2.value="";
	}
	else
	{
		document.Advanced.QED1.value=resi1;
		document.Advanced.QED2.value=resi2;
	}
	
	resi1="<%=SAS1%>";
	resi2="<%=SAS2%>";
	if(resi1==10.0 || resi2==10.0)
	{
		document.Advanced.SAS1.value="";
		document.Advanced.SAS2.value="";
	}
	else
	{
		document.Advanced.SAS1.value=resi1;
		document.Advanced.SAS2.value=resi2;
	}
	
	resi1="<%=Act1%>";
	resi2="<%=Act2%>";
	if(resi1==-1.0 || resi2==-1.0)
	{
		document.Advanced.Act1.value="";
		document.Advanced.Act2.value="";
	}
	else
	{
		document.Advanced.Act1.value=resi1;
		document.Advanced.Act2.value=resi2;
	}
	
	resi1="<%=Inact1%>";
	resi2="<%=Inact2%>";
	if(resi1==-1.0 || resi2==-1.0)
	{
		document.Advanced.Inact1.value="";
		document.Advanced.Inact2.value="";
	}
	else
	{
		document.Advanced.Inact1.value=resi1;
		document.Advanced.Inact2.value=resi2;
	}
}
</script>

<script>
function load_condition()
{
	document.total_inform.showop.value="<%=resi_column%>";
	document.total_inform.shownum.value="<%=show_num%>";
	document.total_inform.now_page.value="<%=now_page%>";
	document.total_inform.ordsort.value="<%=resi_sort%>";
	document.total_inform.ZINCID.value="<%=ZINCID%>";
	document.total_inform.SMILES.value="<%=SMILES%>";
	document.total_inform.LogP1.value="<%=LogP1%>";	
	document.total_inform.LogP2.value="<%=LogP2%>";
	document.total_inform.QED1.value="<%=QED1%>";
	document.total_inform.QED2.value="<%=QED2%>";
	document.total_inform.SAS1.value="<%=SAS1%>";
	document.total_inform.SAS2.value="<%=SAS2%>";
	document.total_inform.Act1.value="<%=Act1%>";
	document.total_inform.Act2.value="<%=Act2%>";
	document.total_inform.Inact1.value="<%=Inact1%>";
	document.total_inform.Inact2.value="<%=Inact2%>";

	var Slider = document.getElementById('ActPSlider');
	var obj = document.getElementById("Act_From");
	obj.value = document.total_inform.Act1.value;
	Slider.noUiSlider.set([ obj.value, null ]);
	obj = document.getElementById("Act_To");
	obj.value = document.total_inform.Act2.value;
	Slider.noUiSlider.set([ null, obj.value ]);

	var Slider_ = document.getElementById('InactPSlider');
	var obj_ = document.getElementById("Inact_From");
	obj_.value = document.total_inform.Inact1.value;
	Slider_.noUiSlider.set([ obj_.value, null ]);
	obj_ = document.getElementById("Inact_To");
	obj_.value = document.total_inform.Inact2.value;
	Slider_.noUiSlider.set([ null, obj_.value ]);

	init_value();
}

function Adv_tran() {
	document.total_inform.LogP1.value = document.Advanced.LogP1.value;
	document.total_inform.LogP2.value = document.Advanced.LogP2.value;
	document.total_inform.QED1.value = document.Advanced.QED1.value;
	document.total_inform.QED2.value = document.Advanced.QED2.value;
	document.total_inform.SAS1.value = document.Advanced.SAS1.value;
	document.total_inform.SAS2.value = document.Advanced.SAS2.value;
	document.total_inform.Act1.value = document.Advanced.Act1.value;
	document.total_inform.Act2.value = document.Advanced.Act2.value;
	document.total_inform.Inact1.value = document.Advanced.Inact1.value;
	document.total_inform.Inact2.value = document.Advanced.Inact2.value;
}
</script>

<script>
	function Cancel_Condition(Item) {
	if (Item == "ZINCID")
		document.total_inform.ZINCID.value = "";
	else if (Item == "SMILES")
		document.total_inform.SMILES.value = "";
	else if (Item == "LogP") {
		document.total_inform.LogP1.value = "";
		document.total_inform.LogP2.value = "";
	} else if (Item == "QED") {
		document.total_inform.QED1.value = "";
		document.total_inform.QED2.value = "";
	}

	else if (Item == "SAS") {
		document.total_inform.SAS1.value = "";
		document.total_inform.SAS2.value = "";
	} else if (Item == "Act") {
		document.total_inform.Act1.value = "";
		document.total_inform.Act2.value = "";
	} else if (Item == "Inact") {
		document.total_inform.Inact1.value = "";
		document.total_inform.Inact2.value = "";
	}

	document.total_inform.now_page.value = 1;
	changeShowOP();
}
</script>


<script>
	function Value_Check(Input_value) {
	Input_value.value = Input_value.value.replace(/[^((\d){1}(\.){1}(\d)+)]/,
			"");
}

function Example() {
	choose = document.getElementById("SearchFrom").value;
	switch (choose) {
	case 'SMILES':
		document.getElementById("KeyWord").setAttribute("placeholder",
				"eg.C1=CC=C(C=C1)C=O");
		document.getElementById("Hint_").setAttribute("title",
		"SMILES strings can be searched from public databases,eg. ChemBL");
		break;
	case 'ZINC':
		document.getElementById("KeyWord").setAttribute("placeholder",
				"eg.ZINC39882712");
	document.getElementById("Hint_").setAttribute("title",
	"Please search for ZINC ID from the ZINC database.");
		break;
	break;
}
}
</script>

<script>
function Structure_View(SMILES_)
{
	var iframe_=document.getElementById("JMOL_Show");
	iframe_.width=document.body.clientWidth*0.265;
	iframe_.src="JSMOL_Show.jsp?SMILES_="+encodeURIComponent(SMILES_);

	$("#Div_Structure").dialog("open");
}
</script>

<script>
$(function() {
	$("#Column").click(function() {
		$("#dialog-Column").dialog("open");
		
	});
	$("#dialog-Column").dialog({
		modal : true,
		autoOpen : false,
		resizable : false,
		draggable : false,
		minHeight : 250,
		minWidth : 250,
		open : function(event, ui) {
			var display =$("#Adv_DIV").css("display");
			if($("#Adv_DIV").is(":hidden"))
			{
			$(this).parent().css({
				"top" : 280,
				"left":document.body.clientWidth*0.5
			});
			}
			else
			{
				$(this).parent().css({
					"top" : 335,
					"left":document.body.clientWidth*0.61
				});
			}
		},
		buttons : {
			"Ok" : function() {
				changeShowOP();
				$(this).dialog('close');
			},
			"Cancel" : function() {
				$(this).dialog('close');
				return false;
			}
		}
	});

	$("#Div_Structure").dialog({
		modal : true,
		autoOpen : false,
		resizable : false,
		draggable : false,
		minHeight : 400,
		minWidth : 	document.body.clientWidth*0.25,
		open : function(event, ui) {
			$(this).parent().css({
				"top" :275,
				"left" : 70
			});
		}
	});
});
</script>

</head>
<body onload="load_condition()">
	<div id="Persious_inform">
		<form id="total_inform" name="total_inform"
			action="Analysis_Result.jsp" method="POST">
			<input type='hidden' name='showop' id='showop' value=""> <input
				type='hidden' name='shownum' id='shownum' value="10"> <input
				type='hidden' name='now_page' id='now_page' value='1'> <input
				type='hidden' name='ordsort' id='ordsort' value=""> 
				<input type='hidden' name='ZINCID' id='ZINCID' value=""><input
				type='hidden' name='SMILES' id='SMILES' value=""> <input
				type='hidden' name='LogP1' id='LogP1' value=""> <input
				type='hidden' name='LogP2' id='LogP2' value=""> <input
				type='hidden' name='QED1' id='QED1' value=""> <input
				type='hidden' name='QED2' id='QED2' value=""> <input
				type='hidden' name='SAS1' id='SAS1' value=""> <input
				type='hidden' name='SAS2' id='SAS2' value=""> <input
				type='hidden' name='Act1' id='Act1' value=""> <input
				type='hidden' name='Act2' id='Act2' value=""> <input
				type='hidden' name='Inact1' id='Inact1' value=""> <input
				type='hidden' name='Inact2' id='Inact2' value="">
		</form>
	</div>
	<div class="Center_DIV">
	 <font class="Menu_Choose"
			style="color: #0072E3; text-decoration: none; font-size: 20px; font-weight: bold; padding: 5px 10px;">VS results</font> <a href="Analysis_RD.jsp"
			title="Virtual Screening results distribution." class="Menu_Choose">Results
			distribution</a>
			<a href="Analysis_Data.jsp"
			title="Data set analysis for model training." class="Menu_Choose">DataSet Analysis</a>
	</div>
	<hr>
	<div id="Search_div">
		<input type="text" id="KeyWord" placeholder="eg.ZINC39882712"
			style="border-radius: 6px; font-size: 16px" /> <select
			name="SearchFrom" ID="SearchFrom" onchange="Example()">
			<option value="ZINC">ZINC ID</option>
			<option value="SMILES">SMILES String</option>
		</select>
		<button style="border-radius: 6px; font-size: 16px"
			onclick="Search_()">Search</button>
			<img src="Image/question.png" id="Hint_" title="Please search for ZINC ID from the ZINC database.">
		<br /> <br /> <a onclick="Advanced_search()"
			style="font-size: 15px; text-decoration: underline;">Advanced</a>
		<div class="Adv_DIV" style="display: none;" id="Adv_DIV">
			<form id="Advanced" name="Advanced">
				<table>
					<tr>
						<td colspan="2"><b>Condition</b></td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td colspan="2"><b>Predicted result</b></td>
					</tr>
					<tr>
						<td><b>LogP</b></td>
						<td><input type="text" id="LogP1" name="LogP1" size=3
							onkeyup="Value_Check(this)"> to <input type="text"
							id="LogP2" name="LogP2" size=3 onkeyup="Value_Check(this)">
							(floating point number)</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><b>Active probability</b></td>
						<td><input type="text" id="Act1" name="Act1" size=3
							onkeyup="Value_Check(this)"> to <input type="text"
							id="Act2" name="Act2" size=3 onkeyup="Value_Check(this)">
							(floating point number)</td>
					</tr>

					<tr>
						<td><b>QED</b></td>
						<td><input type="text" id="QED1" name="QED1" size=3
							onkeyup="Value_Check(this)"> to <input type="text"
							id="QED2" name="QED2" size=3 onkeyup="Value_Check(this)">
							(floating point number)</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><b>Inactive probability</b></td>
						<td><input type="text" id=Inact1 " name="Inact1" size=3
							onkeyup="Value_Check(this)"> to <input type="text"
							id="Inact2" name="Inact2" size=3 onkeyup="Value_Check(this)">
							(floating point number)</td>
					</tr>

					<tr>
						<td><b>SAS</b></td>
						<td><input type="text" id="SAS1" name="SAS1" size=3
							onkeyup="Value_Check(this)"> to <input type="text"
							id="SAS2" name="SAS2" size=3 onkeyup="Value_Check(this)">
							(floating point number)</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</table>
			</form>
			<button style="border-radius: 6px; font-size: 22px; margin-left: 50%"
				onclick="Adv_search()">
				<i class="fa fa-search"></i>
		</div>
	</div>
	<div class="Scrrenline_DIV">
		<div id="TimeDiv">
			<hr>
			<p>
				<font size="4">Active probability :</font>
			</p>
			<div id="ActPSlider"
				class="noUi-target noUi-ltr noUi-horizontal noUi-txt-dir-ltr"
				style="width: 95%;"></div>
			<br /> <br />
			<center>
				<input type="number" id="Act_From" style="width: 55px;" max="0.9"
					min="0.0"> ~ <input type="number" id="Act_To"
					style="width: 55px;" max="1.0" min="0.1">
			</center>
			<script>
				var Slider = document.getElementById('ActPSlider');

		var Star_ = document.getElementById("Act_From").value;
		var End_ = document.getElementById("Act_To").value;

		noUiSlider.create(Slider, {
			start : [ Star_, End_ ],
			connect : true,
			range : {
				'min' : 0.0,
				'max' : 1.0
			},
			pips : {
				mode : 'positions',
				values : [ 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,
						1.0 ],
				density : 5,
				stepped : true
			}
		});
			</script>
			<script>
				var From_ = document.getElementById("Act_From");
		var To_ = document.getElementById("Act_To");
		Slider.noUiSlider.on('update', function(values, handle) {
			var value = parseFloat(values[handle]);
			if (handle) {
				To_.value = value;

			} else {
				From_.value = value;
			}
		});

		Slider.noUiSlider.on('end', function(values, handle) {
			changeAct(document.getElementById("Act_From").value, document
					.getElementById("Act_To").value);
		});
		From_.addEventListener('change', function() {
			Slider.noUiSlider.set([ this.value, null ]);
			changeAct(document.getElementById("Act_From").value, document
					.getElementById("Act_To").value);
		});

		To_.addEventListener('change', function() {
			Slider.noUiSlider.set([ null, this.value ]);
			changeAct(document.getElementById("Act_From").value, document
					.getElementById("Act_To").value);
		});
			</script>

			<br /> <br />

			<p>
				<font size="4">Inactive probability :</font>
			</p>
			<div id="InactPSlider"
				class="noUi-target noUi-ltr noUi-horizontal noUi-txt-dir-ltr"
				style="width: 95%;"></div>
			<center>
				<input type="number" id="Inact_From" style="width: 55px;" max="0.9"
					min="0.0"> ~ <input type="number" id="Inact_To"
					style="width: 55px;" max="1.0" min="0.1">
			</center>
			<script>
				var Slider_ = document.getElementById('InactPSlider');

		var Star_I = document.getElementById("Inact_From").value;
		var End_I = document.getElementById("Inact_To").value;

		noUiSlider.create(Slider_, {
			start : [ Star_I, End_I ],
			connect : true,
			range : {
				'min' : 0.0,
				'max' : 1.0
			},
			pips : {
				mode : 'positions',
				values : [ 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,
						1.0 ],
				density : 5,
				stepped : true
			}
		});
			</script>
			<script>
				var From_I = document.getElementById("Inact_From");
		var To_I = document.getElementById("Inact_To");
		Slider_.noUiSlider.on('update', function(values, handle) {
			var value = parseFloat(values[handle]);
			if (handle) {
				To_I.value = value;

			} else {
				From_I.value = value;
			}
		});

		Slider_.noUiSlider.on('end', function(values, handle) {
			changeInact(document.getElementById("Inact_From").value, document
					.getElementById("Inact_To").value);
		});
		From_I.addEventListener('change', function() {
			Slider_.noUiSlider.set([ this.value, null ]);
			changeInact(document.getElementById("Inact_From").value, document
					.getElementById("Inact_To").value);
		});

		To_I.addEventListener('change', function() {
			Slider_.noUiSlider.set([ null, this.value ]);
			changeInact(document.getElementById("Inact_From").value, document
					.getElementById("Inact_To").value);
		});
			</script>

		</div>
	</div>
	<div class="Result_DIV">
		<div id="Div_Structure" style="display: none" title="Structure">
			<iFrame src="" width="430" height="400" id="JMOL_Show"></iFrame>
		</div>
		<%
		connDB = null;
		try {
			Class.forName(driverName).newInstance();
			connDB = DriverManager.getConnection(DB_URL, Account, Password);
			Statement cmd = connDB.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet result;

			result = cmd.executeQuery(SqlCommand);

			int total = 0;
			if (result.next()) {
				result.last();
				total_page = result.getRow();
				total = total_page;
				if (total_page % show_num > 0)
			total_page = (total_page / show_num) + 1;
				else
			total_page = total_page / show_num;
			}
			if (total > 0) {
				out.println("<br/><p> <font size='4'>Result:</font></p>");

				boolean have = false;
				if(ZINCID != "") {
					out.println("<a herf='#' onclick='Cancel_Condition(\"ZINCID\")'>(X)【ZINC ID：" + ZINCID + "】</a>　");
					have = true;
						}
				else if (SMILES != "") {
			out.println("<a herf='#' onclick='Cancel_Condition(\"SMILES\")'>(X)【SMILES String：" + SMILES + "】</a>　");
			have = true;
				}
				if (have) {
			out.println("<br/><br/>");
				}
				have = false;
				if (LogP1 != -7.0 && LogP2 != -7.0) {
			out.println(
					"<a herf='#' onclick='Cancel_Condition(\"LogP\")'>(X)【 LogP：" + LogP1 + " ~ " + LogP2 + "】</a>　");
			have = true;
				}
				if (QED1 != 0.0 && QED2 != 0.0) {
			out.println("<a herf='#' onclick='Cancel_Condition(\"QED\")'>(X)【 QED：" + QED1 + " ~ " + QED2 + "】</a>　");
			have = true;
				}
				if (SAS1 != 10.0 && SAS2 != 10.0) {
			out.println("<a herf='#' onclick='Cancel_Condition(\"SAS\")'>(X)【 SAS：" + SAS1 + " ~ " + SAS2 + "】</a>　");
			have = true;
				}
				if (have) {
			out.println("<br/><br/>");
				}
				have = false;
				if (Act1 != 0.0 || Act2 != 1.0) {
			out.println("<a herf='#' onclick='Cancel_Condition(\"Act\")'>(X)【 Active probability：" + Act1 + " ~ " + Act2
					+ "】</a>　");
			have = true;
				}
				if (Inact1 != 0.0 || Inact2 != 1.0) {
			out.println("<a herf='#' onclick='Cancel_Condition(\"Inact\")'>(X)【 Inactive probability：" + Inact1 + " ~ "
					+ Inact2 + "】</a>　");
			have = true;
				}
				if (have) {
			out.println("<br/><br/>");
				}
				result.absolute((now_page - 1) * show_num);
				out.println("<a href='javascript:changeShowPage(1);'>First page</a>&nbsp;&nbsp;&nbsp");
				if (now_page != 1)
			out.println(
					"<a href='javascript:changeShowPage(" + (now_page - 1) + ");'>Previous page</a>&nbsp;&nbsp;&nbsp");
				out.println(now_page + "/" + total_page);
				out.println("&nbsp;&nbsp;&nbsp");
				if (total_page != now_page)
			out.println("<a href='javascript:changeShowPage(" + (now_page + 1) + ");'>Next page</a>&nbsp;&nbsp;&nbsp");
				out.println("<a href='javascript:changeShowPage(" + total_page + ");'>Last page</a>&nbsp;&nbsp;&nbsp");
		%>
		Number: <select name='Pagenum'
			onChange="javascript:changePageNum(this.options[this.selectedIndex].value);">
			<%
			int show_option[] = { 5, 10, 15 };
			for (int i = 0; i < show_option.length; i++)
				if (show_option[i] == show_num)
					out.println("<option value='" + show_option[i] + "' selected='selected'>" + show_option[i] + "</option>");
				else
					out.println("<option value='" + show_option[i] + "' >" + show_option[i] + "</option>");
			%>
		</select> <input type="button" value="Column" id="Column" class="Little_btn">
		<div id="dialog-Column" title="Column" style="display: none">
			<%
			int count = 0;
			for (int i = 0; i < ob.length; i++) {
				if (count < column.length) {
					if (Integer.parseInt(column[count]) == i) {
				out.println("<input type='checkbox' name='show_column' id='show_column' value='" + column[count]
						+ "' checked>" + ob[i] + "<br/>");
				count++;
					} else
				out.println(
						"<input type='checkbox' name='show_column' id='show_column' value='" + i + "'>" + ob[i] + "<br/>");
				} else
					out.println("<input type='checkbox' name='show_column' id='show_column' value='" + i + "'>" + ob[i] + "<br/>");
			}
			%>

		</div>
		<img src="Image/excel.png" width="3%" height="3%"
			title="Download as excel file"
			onclick="document.Download_excel.submit();">
		<div style="display: none">
			<form action='download_.jsp' method='POST' name="Download_excel">
				<input type='hidden' name='Sql' id='Sql' value="<%=SqlCommand%>">
			</form>
		</div>

		<table class="table_show">
			<tr style="background-color: #C2C2C2" class="tr_show">
				<td class='td_show' align='center'>Structure</td>
				<%
				for (int i = 0; i < column.length; i++) {
					int Show_col = Integer.parseInt(column[i]);
					switch (Show_col) {
					case 0:
						out.println("<td class='td_show' align='center'>DB ID");
						break;
					case 1:
						out.println("<td class='td_show' align='center'>ZINC ID");
						break;
					case 2:
						out.println("<td class='td_show' align='center'>SMILES");
						break;
					case 3:
						out.println("<td class='td_show' align='center'>LogP");
						break;
					case 4:
						out.println("<td class='td_show' align='center'>QED");
						break;
					case 5:
						out.println("<td class='td_show' align='center'>SAS");
						break;
					case 6:
						out.println("<td class='td_show' align='center'>Active probability");
						break;
					case 7:
						out.println("<td class='td_show' align='center'>Inactive probability");
						break;
					}
					if(Show_col==0 || Show_col ==1)
					{
						out.println("</td>");
					}
					else{
					if (Sort != null) {
						if (sortdataop[Show_col].equals(Sort[0]) && !sortop[Show_col].equals(" ")) {
				%>
				<img src='Image/sort-<%=Sort[1]%>.png' title="<%=ob[Show_col]%>"
					onClick="javascript:changeSort('<%=Sort[0]%>','<%=Integer.parseInt(Sort[1])%>');"
					width='10' height='20'>
				</td>
				<%
				} else {
				if (!sortop[Show_col].equals(" ")) {
				%>
				<img src="Image/sort-0.png" title="<%=ob[Show_col]%>"
					onClick="javascript:changeSort('<%=sortdataop[Show_col]%>',0);"
					width='10' height='20'>
				</td>
				<%
				} else {
				out.println("</td>");
				}
				}
				} else if (!sortop[Show_col].equals("")) {
				%>
				<img src="Image/sort-0.png" title="<%=ob[Show_col]%>"
					onClick="javascript:changeSort('<%=sortdataop[Show_col]%>',0);"
					width='10' height='20'>
				</td>
				<%
				} else {
				out.println("</td>");
				}
				}
				}
				out.println("</tr>");
				%>
			</tr>
			<%
			int line = 0;
			DecimalFormat df = new DecimalFormat("#0.000");

			while (result.next()) {
				if (line % 2 == 0)
					out.println("<tr class='tr_show'>");
				else
					out.println("<tr class='tr_show' style='background-color:#F0F0F0'>");

				String smile = result.getString("SMILES");
				out.println("<td class='td_show' align='center'><a herf='#' onclick='Structure_View(\"" + smile
				+ "\")'>JSMOL</a></td>");
				for (int i = 0; i < column.length; i++) {
					switch (Integer.parseInt(column[i])) {
					case 0:
				out.println("<td class='td_show' align='center'>" + result.getString("No") + "</td>");
				break;
					case 1:
				out.println("<td class='td_show' align='center'>" + result.getString("ZINCID") + "</td>");
				break;
					case 2:
				out.println("<td class='td_show' align='center'>" + result.getString("SMILES") + "</td>");
				break;
					case 3:
				out.println("<td class='td_show' align='center'>" + df.format(result.getDouble("logP")) + "</td>");
				break;
					case 4:
				out.println("<td class='td_show' align='center'>" + df.format(result.getDouble("QED")) + "</td>");
				break;
					case 5:
				out.println("<td class='td_show' align='center'>" + df.format(result.getDouble("SAS")) + "</td>");
				break;
					case 6:
				out.println("<td class='td_show' align='center'>" + df.format(result.getDouble("Active")) + "</td>");
				break;
					case 7:
				out.println("<td class='td_show' align='center'>" + df.format(result.getDouble("Inactive")) + "</td>");
				break;
					}
				}
				out.println("</tr>");
				line++;
				if (line == show_num)
					break;
			}
			%>
		</table>
		<%
		} else {
		out.println("<p><font size='6' color='#AE0000'>No results were found. </font></p>");
		}
		} catch (ClassNotFoundException e) {
		out.println("Driver loading failed! <br/>");
		} catch (SQLException sqle) {
		out.println("DB linking failed! <br/>");
		}
		%>
	</div>
</body>
</html>