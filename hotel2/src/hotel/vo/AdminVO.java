//관리자 게시판 정보 자료를 담기위한 vo(value object)클래스
package hotel.vo;

public class AdminVO 
{
	protected int    ano;		 //관리자 게시글 번호
	protected String atitle;	 //제목
	protected String anote;		 //내용
	protected String awdate;     //작성일
	protected String afname;	 //첨부파일_논리명
	protected String apname;	 //첨부파일_물리명
	protected String ahit;		 //조회수
	protected String acategory;  //게시판 구분
	protected String email;      //이메일
	protected String name;	     //이름
	protected String level;      //등급   U:사용자,  A:관리자
	
	public int	  getAno() 		 {	return ano;		  }
	public String getAtitle()    {	return atitle;	  }
	public String getAnote()     {	return anote;	  }
	public String getAwdate()    {	return awdate;    }
	public String getAfname()    {	return afname;	  }
	public String getApname()    {	return apname;	  }
	public String getAhit()      {	return ahit;	  }
	public String getAcategory() {	return acategory; }
	public String getEmail()     {	return email;     }
	public String getName()      {	return name;	  }
	public String getLevel()     {  return level;	  }
	
	public void setAno(int ano) 			   {	this.ano = ano;				}
	public void setAtitle(String atitle) 	   {	this.atitle = atitle;		}
	public void setAnote(String anote) 		   {	this.anote = anote;			}
	public void setAwdate(String awdate)	   {	this.awdate = awdate; 		}
	public void setAfname(String afname) 	   {	this.afname = afname;		}
	public void setApname(String apname) 	   {	this.apname = apname;		}
	public void setAhit(String ahit) 		   {	this.ahit = ahit;	  		}
	public void setAcategory(String acategory) {	this.acategory = acategory; }
	public void setEmail(String email)	  	   {	this.email = email; 		}
	public void setName(String name) 		   {	this.name = name;		    }
	public void setLevel(String level)         {    this.level = level; 	    }
	
	public AdminVO()
	{
		
	}
	
}
