<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">

<script src="jsmol/JSmol.min.js"></script>
<script src="jsmol/js/Jmol2.js"></script>
<script>jmolInitialize("jsmol");</script>

<script>
function Check_SMILES()
{	  
	var SMILES_="";
	
	var url = new URL(location.href);
	SMILES_=decodeURIComponent(url.searchParams.get("SMILES_"))
	
	var Show_DIV=document.getElementById("Show_DIV");
	Show_DIV.style.width=document.body.clientWidth*0.265;
		url="https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/smiles/"+SMILES_+"/SDF?record_type=3d";
		  $.ajax({
		        url: url,
		        cache: false,
		        success: function () {
		        	show_3D(SMILES_);
		        },
				error : function(){
					document.getElementById("JSMOL_SHOW").innerHTML="No structure file..";
				}
		    });
}

function show_3D(SMILES_)
{
	var script = 'load :smiles:'+SMILES_+';spin on;';
	Info = {
		    spin:true,			
			j2sPath: "jsmol/j2s",
			use: "HTML5",
			readyFunction: null,
		        script
		        }
	$("#JSMOL_SHOW").html(Jmol.getAppletHtml("jmolApplet0",Info));	
}

function jmolCheckbox(script1, script0, text, ischecked, id) 
{
	Jmol.jmolCheckbox("jmolApplet0", script1, script0, text, ischecked, id);
}
</script>

</head>
<input type='hidden' name='SMILES_' id='SMILES_' value="">
<body onload="Check_SMILES()">
	<div id="Show_DIV" style="text-align: center">
		<span id="JSMOL_SHOW"><font size="5">Wait...</font></span>
	</div>
</body>
</html>