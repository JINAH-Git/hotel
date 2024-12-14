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

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

String category = multi.getParameter("category");
String curPage  = multi.getParameter("page");
if(curPage == null) curPage = "1";

AdminVO vo = new AdminVO();
vo.setAtitle(multi.getParameter("atitle"));
vo.setAnote(multi.getParameter("anote"));
vo.setAcategory(category);
vo.setAno(Integer.parseInt(multi.getParameter("ano")));

//���ε�� ���ϸ��� ��´�. (�����ϸ�)
vo.setAfname((String)multi.getFilesystemName("attach"));
//������ ���ڿ��� �����Ѵ�. (�������ϸ�)
vo.setApname((String)UUID.randomUUID().toString());

if(vo.getAfname() != null)
{
	//�����ϸ��� �������ϸ����� ���ϸ��� �����Ѵ�.
	File srcFile    = new File(uploadPath + "/" + vo.getAfname());
	File targetFile = new File(uploadPath + "/" + vo.getApname());
	srcFile.renameTo(targetFile);
}else
{
	vo.setAfname("");
	vo.setApname("");
}

AdminDTO dto = new AdminDTO();
dto.modify(vo);

response.sendRedirect("view.jsp?category=" + category + "&ano=" + vo.getAno()+ "&page=" + curPage);
%>