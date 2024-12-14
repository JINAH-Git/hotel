//���� ���� ������ ��(Model)�� ���� ó���ϱ� ���� DTOŬ����(Data Transfer Object)
package hotel.dto;

import java.text.DecimalFormat;
import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

public class RoomctrDTO extends DBManager
{
	//C:ó�� ���� ����-sql�� ���� ������..
	/*
	insert into roompricectrl (rtype,adprice,chprice) values ('S','450000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('D','700000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('F','900000','50000');
	insert into roompricectrl (rtype,adprice,chprice) values ('ST','2000000','50000');
	*/
	
	//R:DB���� �ڷḦ �����ͼ� (select)RoomctrVO�� �ִ´�.
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
			//���� ������ ����.
			vo = new RoomctrVO();
			vo.setRtype(rtype);
			vo.setAdprice(comma(this.getValue("adprice")));
			vo.setChprice(comma(this.getValue("chprice")));
		}
		
		this.DBClose();
		return vo;
	}
	
	// read�� ���ݿ� �޸����
	public String comma(String value) {
		DecimalFormat df = new DecimalFormat("###,###");
		String value_str = df.format(Integer.parseInt(value));
		return value_str;
	}	
	
	//U:RoomctrVO��ü�� DB�� ����(update)�Ѵ�.
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
	
	//���� ��� ����
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