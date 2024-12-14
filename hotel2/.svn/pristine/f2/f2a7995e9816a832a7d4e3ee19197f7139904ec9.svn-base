//게시글의 댓글 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

public class ReplyDTO extends DBManager
{
	//C:ReplyVO 객체를 DB에 저장(insert)한다
	public void insert(ReplyVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert into reply (bno,rwriter,rnote) ";
		sql += "values ('" +  vo.getBno() + "',";
		sql += "'" + _R(vo.getRwriter()) + "',";
		sql += "'" + _R(vo.getRnote()) + "') ";
		System.out.println(sql);
		this.RunSQL(sql);
		
		//등록된 댓글의 번호를 얻는다.(auto_increment)된 번호 얻기
		sql = "select last_insert_id() as rno";
		System.out.println(sql);
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setRno(Integer.parseInt(this.getValue("rno")));
		}
		this.DBClose();
	}
		
	//R:DB에서 자료를 가져와서 (select)ReplyVO에 넣는다.
	public ReplyVO read(String rno)
	{
		ReplyVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select bno,rwriter,rnote,rwdate, ";
		sql += "(select kname from user where email = reply.rwriter) as rwriter ";
		sql += "from reply ";
		sql += "where rno = '" + rno + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			//댓글 정보가 있음.
			vo = new ReplyVO();
			vo.setRno(Integer.parseInt(rno));
			vo.setRwriter(this.getValue("rwriter"));
			vo.setRnote(this.getValue("rnote"));
			vo.setRwdate(this.getValue("rwdate"));
			vo.setName(this.getValue("name"));
		}
		
		this.DBClose();
		//게시물 정보가 없을 경우 null이 return되게 된다.
		return vo;
	}
	
	public ReplyVO rcount(int bno)
	{
		ReplyVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select rno ";
		sql += "from reply ";
		sql += "where bno = '" + bno + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			vo = new ReplyVO();
			vo.setRno(Integer.parseInt(this.getValue("rno")));
		}
		
		this.DBClose();
		
		return vo;
	}
	
	  
	//D:ReplyVO객체를 이용하여 DB에서 삭제한다.
	public void delete(String rno)
	{
		this.DBOpen();
		
		String sql = "";
		sql = "delete from reply where rno = '" + rno + "'";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	
	//R:DB에서 자료 목록을 가져와서(select) ReplyVO LIST에 넣는다.
	//해당 게시물(bno)에 달린 모든 댓글을 가져와야한다.
	public ArrayList<ReplyVO> list(String bno)
	{
		ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
		
		this.DBOpen();
		String sql = "";
		
		sql  = "select rno,bno,rwriter,rnote,date(rwdate) as rwdate, ";
		sql += "(select kname from user where email = reply.rwriter) as name ";
		sql += "from reply ";
		sql += "where bno = " + bno + " ";
		sql += "order by rno desc";
		System.out.println(sql);
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			ReplyVO vo = new ReplyVO();
			vo.setRno(Integer.parseInt(this.getValue("rno")));
			vo.setRwriter(this.getValue("rwriter"));
			vo.setRnote(this.getValue("rnote"));
			vo.setRwdate(this.getValue("rwdate"));
			vo.setName(this.getValue("name"));
			
			list.add(vo);
		}
		
		this.DBClose();
		return list;
	}
	
	
}