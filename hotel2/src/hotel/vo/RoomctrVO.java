//���� ���ݸ� ������� vo(value object)Ŭ����
package hotel.vo;

public class RoomctrVO 
{
	protected String rtype;			//���� Ÿ�� S:���Ĵٵ�D:����F:�йи�ST:����Ʈ
	protected String adprice;		//���� ����
	protected String chprice;		//��� ����
	
	public String getRtype() 	{	return rtype;	}
	public String getAdprice() 	{	return adprice;	}
	public String getChprice() 	{	return chprice;	}
	
	public void setRtype(String rtype) 		{	this.rtype = rtype;		}
	public void setAdprice(String adprice)	{	this.adprice = adprice;	}
	public void setChprice(String chprice) 	{	this.chprice = chprice;	}
	
}