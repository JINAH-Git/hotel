//�Խù� ���� �ڷḦ ������� vo(value object)Ŭ����
package hotel.vo;

public class BoardVO 
{
	protected int	 bno;	  	//�Խù� ��ȣ
	protected String btitle;	//����
	protected String bwriter;	//�ۼ���
	protected String bnote;		//����
	protected String bfname;	//÷������_��
	protected String bpname;	//÷������_����
	protected String bwdate;	//�ۼ���
	protected String bhit;		//��ȸ��
	protected String category;	//�Խ��� ����  I:�� ����, R:����
	protected String noticeop;	//���� ����     N:�����,   Y:����
	protected String lockop;	//��б� ����  N:����,    Y:�����
	protected String email;	    //�̸���
	protected String name;	    //�̸�
	
	

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