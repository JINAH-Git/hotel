<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../../include/config.jsp" %>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
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

String category = multi.getParameter("category");
String curPage  = multi.getParameter("page");
if(curPage == null) curPage = "1";

BoardVO vo = new BoardVO();
vo.setBtitle(multi.getParameter("btitle"));
vo.setBnote(multi.getParameter("bnote"));
vo.setBno(Integer.parseInt(multi.getParameter("bno")));

vo.setLockop("N");

//업로드된 파일명을 얻는다. (논리파일명)
vo.setBfname((String)multi.getFilesystemName("attach"));
//랜덤한 문자열을 생성한다. (물리파일명)
vo.setBpname((String)UUID.randomUUID().toString());

if(vo.getBfname() != null)
{
	//논리파일명을 물리파일명으로 파일명을 변경한다.
	String srcName = uploadPath + "/" + vo.getBfname();
	System.out.println(srcName);
	String targetName = uploadPath + "/" + vo.getBpname();
	System.out.println(targetName);
	File srcFile    = new File(srcName);
	File targetFile = new File(targetName);
	srcFile.renameTo(targetFile);
}else
{
	vo.setBfname("");
	vo.setBpname("");
}

BoardDTO dto = new BoardDTO();
dto.modify(vo);

response.sendRedirect("view.jsp?bno=" + vo.getBno() + "&page=" + curPage);
%>