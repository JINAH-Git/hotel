//���� ���� �ڷḦ ������� vo(value object)Ŭ����
package hotel.vo;

public class ReserVO 
{
	protected int    resvno; 	   //�����ȣ
	protected String totalprice;   //�Ѱ�������
	protected String checkindate;  //üũ�γ�¥
	protected String checkoutdate; //üũ�ƿ���¥
	protected String request; 	   //��û����
	protected String resvdate; 	   //��������
	protected String adcnt; 	   //���μ�
	protected String chcnt; 	   //��̼�
	protected String kidcnt; 	   //���Ƽ�
	protected String email; 	   //�̸���
	protected String rtype; 	   //����Ÿ��
	protected String ename; 	   //���� �̸�
	
	
	public int    getResvno() 		{ return resvno;	   }
	public String getTotalprice()   { return totalprice;   }
	public String getCheckindate()  { return checkindate;  }
	public String getCheckoutdate() { return checkoutdate; }
	public String getRequest() 		{ return request;	   }
	public String getResvdate() 	{ return resvdate;	   }
	public String getAdcnt() 		{ return adcnt;		   }
	public String getChcnt() 		{ return chcnt;		   }
	public String getKidcnt() 		{ return kidcnt;	   }
	public String getEmail() 		{ return email;		   }
	public String getRtype() 		{ return rtype;		   }
	public String getEname() 		{ return ename;		   }
	
	
	public void setResvno(int resvno) 				 { this.resvno 		 = resvno;		 }
	public void setTotalprice(String totalprice) 	 { this.totalprice   = totalprice;	 }
	public void setCheckindate(String checkindate) 	 { this.checkindate  = checkindate;  }
	public void setCheckoutdate(String checkoutdate) { this.checkoutdate = checkoutdate; }
	public void setRequest(String request) 			 { this.request 	 = request;		 }
	public void setResvdate(String resvdate) 		 { this.resvdate 	 = resvdate;	 }
	public void setAdcnt(String adcnt) 				 { this.adcnt 		 = adcnt;		 }
	public void setChcnt(String chcnt) 			     { this.chcnt 		 = chcnt;		 }
	public void setKidcnt(String kidcnt) 			 { this.kidcnt 		 = kidcnt;		 }
	public void setEmail(String email) 				 { this.email 		 = email;		 }
	public void setRtype(String rtype) 				 { this.rtype 		 = rtype; 		 }
	public void setEname(String ename) 				 { this.ename 		 = ename; 		 }
	
	
	
}