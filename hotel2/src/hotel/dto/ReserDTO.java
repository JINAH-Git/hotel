//���� ���� ������ ��(Model)�� ���� ó���ϱ� ���� DTOŬ����(Data Transfer Object)
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.DBManager;
import hotel.vo.*;

public class ReserDTO extends DBManager
{
	//C: �����ϱ�
	public void insert(ReserVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert into reservation(totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) ";
		sql += "values('";
		sql += vo.getTotalprice() + "','";
		sql += vo.getCheckindate() + "','";
		sql += vo.getCheckoutdate() + "','";
		sql += this._R(vo.getRequest()) + "','";
		sql += vo.getAdcnt() + "','";
		sql += vo.getChcnt() + "','";		
		sql += vo.getKidcnt() + "','";		
		sql += this._R(vo.getEmail()) + "','";		
		sql += vo.getRtype() + "')" ;
		System.out.println(sql);
		this.RunSQL(sql);
		
		//�����ȣ�� �޴´�.
		sql = "select last_insert_id() as resvno ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setResvno(Integer.parseInt(this.getValue("resvno")));
		}
		this.DBClose();
	}
	
	//R: ���� ��ȣ�� ������ȸ
	public ReserVO readresvno(int resvno)
	{
		ReserVO vo = new ReserVO();
		this.DBOpen();
		String sql = "";
		sql  = "select resvno,totalprice,checkindate,checkoutdate,request,resvdate,adcnt,chcnt,kidcnt,email,rtype ";
		sql += "from reservation ";
		sql += "where resvno='" + resvno + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setResvno(Integer.parseInt(this.getValue("resvno")));
			vo.setTotalprice(this.getValue("totalprice"));
			vo.setCheckindate(this.getValue("checkindate"));
			vo.setCheckoutdate(this.getValue("checkoutdate"));
			vo.setRequest(this.getValue("request"));
			vo.setAdcnt(this.getValue("adcnt"));
			vo.setChcnt(this.getValue("chcnt"));
			vo.setKidcnt(this.getValue("kidcnt"));
			vo.setEmail(this.getValue("email"));
			vo.setRtype(this.getValue("rtype"));
		}
		this.DBClose();
		
		return vo;
	}

	//R: �α����� ��� �̸��Ϸ� ������ȸ
	public ReserVO reademail(String email)
	{
		ReserVO vo = new ReserVO();
		this.DBOpen();
		String sql = "";
		sql  = "select resvno,totalprice,checkindate,checkoutdate,request,resvdate,adcnt,chcnt,kidcnt,email,rtype ";
		sql += "from reservation ";
		sql += "where email='" + email + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setResvno(Integer.parseInt(this.getValue("resvno")));
			vo.setTotalprice(this.getValue("totalprice"));
			vo.setCheckindate(this.getValue("checkindate"));
			vo.setCheckoutdate(this.getValue("checkoutdate"));
			vo.setRequest(this.getValue("request"));
			vo.setAdcnt(this.getValue("adcnt"));
			vo.setChcnt(this.getValue("chcnt"));
			vo.setKidcnt(this.getValue("kidcnt"));
			vo.setEmail(this.getValue("email"));
			vo.setRtype(this.getValue("rtype"));
		}
		this.DBClose();
		
		return vo;
	}
	
	//R: �� ���� ���� ���
	public String gettotalprice(String rtype,ReserVO vo2,String night)
	{
		int totalprice = 0;
		this.DBOpen();
		RoomctrDTO dto = new RoomctrDTO();
		RoomctrVO vo = dto.priceread(rtype);
		totalprice  = Integer.parseInt(this._D(vo.getAdprice())) * Integer.parseInt(vo2.getAdcnt());
		totalprice += Integer.parseInt(this._D(vo.getChprice())) * Integer.parseInt(vo2.getChcnt());
		night = night.replace("��", "");
		totalprice = totalprice * Integer.parseInt(night);
		String price = Integer.toString(totalprice);
		this.DBClose();
		
		return price;
	}
	
	//R: ���� ��ü �� ��ȸ
	public int gettotal()
	{
		int total = 0;
		this.DBOpen();
		String sql = "";
		sql = "select count(*) as total from reservation ";
		System.out.println(sql);
		this.RunSelect(sql);		
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		this.DBClose();
		
		return total;
	}
	
	//������(����¡ó��)
	public ArrayList<ReserVO> list(String rtype)
	{
		ArrayList<ReserVO> list = new ArrayList<ReserVO>();

		this.DBOpen();
		String sql = "";
		sql  = "select resvno,totalprice,checkindate,checkoutdate,request,date(resvdate) as resvdate,adcnt,chcnt,kidcnt,email,rtype, ";
		sql += "(select ename from user where email = reservation.email) as ename ";
		sql += "from reservation ";
		sql += "where rtype = '" + rtype + "' ";
		sql += "order by checkindate asc ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			ReserVO vo = new ReserVO();
			vo.setResvno(Integer.parseInt(this.getValue("resvno")));
			vo.setTotalprice(this.getValue("totalprice"));
			vo.setCheckindate(this.getValue("checkindate"));
			vo.setCheckoutdate(this.getValue("checkoutdate"));
			vo.setRequest(this.getValue("request"));
			vo.setResvdate(this.getValue("resvdate"));
			vo.setAdcnt(this.getValue("adcnt"));
			vo.setChcnt(this.getValue("chcnt"));
			vo.setKidcnt(this.getValue("kidcnt"));
			vo.setEmail(this.getValue("email"));
			vo.setRtype(this.getValue("rtype"));
			vo.setEname(this.getValue("ename"));
			list.add(vo);
		}
		this.DBClose();
		
		return list;
	}
	
	
	//D: �������
	public void cancel(int resvno)
	{
		this.DBOpen();
		String sql = "";
		sql  = "delete from reservation ";
		sql += "where resvno = '" + resvno + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		this.DBClose();
	}
}