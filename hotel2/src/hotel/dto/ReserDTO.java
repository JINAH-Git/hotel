//예약 정보 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.DBManager;
import hotel.vo.*;

public class ReserDTO extends DBManager
{
	//C: 예약하기
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
		
		//예약번호를 받는다.
		sql = "select last_insert_id() as resvno ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setResvno(Integer.parseInt(this.getValue("resvno")));
		}
		this.DBClose();
	}
	
	//R: 예약 번호로 예약조회
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

	//R: 로그인한 경우 이메일로 예약조회
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
	
	//R: 총 결제 가격 계산
	public String gettotalprice(String rtype,ReserVO vo2,String night)
	{
		int totalprice = 0;
		this.DBOpen();
		RoomctrDTO dto = new RoomctrDTO();
		RoomctrVO vo = dto.priceread(rtype);
		totalprice  = Integer.parseInt(this._D(vo.getAdprice())) * Integer.parseInt(vo2.getAdcnt());
		totalprice += Integer.parseInt(this._D(vo.getChprice())) * Integer.parseInt(vo2.getChcnt());
		night = night.replace("박", "");
		totalprice = totalprice * Integer.parseInt(night);
		String price = Integer.toString(totalprice);
		this.DBClose();
		
		return price;
	}
	
	//R: 예약 전체 수 조회
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
	
	//예약목록(페이징처리)
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
	
	
	//D: 예약취소
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
