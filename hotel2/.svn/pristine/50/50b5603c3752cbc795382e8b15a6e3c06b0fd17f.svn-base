/* 검색 옵션을 관리하는 js */


//객식목록 이벤트
function viewroom()
{
	/* 주소창에 넘어온 값이 있으면 읽어서 객실목록을 화면에 뿌려준다.*/
	var room  = $(".contents");
	const urlParams = new URL(location.href).searchParams;		
	const adult = urlParams.get('adult');
	const child = urlParams.get('child');
	const kid = urlParams.get('kid');
	const checkin = urlParams.get('checkin');
	const checkout = urlParams.get('checkout');
	
	if(checkin != null)
	{
		//체크인 완료
		document.getElementById(checkin).classList.add('checkin');
		$(".checkin").html("in");		
	}
	if(checkout != null)
	{
		//체크아웃 완료
		document.getElementById(checkout).classList.add('checkout');
		$(".checkout").html("out");		
	}
	
	if(adult != null)
	{
		switch(adult)
		{
		case adult:
			for(i = adult - 1; i < room.length; i++)
			{
				room[i].style.display = 'block';
			}
			break;
		};		
	}
}

//클릭 이벤트
function btnclick()
{	
	//날짜쪽을 클릭하면 날짜 옵션을 뜨게 한다.
	$(".resvdate").click(function(){
		$("#option").css('display','none');
		if($("#date").css('display') == 'none')
		{
			$("#date").css('display','flex');
		}else
		{
			$("#date").css('display','none');
		}
	});	
	
	//인원쪽을 클릭하면 인원 옵션을 뜨게 한다.
	$(".people").click(function(){
		$("#date").css('display','none');
		if($("#option").css('display') == 'none')
		{
			$("#option").css('display','block');
		}else
		{
			$("#option").css('display','none');
		}
	});

	//검색을 클릭하면 조건에 해당하는 객실 리스트를 보여준다.
	$("#searchBtn").click(function(){
		var room  = $(".contents");
		room.css('display','none');
		var adult = $(".adult").val();
		switch(adult)
		{
			case adult:
			for(i = adult - 1; i < room.length; i++)
			{
				room[i].style.display = 'block';
			}
			break;
			
			default:
			room.style.display = 'none';
			break;
		}
	})	
}

//예약하기를 누르면 날짜,인원,선택한 객실 정보를 step2로 넘긴다.
function resv(rtype)
{
	var checkin = $("#checkin").val();
	var checkout = $("#checkout").val();
	var night = $("#night").val();
	var adult = $(".adult").val();
	var child = $(".child").val();
	var kid = $(".kid").val();
	
	if(rtype == "S")  max = "1";
	if(rtype == "D")  max = "2";
	if(rtype == "F")  max = "3";
	if(rtype == "ST") max = "4";

	if(max >= adult) //성인 인원수가 객실의 최대인원수보다 많다면
	{		
		url  = "step2.jsp?";
		url += "checkin=" + checkin; 
		url += "&checkout=" + checkout;
		url += "&night=" + night;
		url += "&adult=" + adult;
		url += "&child=" + child;
		url += "&kid=" + kid;
		url += "&rtype=" + rtype;
		location.href = url;
	}else
	{
		alert("예약 인원이 객실의 최대 인원 수를 초과하였습니다. 다시 선택해주세요.");
		return;
	}
}

/* 검색 옵션에서 인원 설정 */
function count(type)
{
	let adcnt = $(".adult").val();
	let chcnt = $(".child").val();
	let kidcnt = $(".kid").val();
	
	if(type == 'aminus')
	{
		adcnt--;
		if(adcnt < 1)
		{
			alert("성인은 최소 1인 포함되어야 합니다.");
			adcnt++;
			return;
		}
	}else if(type == 'aplus')
	{
		adcnt++;
	}else if(type == 'cminus')
	{
		chcnt--;
		if(chcnt < 0)
		{
			chcnt++;
			return;
		}
	}else if(type == 'cplus')
	{
		chcnt++;
	}else if(type == 'kminus')
	{
		kidcnt--;
		if(kidcnt < 0)
		{
			kidcnt++;
			return;
		}
	}else if(type == 'kplus')
	{
		kidcnt++;
	}
	
	if(parseInt(adcnt) + parseInt(chcnt) + parseInt(kidcnt) > 4)
	{
		alert("예약은 성인과 소인 포함 최대 4인까지 가능합니다.");
		return;
	}
	
	$(".adult").val(adcnt);
	$(".child").val(chcnt);
	$(".kid").val(kidcnt);
}