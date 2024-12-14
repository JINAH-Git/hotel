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

//업로드가 가능한 최대 파일 크기를 지정한다.
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

//업로드된 파일명을 얻는다. (논리파일명)
vo.setAfname((String)multi.getFilesystemName("afname"));
//랜덤한 문자열을 생성한다. (물리파일명)
vo.setApname((String)UUID.randomUUID().toString());

if(vo.getAfname() != null)
{
	//논리파일명을 물리파일명으로 파일명을 변경한다.
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