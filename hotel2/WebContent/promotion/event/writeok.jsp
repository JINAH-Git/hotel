<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../../include/adminconfig.jsp" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

request.setCharacterEncoding("euc-kr");

//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

AdminVO vo = new AdminVO();
//작성자 email ID를 설정한다.
vo.setEmail(login.getEmail());

vo.setAcategory(multi.getParameter("category"));
vo.setAtitle(multi.getParameter("atitle"));
vo.setAnote(multi.getParameter("anote"));
//업로드된 파일명을 얻는다. (논리파일명)
vo.setAfname((String)multi.getFilesystemName("attach"));
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
dto.insert(vo);

response.sendRedirect("view.jsp?ano=" + vo.getAno());
%>