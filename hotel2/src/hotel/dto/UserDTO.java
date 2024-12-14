//ȸ�� ������ ��(Model)�� ���� ó���ϱ� ���� DTOŬ����(Data Transfer Object)
/*
 * �ۼ���: 23.07.10.�� 
 * �ۼ���: ������
 * 
 */
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

//�� �޼ҵ忡�� DBManager�� ����ϰ� ����. ���� DBManager�� ����Ͽ� ����ϴ°� �����ϴ�.
public class UserDTO extends DBManager
{
	//ȸ������(User)
	
	//c: insert
	//UserVO��ü�� �̿��Ͽ� ȸ�������� �Ѵ�.Join()(ȸ������)
	//true: �ߺ��� �̸����� ����. false: �ߺ��� �̸����� �ִ�.
	public boolean join(UserVO user)
	{
		//�ߺ��� �̸����� ���� ��
		if(this.isduplicate(user.getEmail()) == true)
		{
			System.out.println("�ߺ��� ���̵�[" + _R(user.getEmail()) + "] �Դϴ�.");
			return false; //false�� ���δ�. true�� �츰��.
		}
		//�ߺ��� �̸����� ���� ��(default ���� ����)
		this.DBOpen();
		String sql = "";
		sql = "insert into user(email,pw,ename,kname,gender,korf,number,birth,agreop,token) ";
		sql += "values ";
		sql += "('" + _R(user.getEmail()) + "', ";
		sql += "md5('" + _R(user.getPw()) + "'), ";
		sql += "'" + _R(user.getEname()) + "',  ";
		sql += "'" + _R(user.getKname()) + "', ";
		sql += "'" + _R(user.getGender()) + "', ";
		sql += "'" + _R(user.getKorf()) + "', ";
		sql += "'" + _R(user.getNumber()) + "', ";
		sql += "'" + _R(user.getBirth()) + "', "; 
		sql += "'" + _R(user.getAgreop()) + "', ";
		sql += "'" + _R(user.getToken()) + "')";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
		return true;
		
	}
	

	//r : select
	//read()(ȸ�� ���� ��ȸ)
	public UserVO read(String email)
	{	
		UserVO user = new UserVO();
		this.DBOpen();
		String sql = "";
		sql  = "select email,ename,kname,gender,joindate,korf,number,birth,level ";
		sql += "from user ";
		sql += "where email = '" + email + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			user.setEmail(this.getValue("email"));
			user.setEname(this.getValue("ename"));
			user.setKname(this.getValue("kname"));
			user.setGender(this.getValue("gender"));
			user.setJoindate(this.getValue("joindate"));
			user.setKorf(this.getValue("korf"));
			user.setNumber(this.getValue("number"));
			user.setBirth(this.getValue("birth"));
			user.setLevel(this.getValue("level"));
		}
		this.DBClose();
		
		return user;
	}
	
	//isduplicate()(�̸��� �ߺ� �˻�)
	//true: �ߺ�, false: �ߺ� �ƴ� 
	public boolean isduplicate(String email)
	{
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select email from user where email = '" + _R(email) + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		//�ߺ��� email�� ����
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
		
	//login()(�α��� �ϱ�), ��й�ȣ Ʋ�� Ƚ�� �ʱ�ȭ, ��й�ȣ Ʋ�� Ƚ�� ������Ʈ �־��ֱ�
	//return �� true: �α��� ����, false: �α��� ����, fail:��й�ȣ 5ȸ �̻� Ʋ��
	public String login(String email, String pw)
	{
		String islogin = "false";
		this.DBOpen();
		
		String sql = "";
		sql = "select email ";
		sql += "from user ";
		sql += "where email = '" + _R(email) + "' ";
		sql += "and pw = md5('" + _R(pw) + "') ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
				if(this.loginfail(email) == true)
				{
					//�α��� ����,��й�ȣ Ʋ��Ƚ�� �ʱ�ȭ
					islogin = "true";
					this.pwfreset(email);
					this.DBClose();
					return islogin;	
				}else if(this.loginfail(email) == false)
				{
					//�α��� ����������,��й�ȣ 5ȸ�̻� Ʋ��,�α��� �Ұ�
					islogin = "fail";
					this.DBClose();
					return islogin;	
				}
		}else
		{
			if(this.loginfail(email) == true)
			{
				//�α��� ����,��й�ȣ Ʋ��Ƚ�� ����
				islogin = "false";
				this.pwfcount(email);
				this.DBClose();
				return islogin;	
			}else if(this.loginfail(email) == false);
			{
				//�α��� ����, ��й�ȣ 5�� �̻� Ʋ��
				islogin = "fail";
				this.DBClose();
				return islogin;	
			}
		}
		this.DBClose();
		return islogin;	
	}
	
	
	//��й�ȣ 5ȸ ����ġ�� �α��� �Ұ�
	//true-��й�ȣ 5ȸ�̸� Ʋ�� false-��й�ȣ 5ȸ �̻� Ʋ��
	public boolean loginfail(String email)
	{
		boolean flag = true;
		int pwfcnt = 0;
		
		this.DBOpen();
		String sql = "";
		sql = "select pwfcnt from user where email = '"+ email + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			pwfcnt = Integer.parseInt(this.getValue("pwfcnt"));
			
			if(pwfcnt >= 4)
			{
				flag = false;
			}else
			{
				flag = true;
			}
		}
		this.DBClose();
		return flag;
	}
	
	//list()(ȸ�� ������ ����� �������� - ��ü ����¡)
	public ArrayList<UserVO> list(int PageNo)
	{
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		
		int startNo = (PageNo - 1) * 10;  //���� ��ȣ
		
		this.DBOpen();
		String sql = "";
		sql = "select email,ename,kname,birth,gender,korf,number,date(joindate) as joindate ";
		sql += "from user ";
		sql += "where level = 'U' ";
		sql += "order by joindate desc ";
		sql += "limit " + startNo + ",10";
		System.out.println(sql);
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			UserVO user = new UserVO();
			user.setEmail(this.getValue("email"));
			user.setEname(this.getValue("ename"));
			user.setKname(this.getValue("kname"));
			user.setBirth(this.getValue("birth"));
			user.setGender(this.getValue("gender"));
			user.setKorf(this.getValue("korf"));
			user.setNumber(this.getValue("number"));
			user.setJoindate(this.getValue("joindate"));
			
			//�迭�� ���� ����
			list.add(user);
		}
			this.DBClose();
			return list;
		
	}
	
	
	//list()(ȸ�� ������ ����� �������� - �˻�â)
	public ArrayList<UserVO> list(int PageNo,String option, String search)
	{
		ArrayList<UserVO> list = new ArrayList<UserVO>();

		int startNo = (PageNo - 1) * 10;  //���� ��ȣ
		
		this.DBOpen();
		String sql = "";
		sql = "select email,ename,kname,birth,gender,korf,number,date(joindate) as joindate ";
		sql += "from user ";
		sql += "where " + option + " like '%" + search + "%' ";
		sql += "and level = 'U' ";
		sql += "order by joindate desc ";
		sql += "limit " + startNo + ",10";
		
		System.out.println(sql);
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			UserVO user = new UserVO();
			user.setEmail(this.getValue("email"));
			user.setEname(this.getValue("ename"));
			user.setKname(this.getValue("kname"));
			user.setBirth(this.getValue("birth"));
			user.setGender(this.getValue("gender"));
			user.setKorf(this.getValue("korf"));
			user.setNumber(this.getValue("number"));
			user.setJoindate(this.getValue("joindate"));
			
			//�迭�� ���� ����
			list.add(user);
		}
			this.DBClose();
			return list;
	}
	
	//gettotal()(��ü ȸ������ ����)
	public int gettotal()
	{
		int total = 0;
		this.DBOpen();
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from user ";
		sql += "where level = 'U' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		this.DBClose();
		return total;
	}
	
	//gettotal()(��ü ȸ������ ���� - �˻�â)
	public int gettotal(String option,String search)
	{
		int total = 0;
		this.DBOpen();
		String sql = "";
		sql = "select count(*) as total ";
		sql += "from user ";
		sql += "where " + option + " like '%" + search + "%' ";
		sql += "and level = 'U' ";
		System.out.println(sql);
		this.RunSelect(sql);
		
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		this.DBClose();
		return total;
	}

	//u : update
	//modify()(ȸ�� ���� ����)
	public void modify(UserVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql = "update user ";
		sql += "set ename = '" + _R(vo.getEname()) + "' ,";
		sql += "kname = '" + _R(vo.getKname()) + "' ,";
		sql += "number = '" + _R(vo.getNumber()) + "' ";
		sql += "where email = '"+ _R(vo.getEmail())+ "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	
	//��й�ȣ ã�� ���� ����/�̸��� ��ġ Ȯ��
	public boolean pwcheck(String birth, String email)
	{
		boolean isuser = false;
		this.DBOpen();
		
		String sql = "";
		sql  = "select email ";
		sql += "from user ";
		sql += "where birth = '" + birth + "' ";
		sql += "and email = '" + _R(email) + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			//���� ����
			System.out.println("[" + _R(email) + "]�� ���� ����");
			isuser = true;
		}else
		{
			//���� ����
			System.out.println("[" + _R(email) + "]�� ���� ����...");
		}
		this.DBClose();
		return isuser;	
	}
	
	//pwchange()(��й�ȣ ����)
	public void pwchange(UserVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "update user ";
		sql += "set pw = md5('" + _R(vo.getPw()) + "') ";
		sql += "where email = '" + _R(vo.getEmail()) + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	//�α��� �������� ��
	//pwfreset()(��й�ȣ Ʋ�� Ƚ�� �ʱ�ȭ)
	public void pwfreset(String email)
	{
		
		this.DBOpen();
		String sql = "";
		sql = "update user set ";
		sql += "pwfcnt = '0' ";
		sql += "where email = '" + _R(email) + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		
	}
	
	//pwfcheck()(��й�ȣ Ʋ�� Ƚ�� ��ȸ) => �ʿ� ���� �� ��?
		
	//�α��� �������� ��
	//pwfcount()(��й�ȣ Ʋ�� Ƚ�� ������Ʈ)
	/*
	public void pwfcount(UserVO user)
	{
		this.DBOpen();
		String sql = "";
		sql = "update user set ";
		sql += "pwfcnt = pwfcnt + 1 ";
		sql += "where email = '"+ _R(user.getEmail()) + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		if(Integer.parseInt(user.getPwfcnt()) >= 5)
		{
			
			this.DBClose();
			return;
		}
		
		this.DBClose();
		return;
	}
	*/
	//��й�ȣ ����ġ�� ī��Ʈ ����
	public void pwfcount(String email)
	{
		this.DBOpen();
		String sql = "";
		sql = "update user set ";
		sql += "pwfcnt = pwfcnt + 1 ";
		sql += "where email = '"+ email + "' ";
		System.out.println(sql);
		this.RunSQL(sql);
		
		this.DBClose();
	}
	
}