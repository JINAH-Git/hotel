//ȸ������ �ڷḦ ������� vo(value object)Ŭ����
/*
 * �ۼ���: 23.07.10.��  
 * �ۼ���: ������
 * ȸ������
 */
package hotel.vo;

public class UserVO 
{
	//�ʵ�
	protected String email;    	 //1.�̸���
	protected String pw;	   	 //2.��й�ȣ
	protected String ename;	   	 //3.���� �̸�
	protected String kname;	   	 //4.�ѱ� �̸�
	protected String gender;   	 //5.����
	protected String joindate; 	 //6.��������                 default now()
	protected String korf;	   	 //7.������/�ܱ���
	protected String number;	 //8.��ȭ��ȣ
	protected String birth;	   	 //9.�������
	protected String level;	   	 //10.���                     U:�����, A:������
	protected String agreop;   	 //11.��� ���ǿ���
	protected String pwfcnt;   	 //12.��й�ȣ Ʋ�� Ƚ��  default '0'
	protected String isremember; //13.��������
	protected String token;   	 //14.�ĺ���ȣ

	//getter�� setter
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

