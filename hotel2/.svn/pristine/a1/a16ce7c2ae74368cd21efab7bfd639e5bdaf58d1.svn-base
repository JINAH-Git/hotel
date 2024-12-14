//회원 정보를 모델(Model)로 부터 처리하기 위한 DTO클래스(Data Transfer Object)
/*
 * 작성일: 23.07.10.월 
 * 작성자: 김진아
 * 
 */
package hotel.dto;

import java.util.ArrayList;

import hotel.dao.*;
import hotel.vo.*;

//각 메소드에서 DBManager를 사용하고 있음. 따라서 DBManager를 상속하여 사용하는게 간편하다.
public class UserDTO extends DBManager
{
	//회원가입(User)
	
	//c: insert
	//UserVO객체를 이용하여 회원가입을 한다.Join()(회원가입)
	//true: 중복된 이메일이 없다. false: 중복된 이메일이 있다.
	public boolean join(UserVO user)
	{
		//중복된 이메일이 있을 때
		if(this.isduplicate(user.getEmail()) == true)
		{
			System.out.println("중복된 아이디[" + _R(user.getEmail()) + "] 입니다.");
			return false; //false는 죽인다. true는 살린다.
		}
		//중복된 이메일이 없을 때(default 값은 제외)
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
	//read()(회원 정보 조회)
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
	
	//isduplicate()(이메일 중복 검사)
	//true: 중복, false: 중복 아님 
	public boolean isduplicate(String email)
	{
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select email from user where email = '" + _R(email) + "' ";
		System.out.println(sql);
		this.RunSelect(sql);
		//중복된 email이 존재
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
		
	//login()(로그인 하기), 비밀번호 틀린 횟수 초기화, 비밀번호 틀린 횟수 업데이트 넣어주기
	//return 값 true: 로그인 성공, false: 로그인 실패, fail:비밀번호 5회 이상 틀림
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
					//로그인 성공,비밀번호 틀린횟수 초기화
					islogin = "true";
					this.pwfreset(email);
					this.DBClose();
					return islogin;	
				}else if(this.loginfail(email) == false)
				{
					//로그인 성공했으나,비밀번호 5회이상 틀림,로그인 불가
					islogin = "fail";
					this.DBClose();
					return islogin;	
				}
		}else
		{
			if(this.loginfail(email) == true)
			{
				//로그인 실패,비밀번호 틀린횟수 증가
				islogin = "false";
				this.pwfcount(email);
				this.DBClose();
				return islogin;	
			}else if(this.loginfail(email) == false);
			{
				//로그인 실패, 비밀번호 5번 이상 틀림
				islogin = "fail";
				this.DBClose();
				return islogin;	
			}
		}
		this.DBClose();
		return islogin;	
	}
	
	
	//비밀번호 5회 불일치시 로그인 불가
	//true-비밀번호 5회미만 틀림 false-비밀번호 5회 이상 틀림
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
	
	//list()(회원 정보를 목록을 가져오기 - 전체 페이징)
	public ArrayList<UserVO> list(int PageNo)
	{
		ArrayList<UserVO> list = new ArrayList<UserVO>();
		
		int startNo = (PageNo - 1) * 10;  //시작 번호
		
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
			
			//배열로 값을 저장
			list.add(user);
		}
			this.DBClose();
			return list;
		
	}
	
	
	//list()(회원 정보를 목록을 가져오기 - 검색창)
	public ArrayList<UserVO> list(int PageNo,String option, String search)
	{
		ArrayList<UserVO> list = new ArrayList<UserVO>();

		int startNo = (PageNo - 1) * 10;  //시작 번호
		
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
			
			//배열로 값을 저장
			list.add(user);
		}
			this.DBClose();
			return list;
	}
	
	//gettotal()(전체 회원정보 개수)
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
	
	//gettotal()(전체 회원정보 개수 - 검색창)
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
	//modify()(회원 정보 수정)
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
	
	//비밀번호 찾기 위한 생일/이메일 일치 확인
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
			//인증 성공
			System.out.println("[" + _R(email) + "]로 인증 성공");
			isuser = true;
		}else
		{
			//인증 실패
			System.out.println("[" + _R(email) + "]로 인증 실패...");
		}
		this.DBClose();
		return isuser;	
	}
	
	//pwchange()(비밀번호 변경)
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
	//로그인 성공했을 때
	//pwfreset()(비밀번호 틀린 횟수 초기화)
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
	
	//pwfcheck()(비밀번호 틀린 횟수 조회) => 필요 없을 거 같?
		
	//로그인 실패했을 때
	//pwfcount()(비밀번호 틀린 횟수 업데이트)
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
	//비밀번호 불일치시 카운트 증가
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
