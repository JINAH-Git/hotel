//댓글 정보 자료를 담기위한 vo(value object)클래스
package hotel.vo;

public class ReplyVO 
{
	protected int	 rno;	   //댓글번호
	protected String rwriter;  //작성자
	protected String rnote;    //내용
	protected String rwdate;   //댓글 작성일
	protected int	 bno;      //게시글 번호
	protected String name;     //작성자 이름
	
	
	public int	  getRno()     {	return rno;	    }
	public String getRwriter() {	return rwriter;	}
	public String getRnote()   {	return rnote;	}
	public String getRwdate()  {	return rwdate;	}
	public int	  getBno()     {	return bno;	    }
	public String getName()    {	return name;	}

	public void setRno(int rno)            {	this.rno = rno;	        }
	public void setRwriter(String rwriter) {	this.rwriter = rwriter;	}
	public void setRnote(String rnote)     {	this.rnote = rnote;		}
	public void setRwdate(String rwdate)   {	this.rwdate = rwdate;	}
	public void setBno(int bno)            {	this.bno = bno;			}
	public void setName(String name)       {	this.name = name;	    }
	
	public ReplyVO()
	{
		
	}
}
