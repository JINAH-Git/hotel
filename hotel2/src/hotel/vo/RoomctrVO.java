//객실 가격를 담기위한 vo(value object)클래스
package hotel.vo;

public class RoomctrVO 
{
	protected String rtype;			//객실 타입 S:스탠다드D:더블F:패밀리ST:스위트
	protected String adprice;		//성인 가격
	protected String chprice;		//어린이 가격
	
	public String getRtype() 	{	return rtype;	}
	public String getAdprice() 	{	return adprice;	}
	public String getChprice() 	{	return chprice;	}
	
	public void setRtype(String rtype) 		{	this.rtype = rtype;		}
	public void setAdprice(String adprice)	{	this.adprice = adprice;	}
	public void setChprice(String chprice) 	{	this.chprice = chprice;	}
	
}
