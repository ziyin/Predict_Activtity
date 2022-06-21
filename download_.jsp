<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page language="java" import="java.io.*"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="com.mysql.jdbc.Driver"%>
<%@ page language="java" import="java.text.*"%>
<%@ page language="java" import="jxl.*"%>
<%@ page language="java" import="jxl.write.*"%>
<%@ page language="java" import="jxl.write.biff.RowsExceededException"%>
<%@ page language="java" import="jxl.format.*"%>

<%!private void putRow(WritableSheet ws, int rowNum, ArrayList cells) throws RowsExceededException, WriteException {
		for (int j = 0; j < cells.size(); j++) {
			Label cell = new Label(j, rowNum, "" + cells.get(j));
			ws.addCell(cell);
		}
	}%>

<%
String driverName = "com.mysql.jdbc.Driver"; //ÅX°Ê

String DB_URL = "jdbc:mysql://localhost:3306/zinc250k?serverTimezone=UTC";
String Account = "root";
String Password = "root";
Connection connDB = null;

String SqlCommand = "";
if (!request.getParameter("Sql").equals("")) {
	SqlCommand = request.getParameter("Sql");
	SqlCommand = new String(SqlCommand.getBytes("iso-8859-1"), "UTF-8");
}

SimpleDateFormat ft = new SimpleDateFormat("yyyyMMdd");
String Today = ft.format(new java.util.Date());

response.reset();
response.setHeader("Content-disposition", "attachment; filename=ZINC250VS_" + Today + ".xls");


OutputStream os = response.getOutputStream();
WritableWorkbook workbook = Workbook.createWorkbook(os);
WritableSheet sheet = workbook.createSheet("Sheet1", 0);

try {
	Class.forName(driverName).newInstance();
	connDB = DriverManager.getConnection(DB_URL, Account, Password);
	Statement cmd = connDB.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	ResultSet result;
	result = cmd.executeQuery(SqlCommand);

    ArrayList list = new ArrayList();
    list.add("ZINC_ID");
    list.add("SMILES");
    list.add("LogP");
    list.add("QED");
    list.add("SAS");
    list.add("Active_probability");
    list.add("Inactive_probability");
    
    putRow(sheet, 0, list);
    int rowNum = 1;
    while(result.next()){
        list = new ArrayList();
        list.add(result.getString("ZINCID"));
        list.add(result.getString("SMILES"));
        list.add(result.getString("logP"));
        list.add(result.getString("QED"));
        list.add(result.getString("SAS"));
        list.add(result.getString("Active"));
        list.add(result.getString("Inactive"));   
        putRow(sheet, rowNum, list);
        rowNum++;
    }
} catch (ClassNotFoundException e) {
	System.out.print("Driver loading failed! <br/>");
} catch (SQLException sqle) {
	System.out.print("SQL Exception : " + sqle.toString() + "<br/>");
	System.out.print("DB linking failed! <br/>");
}catch(Exception e){
	System.out.print(e);
}
workbook.write();
workbook.close();
os.flush();
os.close();
%>