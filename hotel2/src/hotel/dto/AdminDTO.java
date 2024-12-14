//������ �Խ��� ������ ��(Model)�� ���� ó���ϱ� ���� DTOŬ����(Data Transfer Object)
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

public class AdminDTO extends DBManager
{
		//C:BoardVO ��ü�� DB�� ����(insert)�Ѵ�
		public void insert(AdminVO vo)
		{
			this.DBOpen();
			String sql = "";
			sql  = "insert into admin (email,acategory,atitle,anote,afname,apname) ";
			sql += "values ('" + _R(vo.getEmail()) + "',";
			sql += "'" + _R(vo.getAcategory()) + "'," ;
			sql += "'" + _R(vo.getAtitle()) + "',";
			sql += "'" + _R(vo.getAnote()) + "'," ;
			sql += "'" + _R(vo.getAfname()) +"'," ;
			sql += "'" + _R(vo.getApname()) + "')" ;
			System.out.println(sql);
			this.RunSQL(sql);
			
			//��ϵ� �Խù��� ��ȣ�� ��´�.
			//last_insert_id�� ��ȣ�� �������� �Ǳ⶧���� from board���� ���� �ʿ䰡 ����!!!!
			//��ݵ� auto increment�� ��ȣ�� �������ش�.
			sql = "select last_insert_id() as ano";
			System.out.println(sql);
			this.RunSelect(sql);
			if(this.Next() == true)
			{
				vo.setAno(Integer.parseInt(this.getValue("ano")));
			}
			
			this.DBClose();
		}
		
		//R:DB���� �ڷḦ �����ͼ� (select)BoardVO�� �ִ´�.
		//IsHit : true - ��ȸ������, false - ��ȸ���������� ����.
		public AdminVO read(String ano, boolean IsHit)
		{
			AdminVO vo = null;
			this.DBOpen();
			
			String sql = "";
			sql  = "select ";
			sql += "	email,acategory,atitle,anote,afname,apname,awdate,ahit, ";
			sql += "	(select kname from user where email = admin.email) as name ";
			sql += "from admin ";
			sql += "where ano = '" + ano + "' ";
			System.out.println(sql);
			this.RunSelect(sql);
			
			if(this.Next() == true)
			{
				//�Խù� ������ ����.
				vo = new AdminVO();
				vo.setAno(Integer.parseInt(ano));
				vo.setEmail(this.getValue(_R("email")));
				vo.setAcategory(this.getValue(_R("acategory")));
				vo.setAtitle(this.getValue(_R("atitle")));
				vo.setAnote(this.getValue(_R("anote")));
				vo.setAfname(this.getValue(_R("afname")));
				vo.setApname(this.getValue("apname"));
				vo.setAwdate(this.getValue("awdate"));
				vo.setAhit(this.getValue("ahit"));
				vo.setName(this.getValue("name"));
				
				//��ȸ���� ������Ų��.
				if(IsHit == true)
				{
					sql = "update admin set ahit = ahit + 1 where ano = '" + ano + "'";
					this.RunSQL(sql);
				}
			}
			
			this.DBClose();
			//�Խù� ������ ���� ��� null�� return�ǰ� �ȴ�.
			return vo;
		}
		
		//U:BoardVO��ü�� DB�� ����(update)�Ѵ�.
		public void modify(AdminVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql  = "update admin set ";
			sql += "atitle = '" + _R(vo.getAtitle()) + "',";
			if(!vo.getAfname().equals("")) 
			{
				//÷�������� �����Ǿ ���ε� �� ��쿡�� ÷������ ������Ʈ
				sql += "anote = '" + _R(vo.getAnote()) + "',";
				sql += "afname = '" + _R(vo.getAfname()) + "',";
				sql += "apname = '" + _R(vo.getApname()) + "' ";
			}else
			{
				sql += "anote = '" + _R(vo.getAnote()) + "' ";
			}
			sql += "where ano = '" + vo.getAno() + "'";
			System.out.println(sql);
			this.RunSQL(sql);
			
			this.DBClose();
		}
		
		//U:BoardVO��ü�� DB�� ����(update)�Ѵ�.
		//���� ���� ���� �����͸� �����մϴ�.
		public void modifyq(AdminVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql  = "update admin set ";
			sql += "atitle = '" + _R(vo.getAtitle()) + "',";
			sql += "anote = '" + _R(vo.getAnote()) + "' ";
			sql += "where ano = '" + vo.getAno() + "'";
			System.out.println(sql);
			this.RunSQL(sql);
			
			this.DBClose();
		}
		
		//D:BoardVO��ü�� �̿��Ͽ� DB���� �����Ѵ�.
		//������ �Խ��ǿ��� reply�� �����Ƿ� �Խ��� ������ ��������ϴ�.
		public void delete(String ano)
		{
			this.DBOpen();
			String sql = "";
			
			sql = "delete from admin where ano = '" + ano + "'";
			System.out.println(sql);
			this.RunSQL(sql);
			
			this.DBClose();
		}
		
		//R:��ü �Խù� ������ ��´�
		//acategory : T-���� �Ұ�, F-�δ�ü�, N-��������, Q-���� ���� ����, E-�̺�Ʈ
		public int gettotal(String acategory)
		{
			int total = 0;
			this.DBOpen();
			
			String sql = "";
			sql  = "select count(*) as total ";
			sql += "from admin ";
			sql += "where acategory = '" + acategory + "'";
			System.out.println(sql);
			this.RunSelect(sql);
			
			if(this.Next() == true)
			{
				total = Integer.parseInt(this.getValue("total"));
			}
			
			this.DBClose();
			return total;
		}
		
		//R:DB���� �ڷ� ����� �����ͼ�(select) BoardVO LIST�� �ִ´�.
		//acategory : T-���� �Ұ�, F-�δ�ü�, N-��������, Q-���� ���� ����, E-�̺�Ʈ
		public ArrayList<AdminVO> list(String acategory,int PageNo)
		{
			ArrayList<AdminVO> list = new ArrayList<AdminVO>();
			
			int startNo = (PageNo - 1) * 10;
			
			this.DBOpen();
			
			String sql = "";
			sql  = "select ano,acategory,atitle,anote,date(awdate) as awdate,ahit ";
			sql += "from admin ";
			sql += "where acategory = '" + acategory + "' ";
			sql += "order by ano desc ";
			sql += "limit " + startNo + ",10";
			System.out.println(sql);
			this.RunSelect(sql);
			
			while(this.Next() == true)
			{
				AdminVO vo = new AdminVO();
				vo.setAno(Integer.parseInt(this.getValue("ano")));
				vo.setAcategory(this.getValue("acategory"));
				vo.setAtitle(this.getValue("atitle"));
				vo.setAnote(this.getValue("anote"));
				vo.setAwdate(this.getValue("awdate"));
				vo.setAhit(this.getValue("ahit"));
				
				list.add(vo);
			}
			
			this.DBClose();
			
			return list;
		}
		
		public ArrayList<AdminVO> list(String acategory)
		{
			ArrayList<AdminVO> list = new ArrayList<AdminVO>();
			this.DBOpen();
			
			String sql = "";
			sql  = "select ano,acategory,atitle,anote,afname,apname ";
			sql += "from admin ";
			sql += "where acategory = '" + acategory + "' ";
			sql += "order by ano desc ";
			System.out.println(sql);
			this.RunSelect(sql);
			
			while(this.Next() == true)
			{
				AdminVO vo = new AdminVO();
				vo.setAno(Integer.parseInt(this.getValue("ano")));
				vo.setAcategory(this.getValue("acategory"));
				vo.setAtitle(this.getValue("atitle"));
				vo.setAnote(this.getValue("anote"));
				vo.setAfname(this.getValue("afname"));
				vo.setApname(this.getValue("apname"));
				list.add(vo);
			}
			
			this.DBClose();
			return list;
		}
}