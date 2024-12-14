<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../../include/config.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String bno = request.getParameter("bno");

//BoardDTO�� �̿��ؼ� BoardVO�� �ִ� ���� �ҷ��´�
BoardDTO dto = new BoardDTO();
BoardVO   vo = dto.read(bno,false);

if(vo == null)
{
	response.sendRedirect("index.jsp");
	return;
}

String bfname = vo.getBfname();
String bpname = vo.getBpname();

String filename = bpname;

//out.println("filename:" + filename + "<br>");

String fullname = uploadPath + "\\" + filename;

//out.println("fullname:" + fullname + "<br>");

response.setContentType("application/octet-stream"); //��� contentType�� (~)���� ������.
response.setHeader("Content-Disposition","attachment; filename=" + bfname); //����� �߰��ؼ� (~) ������.  

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