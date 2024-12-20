//객실 가격 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)
package hotel.dto;

import java.text.DecimalFormat;
import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

public class RoomctrDTO extends DBManager
{
	//C:처음 가격 설정-sql로 때려 넣을것..
	/*
	insert into roompricectrl (rtype,adprice,chprice) values ('S','450000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('D','700000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('F','900000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('ST','2000000','50000');
	*/
	
	//R:DB에서 자료를 가져와서 (select)RoomctrVO에 넣는다.
	public RoomctrVO priceread(String rtype)
	{
		RoomctrVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select adprice,chprice ";
		sql += "from roompricectrl ";
		sql += "where rtype = '" + rtype + "'";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			//가격 정보가 있음.
			vo = new RoomctrVO();
			vo.setRtype(rtype);
			vo.setAdprice(comma(this.getValue("adprice")));
			vo.setChprice(comma(this.getValue("chprice")));
		}
		
		this.DBClose();
		return vo;
	}
	
	// read한 가격에 콤마찍기
	public String comma(String value) {
		DecimalFormat df = new DecimalFormat("###,###");
		String value_str = df.format(Integer.parseInt(value));
		return value_str;
	}	
	
	//U:RoomctrVO객체를 DB에 변경(update)한다.
	public void pricemodify(RoomctrVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update roompricectrl set ";		
		sql += "adprice = '" + _R(vo.getAdprice()) + "', ";
		sql += "chprice = '" + _R(vo.getChprice()) + "' ";
		sql += "where rtype = '" + vo.getRtype() + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBOpen();
	}
	
	//객실 목록 보기
	public ArrayList<RoomctrVO> list()
	{
		ArrayList<RoomctrVO> list = new ArrayList<RoomctrVO>();
		RoomctrVO vo = null;
		this.DBOpen();
		String sql = "";
		sql  = "select rtype,adprice,chprice from roompricectrl ";
		sql += "order by field(rtype, 'S', 'D', 'F', 'ST')";
		System.out.println(sql);
		this.RunSelect(sql);
		while(this.Next() == true)
		{
			vo = new RoomctrVO();
			vo.setRtype(this.getValue("rtype"));
			vo.setAdprice(this.getValue("adprice"));
			vo.setChprice(this.getValue("chprice"));
			list.add(vo);
		}
		this.DBClose();
		
		return list;
	}
}
