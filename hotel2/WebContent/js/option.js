/* �˻� �ɼ��� �����ϴ� js */


//���ĸ�� �̺�Ʈ
function viewroom()
{
	/* �ּ�â�� �Ѿ�� ���� ������ �о ���Ǹ���� ȭ�鿡 �ѷ��ش�.*/
	var room  = $(".contents");
	const urlParams = new URL(location.href).searchParams;		
	const adult = urlParams.get('adult');
	const child = urlParams.get('child');
	const kid = urlParams.get('kid');
	const checkin = urlParams.get('checkin');
	const checkout = urlParams.get('checkout');
	
	if(checkin != null)
	{
		//üũ�� �Ϸ�
		document.getElementById(checkin).classList.add('checkin');
		$(".checkin").html("in");		
	}
	if(checkout != null)
	{
		//üũ�ƿ� �Ϸ�
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

//Ŭ�� �̺�Ʈ
function btnclick()
{	
	//��¥���� Ŭ���ϸ� ��¥ �ɼ��� �߰� �Ѵ�.
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
	
	//�ο����� Ŭ���ϸ� �ο� �ɼ��� �߰� �Ѵ�.
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

	//�˻��� Ŭ���ϸ� ���ǿ� �ش��ϴ� ���� ����Ʈ�� �����ش�.
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

//�����ϱ⸦ ������ ��¥,�ο�,������ ���� ������ step2�� �ѱ��.
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

	if(max >= adult) //���� �ο����� ������ �ִ��ο������� ���ٸ�
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
		alert("���� �ο��� ������ �ִ� �ο� ���� �ʰ��Ͽ����ϴ�. �ٽ� �������ּ���.");
		return;
	}
}

/* �˻� �ɼǿ��� �ο� ���� */
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
			alert("������ �ּ� 1�� ���ԵǾ�� �մϴ�.");
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
		alert("������ ���ΰ� ���� ���� �ִ� 4�α��� �����մϴ�.");
		return;
	}
	
	$(".adult").val(adcnt);
	$(".child").val(chcnt);
	$(".kid").val(kidcnt);
}