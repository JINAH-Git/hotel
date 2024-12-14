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

//���ε尡 ������ ����� �����Ѵ�.
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

//������ �Խ��ǿ��� ���� �������ش�.
AdminVO vo = new AdminVO();
vo.setAtitle(multi.getParameter("atitle"));
vo.setAcategory(multi.getParameter("acategory"));
vo.setAnote(multi.getParameter("anote"));

//���ε�� ���ϸ��� ��´�. (�����ϸ�)
vo.setAfname((String)multi.getFilesystemName("afname"));
//������ ���ڿ��� �����Ѵ�. (�������ϸ�)
vo.setApname((String)UUID.randomUUID().toString());

//�ۼ��� ID�� �����Ѵ�.
UserVO user = (UserVO)session.getAttribute("login");
vo.setName(user.getKname());
vo.setEmail(user.getEmail());

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

response.sendRedirect("index.jsp?acategory=" + vo.getAcategory());
%>
