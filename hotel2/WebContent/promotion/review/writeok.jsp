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
//���� ����
int size = 10 * 1024 * 1024;
MultipartRequest multi = 
	new MultipartRequest(request,uploadPath,size,
		"EUC-KR",new DefaultFileRenamePolicy());

BoardVO vo = new BoardVO();
vo.setBtitle(multi.getParameter("btitle"));
vo.setCategory(multi.getParameter("category"));
vo.setBnote(multi.getParameter("bnote"));

UserVO login = (UserVO)session.getAttribute("login");

//�������θ� �˻��Ѵ�.
if(multi.getParameter("noticeop") == null)
{
	vo.setNoticeop("N");
}else
{
	vo.setNoticeop("Y");
}

//���ε�� ���ϸ��� ��´�. (�����ϸ�)
vo.setBfname((String)multi.getFilesystemName("attach"));
//������ ���ڿ��� �����Ѵ�. (�������ϸ�)
vo.setBpname((String)UUID.randomUUID().toString());
//�ۼ��� ID�� �����Ѵ�.
UserVO bwriter = (UserVO)session.getAttribute("login");
vo.setBwriter(login.getKname());
vo.setEmail(login.getEmail());



if(vo.getBfname() != null)
{
	//�����ϸ��� �������ϸ����� ���ϸ��� �����Ѵ�.
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
dto.insert(vo);

if( vo.getNoticeop().equals("Y") )
{
	dto.getnoticeop(vo);
}

response.sendRedirect("view.jsp?bno=" + vo.getBno());
%>