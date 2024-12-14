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

AdminVO vo = new AdminVO();
//�ۼ��� email ID�� �����Ѵ�.
vo.setEmail(login.getEmail());

vo.setAcategory(multi.getParameter("category"));
vo.setAtitle(multi.getParameter("atitle"));
vo.setAnote(multi.getParameter("anote"));
//���ε�� ���ϸ��� ��´�. (�����ϸ�)
vo.setAfname((String)multi.getFilesystemName("attach"));
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
dto.insert(vo);

response.sendRedirect("view.jsp?ano=" + vo.getAno());
%>