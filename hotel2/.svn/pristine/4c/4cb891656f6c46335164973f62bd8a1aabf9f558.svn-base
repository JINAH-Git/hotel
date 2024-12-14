/* 달력(calendar)에 관한 js */

var today = new Date(); //오늘 날짜

//예약일을 담을 배열 생성
var resvdata = [];

//오늘 날짜 구하기(달력이 이동하면 new Date()함수를 써서 today값이 변하기 때문에 변하지 않는 고정값을 따로 구한다.)
ty = today.getFullYear();
tm = ( 1 + today.getMonth() );
td = today.getDate();
tm = tm >= 10 ? tm : '0' + tm; 	//1~9월은 앞에 0을 붙여준다.
td = td >= 10 ? td : '0' + td; //1~9일은 앞에 0을 붙여준다.
//오늘 날짜를 담을 배열 생성
var realtoday = ty + tm + td;

function buildCalendar()
{		
	//달력1 설정
	var row = null;
	var cnt = 0;
	var calendarTable = document.getElementById("calendar");
	var calendarTableTitle = document.getElementById("calendarTitle");
	calendarTableTitle.innerHTML = today.getFullYear()+"년 "+(today.getMonth()+1)+"월";

	//이번 달의 첫째 날과 마지막 날을 구한다.
	var firstDate = new Date(today.getFullYear(), today.getMonth(), 1);
	var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0);

	while(calendarTable.rows.length > 2)
	{
		calendarTable.deleteRow(calendarTable.rows.length -1);
	}

	//이번 달의 첫째 날의 요일을 구해서 시작점을 잡는다.
	row = calendarTable.insertRow();
	for(i = 0; i < firstDate.getDay(); i++)
	{
		cell = row.insertCell();
		cnt += 1;
	}
	
	//오늘 날짜 구하기
	y = today.getFullYear();
	m = ( 1 + today.getMonth() );
	d = today.getDate();
	m = m >= 10 ? m : '0' + m; 	//1~9월은 앞에 0을 붙여준다.
	d = d >= 10 ? d : '0' + d; //1~9일은 앞에 0을 붙여준다.
	ymd = y + "-" + m + "-" + d; //오늘 날짜를 8자리 형식으로 구한다.
	if($("#checkin").val() == 0 || $("#checkin").val() == "null")
	{
		$("#checkin").val(ymd);
	}
	
	//달력이 이동해도 변하지 않는 오늘 날짜구하기
	
	//내일 날짜 구하기
	var tmr = new Date(today.setDate(today.getDate()+1));
	tmry = today.getFullYear();
	tmrm = ( 1 + today.getMonth() );
	tmrd = today.getDate();
	tmrm = tmrm >= 10 ? tmrm : '0' + tmrm; 	//1~9월은 앞에 0을 붙여준다.
	tmrd = tmrd >= 10 ? tmrd : '0' + tmrd; //1~9일은 앞에 0을 붙여준다.
	tmrymd = tmry + "-" + tmrm + "-" + tmrd; //오늘 날짜를 8자리 형식으로 구한다.
	if($("#checkout").val() == 0 || $("#checkout").val() == "null")
	{
		$("#checkout").val(tmrymd);
	}
	
	//이번 달의 마지막날까지 숫자를 집어넣는다.
	row1 = calendarTable.insertRow();
	for(i = 1; i <= lastDate.getDate(); i++)
	{
		cell = row.insertCell();
		cnt += 1;		
		
		i = i >= 10 ? i : '0' + i; //1~9일은 앞에 0을 붙여준다.
		/* id는 값이 다르기 때문에 for문의 i를 넣는 것이고 오늘 날짜 getDate()로 따로 구해야한다. */

		ymi = y + "-" + m + "-" +  i; //클릭한 셀의 id에 넣을 날짜 형식 ex)20001122 8자리로 나오게 만든다.
		
		//셀의 형식
		cell.setAttribute('id',ymi); //ymi를 넣어야 id가 각각 다르게 나온다.
		cell.innerHTML = i;
		cell.style.textAlign = 'center';
		cell.style.width = '50px';
		cell.style.height = '50px';
		
		cellid = cell.getAttribute('id');
		//일요일은 빨간 색
	    if (cnt % 7 == 1) 
	    {
	    	cell.innerHTML = "<font color=red>" + i + "</font>";
	    }
	
	    //토요일은 파란 색
	    if (cnt % 7 == 0)
	    {
	    	cell.innerHTML = "<font color=blue>" + i + "</font>";
	    	row = calendar.insertRow();
	    }	
	    
	    cellfmt = cell.getAttribute('id').replaceAll("-","");
	    //오늘 이전 날짜 흑백 처리
		if(cellfmt < realtoday)
		{
			cell.setAttribute('class','other');
		}
		
	    //오늘 날짜 표시
		if(cellfmt == realtoday) //셀의 id가 오늘의 날짜와 같을 때
		{
			cell.innerHTML = '오늘';
			cell.style.background = 'brown';
		}		
		cellclick();
	}
	/* 이번 달 테이블에 셀 넣는 반복문 끝나는 부분*/

	
	//달력2 설정	
	nextmonth = new Date(today.getFullYear(),today.getMonth()+1,today.getDate()); //오늘 날짜에서 월만 다음 월로 변환
	
	row = null;
	cnt = 0;
	var calendarTable2 = document.getElementById("calendar2");
	var calendarTableTitle2 = document.getElementById("calendarTitle2");
	calendarTableTitle2.innerHTML = nextmonth.getFullYear()+"년 "+(nextmonth.getMonth()+1)+"월";

	//다음 달의 첫째 날과 마지막 날을 구한다.
	firstDate = new Date(nextmonth.getFullYear(), nextmonth.getMonth(), 1);
	lastDate = new Date(nextmonth.getFullYear(), nextmonth.getMonth()+1, 0);
		
	while(calendarTable2.rows.length > 2)
	{
		calendarTable2.deleteRow(calendarTable2.rows.length -1);
	}
		
	//다음 달의 첫째 날의 요일을 구해서 시작점을 잡는다.
	row = calendarTable2.insertRow();
	for(i = 0; i < firstDate.getDay(); i++)
	{
		cell = row.insertCell();
		cnt += 1;		
	}	
	//다음 달의 마지막날까지 숫자를 집어넣는다.
	row1 = calendarTable2.insertRow();
	for(i = 1; i <= lastDate.getDate(); i++)
	{
		cell = row.insertCell();
		cnt += 1;		
		
		y = nextmonth.getFullYear();
		m = ( 1 + nextmonth.getMonth() );
		m = m >= 10 ? m : '0' + m; //1~9월은 앞에 0을 붙여준다.
		i = i >= 10 ? i : '0' + i; //1~9일은 앞에 0을 붙여준다.
		
		ymi = y + "-" + m + "-" +  i; //클릭한 셀의 id에 넣을 날짜 형식 ex)20001122 8자리로 나오게 만든다.
			
		//셀의 형식
		cell.setAttribute('id',ymi); //ymi를 넣어야 id가 각각 다르게 나온다.
		cell.innerHTML = i;
		cell.style.textAlign = 'center';
		cell.style.width = '50px';
		cell.style.height = '50px';
		
		cellid2 = cell.getAttribute('id');
		//일요일은 빨간 색
		if (cnt % 7 == 1) 
		{
			cell.innerHTML = "<font color=red>" + i + "</font>";
		}
		
		//토요일은 파란 색
		if (cnt % 7 == 0)
		{
			cell.innerHTML = "<font color=blue>" + i + "</font>";
			row = calendar2.insertRow();
		}	
		
		cellfmt = cell.getAttribute('id').replaceAll("-","");
		
		 //오늘 이전 날짜 흑백 처리
		if(cellfmt < realtoday)
		{
			cell.setAttribute('class','other');
		}
		
	    //오늘 날짜 표시
		if(cellfmt == realtoday) //셀의 id가 오늘의 날짜와 같을 때
		{
			cell.innerHTML = '오늘';
			cell.style.background = 'brown';
		}		
		cellclick();
	}
	/* 테이블에 셀 넣는 반복문 끝나는 부분*/
}

function cellclick()
{
	//클릭한 셀은 배경색이 바뀌게한다.(클래스 추가)
    //클릭한 셀의 날짜를 구하고 처음 클릭한 날짜는 체크인에 담고 두번째 클릭한 날짜는 체크아웃에 담는다.
    cell.onclick = function()
	{
		//오늘 이전의 날짜에 체크인을 하려 할 때 
		if(this.getAttribute('id').replaceAll("-","") < realtoday.replaceAll("-",""))
		{
			return;
		//오늘이후의 날짜에 체크인을 할때
		}else
		{
			//예약정보 배열에 아무 데이터도 없을 때
			if(resvdata.length == 0) 
			{ 					
				//체크인 완료
		  		document.getElementById(this.getAttribute('id')).classList.add('checkin');
		  		$(".checkin").html("in");
		  		$("#checkin").val(this.getAttribute('id'));
		  		resvdata.push(this.getAttribute('id'));//예약정보 배열에 체크인 담기
			}
			//예약정보 배열에 체크인 정보가 있을 때
		  	else 
		  	{    
		  		//예약 정보 배열에 체크아웃정보(resvdata[1])가 담겨있다면
				if(resvdata[1] != null)
				{
					if($("#checkin").val().replaceAll("-","") == realtoday)
					{
						$(".checkin").html("오늘");						
					}else
					{
						$(".checkin").html(resvdata[0].slice(-2));						
					}
					$(".checkout").html(resvdata[1].slice(-2));
					$('td').removeClass('checkin'); //클래스 체크인 지우기
					$('td').removeClass('checkout'); //클래스 체크아웃 지우기
					$('td').removeClass('period'); //클래스 period(체크인날짜 ~ 체크아웃날짜 사이) 지우기
					resvdata = [];	//배열에 담긴 체크인,체크아웃 날짜 지우기
					
					//체크인 완료
			  		document.getElementById(this.getAttribute('id')).classList.add('checkin');
			  		$(".checkin").html("in");
			  		$("#checkin").val(this.getAttribute('id'));
			  		resvdata.push(this.getAttribute('id'));				
					return;
				}else
				{	
					//체크아웃 날짜가 체크인 날짜 이전인 경우
					if($("#checkin").val() >= this.getAttribute('id'))
					{
						return;
					}else
					{
						$("#checkout").val(this.getAttribute('id'));
						//예약 기간이 30일이 넘을 때 
						if(getDateDiff($("#checkout").val(),$("#checkin").val()) > 30)
						{
							alert("예약 일수는 30일을 초과할 수 없습니다.");
							$("#checkout").val(tmrymd);
							return;
						}else
						{
							//체크아웃 완료
							document.getElementById(this.getAttribute('id')).classList.add('checkout');
							$(".checkout").html("out");
							resvdata.push(this.getAttribute('id'));
							//몇 박인지 계산
							night = getDateDiff($("#checkout").val(),$("#checkin").val()) + "박";							
							$("#night").val(night);
							//체크인 날짜와 체크아웃 날짜 사이의 날짜를 배열로 확인
							result = getDatesStartToLast($("#checkin").val(),$("#checkout").val());
							for(i = 1; i < result.length-1; i++)
							{
								document.getElementById(result[i]).classList.add('period');
							}
							//체크아웃까지 완료되면 달력을 닫는다.
							$("#date").css('display','none');			
						}
					}
				}
		  	}	
		}
	}	
    /* 버튼 끝나는 부분*/
}


//날짜와 날짜 사이의 일 수 계산
const getDateDiff = (d1, d2) => {
	const date1 = new Date(d1);
	const date2 = new Date(d2);
  
	const diffDate = date1.getTime() - date2.getTime();
  
	return Math.abs(diffDate / (1000 * 60 * 60 * 24)); // 밀리세컨 * 초 * 분 * 시 = 일
}

//이전 버튼을 클릭하면 이전 달과 이번 달을 보여준다.
function prevCalendar()
{
	today = new Date(today.getFullYear(),today.getMonth()-1,today.getDate());
	buildCalendar();
	if(resvdata[0] != null) //예약정보 배열에 체크인 날짜가 담겨있으면 달력이 이동해도 화면에 남는다.
	{
		if(document.getElementById(resvdata[0]) != null) //화면에 나오는 테이블에 체크인id가 있을때
		{
			document.getElementById(resvdata[0]).classList.add('checkin');
			$(".checkin").html("in");			
		}
	}
	if(resvdata[1] != null) //예약정보 배열에 체크아웃 날짜가 담겨있으면 달력이 이동해도 화면에 남는다.
	{
		if(document.getElementById(resvdata[1]) != null) //화면에 나오는 테이블에 체크아웃 id가 있을때
		{
			document.getElementById(resvdata[1]).classList.add('checkout');
			$(".checkout").html("out");
		}
		if(result != null)
		{
			for(i = 1; i < result.length-1; i++)
			{
				document.getElementById(result[i])
				if(document.getElementById(result[i]) != null)
				{
					document.getElementById(result[i]).classList.add('period');					
				}
			}
		}
	}
}

//다음 버튼을 클릭하면 다음 달과 다다음 달을 보여준다.
function nextCalendar()
{
	today = new Date(today.getFullYear(),today.getMonth()+1,today.getDate());
	buildCalendar();
	if(resvdata[0] != null) //예약정보 배열에 체크인 날짜가 담겨있으면 달력이 이동해도 화면에 남는다.
	{
		if(document.getElementById(resvdata[0]) != null) //화면에 나오는 테이블에 체크인id가 있을때
		{
			document.getElementById(resvdata[0]).classList.add('checkin');
			$(".checkin").html("in");			
		}
	}
	if(resvdata[1] != null) //예약정보 배열에 체크아웃 날짜가 담겨있으면 달력이 이동해도 화면에 남는다.
	{
		if(document.getElementById(resvdata[1]) != null) //화면에 나오는 테이블에 체크아웃 id가 있을때
		{
			document.getElementById(resvdata[1]).classList.add('checkout');
			$(".checkout").html("out");
		}
		if(result != null)
		{
			for(i = 1; i < result.length-1; i++)
			{
				document.getElementById(result[i])
				if(document.getElementById(result[i]) != null)
				{
					document.getElementById(result[i]).classList.add('period');					
				}
			}
		}
	}
}

//날짜와 날짜사이에 모든 날짜 배열에 담기
function getDatesStartToLast(startDate, lastDate) 
{
	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
	if(!(regex.test(startDate) && regex.test(lastDate))) return "Not Date Format";
	var result = [];
	var curDate = new Date(startDate);
	while(curDate <= new Date(lastDate)) 
	{
		result.push(curDate.toISOString().split("T")[0]);
		curDate.setDate(curDate.getDate() + 1);
	}
	return result;
}