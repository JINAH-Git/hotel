//�Խù� ������ ��(Model)�� ���� ó���ϱ� ���� DTOŬ����(Data Transfer Object)

package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

//�� �޼ҵ忡�� DBManager�� ����ϰ� ����. ���� DBManager�� ����Ͽ� ����ϴ°� �����ϴ�.
public class BoardDTO extends DBManager
{
	//C:BoardVO ��ü�� DB�� ����(insert)�Ѵ�
	public void insert(BoardVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert into board (email,category,btitle,bwriter,bnote,bfname,bpname) ";
		sql += "values ('" + vo.getEmail() + "',";
		sql += "'" + _R(vo.getCategory()) + "'," ;
		sql += "'" + _R(vo.getBtitle()) + "',";
		sql += "'" + _R(vo.getBwriter()) + "',";
		sql += "'" + _R(vo.getBnote()) + "'," ;
		sql += "'" + _R(vo.getBfname()) +"'," ;
		sql += "'" + _R(vo.getBpname()) + "')" ;
		this.RunSQL(sql);
		System.out.println(sql);
		//��ϵ� �Խù��� ��ȣ�� ��´�.
		//last_insert_id�� ��ȣ�� �������� �Ǳ⶧���� from board���� ���� �ʿ䰡 ����
		//��ݵ� auto increment�� ��ȣ�� �������ش�.
		sql = "select last_insert_id() as bno";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setBno(Integer.parseInt(this.getValue("bno")));
		}
		
		this.DBClose();
	}
	
	//R:DB���� �ڷḦ �����ͼ� (select)BoardVO�� �ִ´�.
	//IsHit : true - ��ȸ������, false - ��ȸ���������� ����.
	public BoardVO read(String bno, boolean IsHit)
	{
		BoardVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select ";
		sql += "	email,category,btitle,bnote,bfname,bpname,lockop,bwdate,bhit, ";
		sql += "	(select kname from user where email = board.email) as name ";
		sql += "from board ";
		sql += "where bno = '" + bno + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			//�Խù� ������ ����.
			vo = new BoardVO();
			vo.setBno(Integer.parseInt(bno));
			vo.setEmail(this.getValue(_R("email")));
			vo.setCategory(this.getValue(_R("category")));
			vo.setBtitle(this.getValue(_R("btitle")));
			vo.setBnote(this.getValue(_R("bnote")));
			vo.setBfname(this.getValue("bfname"));
			vo.setBpname(this.getValue("bpname"));
			vo.setLockop(this.getValue(_R("lockop")));
			vo.setBwdate(this.getValue("bwdate"));
			vo.setBhit(this.getValue("bhit"));
			vo.setName(this.getValue("name"));
			
			//��ȸ���� ������Ų��.
			if(IsHit == true)
			{
				sql = "update board set bhit = bhit + 1 where bno = '" + bno + "'";
				this.RunSQL(sql);
			}
		}
		
		this.DBClose();
		//�Խù� ������ ���� ��� null�� return�ǰ� �ȴ�.
		return vo;
	}
	
	//U:BoardVO��ü�� DB�� ����(update)�Ѵ�.
	public void modify(BoardVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update board set ";
		sql += "btitle = '" + _R(vo.getBtitle()) + "',";
		sql += "lockop = '" + _R(vo.getLockop()) + "',";
		if(!vo.getBfname().equals("")) 
		{
			//÷�������� �����Ǿ ���ε� �� ��쿡�� ÷������ ������Ʈ
			sql += "bnote = '" + _R(vo.getBnote()) + "',";
			sql += "bfname = '" + _R(vo.getBfname()) + "',";
			sql += "bpname = '" + _R(vo.getBpname()) + "' ";
		}else
		{
			sql += "bnote = '" + _R(vo.getBnote()) + "' ";
		}
		sql += "where bno = '" + vo.getBno() + "'";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	
	//U: ��б� ������ ���ش�.
	public void getlockop(BoardVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update board set ";
		sql += "lockop = 'Y'";
		sql += "where bno = '" + vo.getBno() + "'";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	
	//U: ������ ������ ���ش�.
		public void getnoticeop(BoardVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql  = "update board set ";
			sql += "noticeop = 'Y'";
			sql += "where bno = '" + vo.getBno() + "'";
			System.out.println(sql);
			this.RunSQL(sql);
			
			this.DBClose();
		}
	
	//D:BoardVO��ü�� �̿��Ͽ� DB���� �����Ѵ�.
	//�Խñ��� �����ϰ��ʹٸ� fk�� ����� reply���� �����ְ�, �Խñ��� �������Ѵ�.
	public void delete(String bno)
	{
		this.DBOpen();
		String sql = "";
		
		sql = "delete from reply where bno = '" + bno + "'";
		System.out.println(sql);
		this.RunSQL(sql);
		
		sql = "delete from board where bno = '" + bno + "'";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}

	//R:��ü �Խù� ������ ��´�
	//category : I-���� ���� �Խ���, R-���� �Խ���
	public int gettotal(String category)
	{
		int total = 0;
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as total ";
		sql += "from board ";
		sql += "where category = '" + category + "'";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		
		this.DBClose();
		return total;
	}
	
	//�������� ������ ��´�.
	public int getnotice()
	{
		int noticenum = 0;
		this.DBOpen();
		
		String sql = "";
		sql  = "select count(*) as total ";
		sql += "from board ";
		sql += "where category = 'R' ";
		sql += "and noticeop = 'Y' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			noticenum = Integer.parseInt(this.getValue("total"));
		}
		
		this.DBClose();
		return noticenum;
	}
	
	//noticeop�� ������ ���
	public BoardVO noticeread(String category)
	{
		BoardVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select bno,category,btitle,date(bwdate) as bwdate,noticeop,bhit, ";
		sql += "(select kname from user where email = board.email) as name ";
		sql += "from board ";
		sql += "where category = '" + category + "' ";
		sql += "and noticeop = 'Y' ";
		sql += "order by bno desc ";
		sql += "limit 0,1";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			//�Խù� ������ ����.
			vo = new BoardVO();
			vo.setBno(Integer.parseInt(this.getValue("bno")));
			vo.setCategory(this.getValue(_R("category")));
			vo.setBtitle(this.getValue(_R("btitle")));
			vo.setBwdate(this.getValue("bwdate"));
			vo.setLockop(this.getValue(_R("noticeop")));		
			vo.setBhit(this.getValue("bhit"));
			vo.setName(this.getValue("name"));
			
		}
		
		this.DBClose();
		//�Խù� ������ ���� ��� null�� return�ǰ� �ȴ�.
		return vo;
		}
	
	//R:DB���� �ڷ� ����� �����ͼ�(select) BoardVO LIST�� �ִ´�.
	//category : I-���� ���� �Խ���, R-���� �Խ���
	public ArrayList<BoardVO> list(String category,int pageno)
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		int startNo = (pageno - 1) * 10;
		
		this.DBOpen();
		
		String sql = "";
		sql  = "select bno,category,btitle,date(bwdate) as bwdate,bhit,lockop, ";
		sql += "(select kname from user where email = board.email) as bwriter, ";
		sql += "(select count(*) from reply where bno = board.bno) as rcount ";
		sql += "from board ";
		sql += "where category = '" + category + "' ";
		sql += "and noticeop = 'N' ";
		sql += "order by bno desc ";
		sql += "limit " + startNo + ",10";
		System.out.println(sql);
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(Integer.parseInt(this.getValue("bno")));
			vo.setCategory(this.getValue("category"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setBwdate(this.getValue("bwdate"));
			vo.setBhit(this.getValue("bhit"));
			vo.setLockop(this.getValue("lockop"));
			vo.setBwriter(this.getValue("bwriter"));
			
			list.add(vo);
		}
		
		this.DBClose();
		
		return list;
	}
	
}