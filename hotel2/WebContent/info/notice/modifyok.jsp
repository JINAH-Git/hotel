<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../../include/head.jsp" %>
<%@ include file="../../include/adminconfig.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
request.setCharacterEncoding("euc-kr");

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

String acategory = multi.getParameter("acategory");
String curPage  = multi.getParameter("page");

AdminVO vo = new AdminVO();
vo.setAtitle(multi.getParameter("atitle"));
vo.setAnote(multi.getParameter("anote"));
vo.setAno(Integer.parseInt(multi.getParameter("ano")));

//���ε�� ���ϸ��� ��´�. (�����ϸ�)
vo.setAfname((String)multi.getFilesystemName("afname"));
//������ ���ڿ��� �����Ѵ�. (�������ϸ�)
vo.setApname((String)UUID.randomUUID().toString());

if(vo.getAfname() != null)
{
	//�����ϸ��� �������ϸ����� ���ϸ��� �����Ѵ�.
	String srcName = uploadPath + "/" + vo.getAfname();
	System.out.println(srcName);
	String targetName = uploadPath + "/" + vo.getApname();
	System.out.println(targetName);
	File srcFile    = new File(srcName);
	File targetFile = new File(targetName);
	srcFile.renameTo(targetFile);
}else
{
	vo.setAfname("");
	vo.setApname("");
}

AdminDTO dto = new AdminDTO();
dto.modify(vo);

response.sendRedirect("view.jsp?acategory=" + acategory + "&ano=" + vo.getAno() + "&page=" + curPage);
%>