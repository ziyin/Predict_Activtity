<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="java.text.*"%>
<%@ page language="java" import="java.nio.charset.Charset"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>ALDH1A1_Activity</title>
<jsp:include page="Head_.jsp" />
<link rel="stylesheet" type="text/css" href="Style/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="Style/nouislider.css">
<link rel="stylesheet" type="text/css" href="Style/Unite.css"
	media="screen" />
<link
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.2/jquery-ui.min.js"></script>
<%
String smile = "", line = "";
double neg = 0.0, pos = 0.0;
%>
<script>
	function PredictActivate(Smile_value) {
		document.total_inform.Smiles.value = Smile_value;
		document.total_inform.submit()
<%if (request.getParameter("Smiles") != null) {
	if (!request.getParameter("Smiles").equals("")) {
		smile = request.getParameter("Smiles");
		smile = new String(smile.getBytes("iso-8859-1"), "UTF-8");

		Date dNow = new Date();
		SimpleDateFormat ft = new SimpleDateFormat("MMddHHmmss");
		String resiData = ft.format(dNow);
		String path = "C:\\Users\\ZIYIN\\Desktop\\SMILESFILE\\" + resiData + ".csv";

		File file = new File(path);
		file.getParentFile().mkdirs();

		FileWriter fw = new FileWriter(file);
		fw.append("activate");
		fw.append(',');
		fw.append("SMILES");
		fw.append('\n');
		fw.append("0");
		fw.append(',');
		fw.append(smile);
		fw.append('\n');
		fw.flush();
		fw.close();

		Runtime runtime = Runtime.getRuntime();
		Process process;

		process = runtime.exec("cmd.exe /c C:\\Users\\ZIYIN\\Desktop\\predict.bat " + resiData);

		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()), 30);
		line = br.readLine();
		String[] point = line.split("_");
		neg = Double.valueOf(point[0].split("neg:")[1]);
		pos = Double.valueOf(point[1].split("pos:")[1]);
		br.close();
	}
}%>
	}
</script>

<script>
function Drug_Bank()
{
		document.total_inform.DrugBankID.value = document.getElementById("Smiles_input").value;
		document.total_inform.submit();
		<%if (request.getParameter("DrugBankID") != null) {
	if (!request.getParameter("DrugBankID").equals("")) {
		String dbID = "";
		dbID = request.getParameter("DrugBankID");
		dbID = new String(dbID.getBytes("iso-8859-1"), "UTF-8");

		Runtime runtime = Runtime.getRuntime();
		Process process;

		process = runtime.exec("cmd.exe /c C:\\Users\\ZIYIN\\Desktop\\drugbankID.bat " + dbID);

		BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream()), 30);
		smile = br.readLine();
		if (smile == "拉拉") {
			smile = "";
		}
		br.close();

	}
}%>
}
</script>

<script src="jsmol/JSmol.min.js"></script>
<script src="jsmol/js/Jmol2.js"></script>
<script>jmolInitialize("jsmol");</script>
<script>
function Check_SMILES()
{
	url="https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/smiles/"+document.getElementById("Smiles_input").value+"/XML";
	  $.ajax({
	        url: url,
	        cache: false,
	        success: function () {
	        	PredictActivate(document.getElementById("Smiles_input").value);
	        },
			error : function(){
				document.getElementById("Wait").innerHTML="SMILES string format error...";
			}
	    });
}

	function Have_Search() {
		$('#SearchFrom [value="SMILES"]').prop('selected', true)
		document.getElementById("Have").style="display:none"
		document.getElementById("init").style="display:block"
			
		document.total_inform.Smiles.value="<%=smile%>";
		var Jsmol_smile=document.getElementById("Smiles").value;
		if(Jsmol_smile != "")
		{
			var a_p=document.getElementById("act_");
			a_p.innerHTML=<%=pos%>;
			var i_p=document.getElementById("ina_");
			i_p.innerHTML=<%=neg%>;
			if(a_p.innerHTML=="0")
			{
				document.getElementById("Smiles_input").value=Jsmol_smile
				Check_SMILES()
				document.getElementById("Wait").innerHTML="Wait....";
			}
			else
			{
				document.getElementById("Have").style="display:block"
				document.getElementById("init").style="display:none"
				var script = 'load :smiles:'+document.getElementById("Smiles").value+';spin on;';
				Info = {
					    spin:true,			
						j2sPath: "jsmol/j2s",
						use: "HTML5",
						readyFunction: null,
					        script
					        }
				$("#JSMOL_SHOW").html(Jmol.getAppletHtml("jmolApplet0",Info));
			}
		}
	}
</script>

<script>
function Search()
{
	document.getElementById("Have").style="display:none"
	document.getElementById("init").style="display:block"
	if(document.getElementById("Smiles_input").value!="")
	{
		document.getElementById("Wait").innerHTML="Wait....";
		choose= document.getElementById("SearchFrom").value;
		switch (choose) {
		  case 'SMILES':
			  Check_SMILES();
		    break;
		  case 'DrugBank':
			  Drug_Bank();
		    break;
		  default:
		  break;
		}	
	}
	else
	{
		document.getElementById("Wait").innerHTML="Please enter keyword";
	}
}

function Example()
{
	choose= document.getElementById("SearchFrom").value;
	switch (choose) {
	  case 'SMILES':
		  document.getElementById("Smiles_input").setAttribute("placeholder","eg.C1=CC=C(C=C1)C=O");
	    break;
	  case 'DrugBank':
		  document.getElementById("Smiles_input").setAttribute("placeholder","eg.DB11331");
	    break;
	  break;
	}
}
</script>

</head>
<body onload="Have_Search()">
	<div id="Persious_inform">
		<form id="total_inform" name="total_inform" action="Predict_.jsp"
			method="POST">
			<input type='hidden' name='Smiles' id='Smiles' value=""> <input
				type='hidden' name='DrugBankID' id='DrugBankID' value="">
		</form>
	</div>
	<input type="text" id="Smiles_input" placeholder="eg.C1=CC=C(C=C1)C=O"
		style="border-radius: 6px; font-size: 16px" />
	<select name="SearchFrom" ID="SearchFrom" onchange="Example()">
		<option value="SMILES">SMILES String</option>
		<option value="DrugBank">DrugBank ID</option>
	</select>
	<button style="border-radius: 6px; font-size: 16px" onclick="Search()">
		<i class="fa fa-search"></i>
	</button>
	<hr>
	<div id="Wait" style="font-size: 20px;"></div>
	<div id="Have">
		<div
			style="float: left; width: 30%; padding-top: 50px; padding-left: 10px"></div>
		<div
			style="float: left; width: 25%; padding-top: 50px; padding-left: 10px">
			<span id="JSMOL_SHOW"></span>
		</div>
		<div
			style="float: right; width: 45%; padding-top: 80px; padding-left: 10px">
			<font size='4'>Predict biological activity probability:</font> <br />
			<br />
			<table>
				<tr>
					<td><font size='4'>Activity : </font></td>
					<td><div id="act_" style="font-size: 18px;"></div></td>
				</tr>
				<tr>
					<td><font size='4'>Inactive : </font></td>
					<td><div id="ina_" style="font-size: 18px;"></div></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="init">
		<div style="float: left; width: 40%; padding-top: 50px; padding-left: 2%">
			<p><font size="4">This function can be used to predict the probability that the
				input compound is an ALDH1A1 active compound and an inactive
				compound online, so as to evaluate whether the compound has a chance
				to serve as a lead compound of ALDH1A1.
				</font></p>
			<p><font size="4">You can make predictions in two ways (1) SMILES string (2)
				DrugBank ID. The prediction results are not only probabilistic, but
				also present the 3D molecular graph of the compound you entered.
				</font></p>

			<p><font size="4">Get a better view of the structure with functions such as
				azimuth movement, key color modification, or zooming in and out.
				</font></p>
		</div>
		<div style="float: right; width: 55%; padding-top: 6%">
			<h1 style="color: #642100">Predict process：</h1>
			<p style="color: #642100">
				<font size="4">1. Choose the type of data entered(Default is
					SMILES String).</font>
			</p>
			<p style="color: #642100">
				<font size="4">2. After the input is completed, press the
					send button to wait for the prediction result.</font>
			</p>
			<p style="color: #642100">
				<font size="4">3. Assuming the prediction is wrong, please
					see the warning message.</font>
			</p>
		</div>
	</div>
</body>
</html>