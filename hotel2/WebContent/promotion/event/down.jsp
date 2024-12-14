<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../../include/adminconfig.jsp" %>
<%
String ano = request.getParameter("ano");

AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);

if(vo == null)
{
	response.sendRedirect("index.jsp");
	return;
}

String afname = vo.getAfname();
String apname = vo.getApname();

String filename = apname;

//out.println("filename:" + filename + "<br>");

String fullname = uploadPath + "\\" + apname;

//out.println("fullname:" + fullname + "<br>");

response.setContentType("application/octet-stream"); //상단 contentType을 (~)으로 보낸다.
response.setHeader("Content-Disposition","attachment; filename=" + afname); //헤더에 추가해서 (~) 보낸다.  

File file = new File(fullname);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>