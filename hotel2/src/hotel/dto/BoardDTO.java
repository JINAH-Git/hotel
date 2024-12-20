//게시물 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)

package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

//각 메소드에서 DBManager를 사용하고 있음. 따라서 DBManager를 상속하여 사용하는게 간편하다.
public class BoardDTO extends DBManager
{
	//C:BoardVO 객체를 DB에 저장(insert)한다
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
		//등록된 게시물의 번호를 얻는다.
		//last_insert_id는 번호만 가져오면 되기때문에 from board등을 해줄 필요가 없음
		//방금들어간 auto increment된 번호를 리턴해준다.
		sql = "select last_insert_id() as bno";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setBno(Integer.parseInt(this.getValue("bno")));
		}
		
		this.DBClose();
	}
	
	//R:DB에서 자료를 가져와서 (select)BoardVO에 넣는다.
	//IsHit : true - 조회수증가, false - 조회수증가하지 않음.
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
			//게시물 정보가 있음.
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
			
			//조회수를 증가시킨다.
			if(IsHit == true)
			{
				sql = "update board set bhit = bhit + 1 where bno = '" + bno + "'";
				this.RunSQL(sql);
			}
		}
		
		this.DBClose();
		//게시물 정보가 없을 경우 null이 return되게 된다.
		return vo;
	}
	
	//U:BoardVO객체를 DB에 변경(update)한다.
	public void modify(BoardVO vo)
	{
		this.DBOpen();
		
		String sql = "";
		sql  = "update board set ";
		sql += "btitle = '" + _R(vo.getBtitle()) + "',";
		sql += "lockop = '" + _R(vo.getLockop()) + "',";
		if(!vo.getBfname().equals("")) 
		{
			//첨부파일이 지정되어서 업로드 된 경우에만 첨부파일 업데이트
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
	
	//U: 비밀글 설정을 해준다.
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
	
	//U: 공지글 설정을 해준다.
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
	
	//D:BoardVO객체를 이용하여 DB에서 삭제한다.
	//게시글을 삭제하고싶다면 fk로 연결된 reply부터 지워주고, 게시글을 지워야한다.
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

	//R:전체 게시물 갯수를 얻는다
	//category : I-고객 문의 게시판, R-리뷰 게시판
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
	
	//공지사항 개수를 얻는다.
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
	
	//noticeop가 설정된 경우
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
			//게시물 정보가 있음.
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
		//게시물 정보가 없을 경우 null이 return되게 된다.
		return vo;
		}
	
	//R:DB에서 자료 목록을 가져와서(select) BoardVO LIST에 넣는다.
	//category : I-고객 문의 게시판, R-리뷰 게시판
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