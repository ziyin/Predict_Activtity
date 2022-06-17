function checkAll(){
	var hasCheck = 0;
	var ck =  document.getElementsByName("show_column");
	for(var i=0;i<ck.length;i++){
		if(ck[i].checked==true){
			hasCheck += 1;
		}
	}
	return hasCheck;
}

function changeShowPage(page_no)
{
	document.total_inform.now_page.value=page_no;
	changeShowOP(); 
}

function changePageNum(page_num)
{
	document.total_inform.shownum.value=page_num;		
	changeShowOP(); 
}

function changeSort(column,method)
{
	if(method==1)
		document.total_inform.ordsort.value=column+",2";
	else
		document.total_inform.ordsort.value=column+",1";
	
	changeShowOP(); 
}

function changeAct(Act1,Act2)
{
	document.total_inform.Act1.value=Act1;
	document.total_inform.Act2.value=Act2;
	changeShowOP(); 
}

function changeInact(Inact1,Inact2)
{
	document.total_inform.Inact1.value=Inact1;
	document.total_inform.Inact2.value=Inact2;
	changeShowOP(); 
}

function changeShowOP()
{
	document.total_inform.showop.value="";
	var ck =  document.getElementsByName("show_column");
	if (checkAll()!=0){
				for(var i=0;i<ck.length;i++){
			if(ck[i].checked==true){
				document.total_inform.showop.value+=i+","
			}
		}
	}
	document.total_inform.submit(); 
}