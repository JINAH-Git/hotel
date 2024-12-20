//회원정보 자료를 담기위한 vo(value object)클래스
/*
 * 작성일: 23.07.10.월  
 * 작성자: 김진아
 * 회원정보
 */
package hotel.vo;

public class UserVO 
{
	//필드
	protected String email;    	 //1.이메일
	protected String pw;	   	 //2.비밀번호
	protected String ename;	   	 //3.영문 이름
	protected String kname;	   	 //4.한글 이름
	protected String gender;   	 //5.성별
	protected String joindate; 	 //6.가입일자                 default now()
	protected String korf;	   	 //7.내국인/외국인
	protected String number;	 //8.전화번호
	protected String birth;	   	 //9.생년월일
	protected String level;	   	 //10.등급                     U:사용자, A:관리자
	protected String agreop;   	 //11.약관 동의여부
	protected String pwfcnt;   	 //12.비밀번호 틀린 횟수  default '0'
	protected String isremember; //13.인증여부
	protected String token;   	 //14.식별번호

	//getter와 setter
	public String getEmail()      {return email;}
	public String getPw()         {return pw;}
	public String getEname()      {return ename;}
	public String getKname()      {return kname;}
	public String getGender()     {return gender;}
	public String getJoindate()   {return joindate;}
	public String getKorf()       {return korf;}
	public String getNumber()     {return number;}
	public String getBirth()      {return birth;}
	public String getLevel()      {return level;}
	public String getAgreop()     {return agreop;}
	public String getPwfcnt()     {return pwfcnt;}
	public String getIsremember() {return isremember;}
	public String getToken()      {return token;}



	public void setEmail(String email)       	 {this.email = email;}
	public void setPw(String pw)             	 {this.pw = pw;}
	public void setEname(String ename)       	 {this.ename = ename;}
	public void setKname(String kname)       	 {this.kname = kname;}
	public void setGender(String gender)     	 {this.gender = gender;}
	public void setJoindate(String joindate) 	 {this.joindate = joindate;}
	public void setKorf(String korf)        	 {this.korf = korf;}
	public void setNumber(String number)       	 {this.number = number;}
	public void setBirth(String birth)       	 {this.birth = birth;}
	public void setLevel(String level)       	 {this.level = level;}
	public void setAgreop(String agreop)     	 {this.agreop = agreop;}
	public void setPwfcnt(String pwfcnt)     	 {this.pwfcnt = pwfcnt;}
	public void setIsremember(String isremember) {this.isremember = isremember;}
	public void setToken(String token) 			 {this.token = token;}



	public UserVO()
	{
		
	}
}


