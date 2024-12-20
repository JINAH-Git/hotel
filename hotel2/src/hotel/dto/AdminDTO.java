//관리자 게시판 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

public class AdminDTO extends DBManager
{
		//C:BoardVO 객체를 DB에 저장(insert)한다
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
			
			//등록된 게시물의 번호를 얻는다.
			//last_insert_id는 번호만 가져오면 되기때문에 from board등을 해줄 필요가 없음!!!!
			//방금들어간 auto increment된 번호를 리턴해준다.
			sql = "select last_insert_id() as ano";
			System.out.println(sql);
			this.RunSelect(sql);
			if(this.Next() == true)
			{
				vo.setAno(Integer.parseInt(this.getValue("ano")));
			}
			
			this.DBClose();
		}
		
		//R:DB에서 자료를 가져와서 (select)BoardVO에 넣는다.
		//IsHit : true - 조회수증가, false - 조회수증가하지 않음.
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
				//게시물 정보가 있음.
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
				
				//조회수를 증가시킨다.
				if(IsHit == true)
				{
					sql = "update admin set ahit = ahit + 1 where ano = '" + ano + "'";
					this.RunSQL(sql);
				}
			}
			
			this.DBClose();
			//게시물 정보가 없을 경우 null이 return되게 된다.
			return vo;
		}
		
		//U:BoardVO객체를 DB에 변경(update)한다.
		public void modify(AdminVO vo)
		{
			this.DBOpen();
			
			String sql = "";
			sql  = "update admin set ";
			sql += "atitle = '" + _R(vo.getAtitle()) + "',";
			if(!vo.getAfname().equals("")) 
			{
				//첨부파일이 지정되어서 업로드 된 경우에만 첨부파일 업데이트
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
		
		//U:BoardVO객체를 DB에 변경(update)한다.
		//자주 묻는 질문 데이터를 수정합니다.
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
		
		//D:BoardVO객체를 이용하여 DB에서 삭제한다.
		//관리자 게시판에는 reply가 없으므로 게시판 삭제만 만들었습니다.
		public void delete(String ano)
		{
			this.DBOpen();
			String sql = "";
			
			sql = "delete from admin where ano = '" + ano + "'";
			System.out.println(sql);
			this.RunSQL(sql);
			
			this.DBClose();
		}
		
		//R:전체 게시물 갯수를 얻는다
		//acategory : T-객실 소개, F-부대시설, N-공지사항, Q-자주 묻는 질문, E-이벤트
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
		
		//R:DB에서 자료 목록을 가져와서(select) BoardVO LIST에 넣는다.
		//acategory : T-객실 소개, F-부대시설, N-공지사항, Q-자주 묻는 질문, E-이벤트
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
