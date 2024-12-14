//게시물 정보 자료를 담기위한 vo(value object)클래스
package hotel.vo;

public class BoardVO 
{
	protected int	 bno;	  	//게시물 번호
	protected String btitle;	//제목
	protected String bwriter;	//작성자
	protected String bnote;		//내용
	protected String bfname;	//첨부파일_논리
	protected String bpname;	//첨부파일_물리
	protected String bwdate;	//작성일
	protected String bhit;		//조회수
	protected String category;	//게시판 구분  I:고객 문의, R:리뷰
	protected String noticeop;	//공지 여부     N:비공지,   Y:공지
	protected String lockop;	//비밀글 여부  N:공개,    Y:비공개
	protected String email;	    //이메일
	protected String name;	    //이름
	
	

	public int	  getBno()  	{	return bno;	     }
	public String getBtitle()   {	return btitle;	 }
	public String getBwriter()  {	return bwriter;	 }
	public String getBnote()    {	return bnote;	 }
	public String getBfname()   {	return bfname;	 }
	public String getBpname()   {	return bpname;	 }
	public String getBwdate()   {	return bwdate;	 }
	public String getBhit()     {	return bhit;	 }
	public String getCategory() {	return category; }
	public String getNoticeop() {	return noticeop; }
	public String getLockop()   {	return lockop;	 }
	public String getEmail()    {	return email;	 }
	public String getName()     {	return name;	 }

	
	public void setBno(int bno) 			 {	this.bno = bno;		      }
	public void setBtitle(String btitle) 	 {	this.btitle = btitle;	  }
	public void setBwriter(String bwriter)   {	this.bwriter = bwriter;   }
	public void setBnote(String bnote) 	  	 {	this.bnote = bnote;		  }
	public void setBfname(String bfname) 	 {	this.bfname = bfname;	  }
	public void setBpname(String bpname) 	 {	this.bpname = bpname;	  }
	public void setBwdate(String bwdate) 	 {	this.bwdate = bwdate; 	  }
	public void setBhit(String bhit)         {	this.bhit = bhit;		  }
	public void setCategory(String category) {	this.category = category; }
	public void setNoticeop(String noticeop) {	this.noticeop = noticeop; }
	public void setLockop(String lockop)     {	this.lockop = lockop;	  }
	public void setEmail(String email) 		 {	this.email = email;		  }
	public void setName(String name) 		 {	this.name = name;		  }

	public BoardVO()
	{
		
	}
	
}