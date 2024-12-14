<!-- 
23-07-10 ���� | jsp �ۼ���.
 -->
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

//���ε尡 ������ �ִ� ���� ũ�⸦ �����Ѵ�.
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
vo.setCategory(multi.getParameter("category"));
vo.setBno(Integer.parseInt(multi.getParameter("bno")));

if(multi.getParameter("lockop") == null)
{
	vo.setLockop("N");
}else
{
	vo.setLockop("Y");
}

//���ε�� ���ϸ��� ��´�. (�������ϸ�)
vo.setBfname((String)multi.getFilesystemName("attach"));
//������ ���ڿ��� �����Ѵ�. (�������ϸ�)
vo.setBpname((String)UUID.randomUUID().toString());

if(vo.getBfname() != null)
{
	//�������ϸ��� �������ϸ����� ���ϸ��� �����Ѵ�.
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