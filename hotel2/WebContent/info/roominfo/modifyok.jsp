<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../../include/adminconfig.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
request.setCharacterEncoding("euc-kr");

//업로드가 가능한 사이즈를 지정한다.
int size = 10 * 1024 * 1024;
MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"EUC-KR",new DefaultFileRenamePolicy());

String acategory = multi.getParameter("acategory");

AdminVO vo = new AdminVO();
vo.setAtitle(multi.getParameter("atitle"));
vo.setAnote(multi.getParameter("anote"));
vo.setAno(Integer.parseInt(multi.getParameter("ano")));

//업로드된 파일명을 얻는다. (논리파일명)
vo.setAfname((String)multi.getFilesystemName("afname"));
//랜덤한 문자열을 생성한다. (물리파일명)
vo.setApname((String)UUID.randomUUID().toString());
System.out.println(multi.getParameter("atitle"));
System.out.println(multi.getParameter("anote"));
System.out.println(multi.getParameter("ano"));
System.out.println(multi.getFilesystemName("afname"));
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

//해당 게시물 작성자가 아니면 종료한다.
AdminDTO dto = new AdminDTO();
dto.modify(vo);
response.sendRedirect("index.jsp?acategory=" + acategory);	
%>