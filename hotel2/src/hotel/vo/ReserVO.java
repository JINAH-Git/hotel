//예약 정보 자료를 담기위한 vo(value object)클래스
package hotel.vo;

public class ReserVO 
{
	protected int    resvno; 	   //예약번호
	protected String totalprice;   //총결제가격
	protected String checkindate;  //체크인날짜
	protected String checkoutdate; //체크아웃날짜
	protected String request; 	   //요청사항
	protected String resvdate; 	   //예약일자
	protected String adcnt; 	   //성인수
	protected String chcnt; 	   //어린이수
	protected String kidcnt; 	   //유아수
	protected String email; 	   //이메일
	protected String rtype; 	   //객실타입
	protected String ename; 	   //영문 이름
	
	
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
