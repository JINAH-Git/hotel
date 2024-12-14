/* 객실관리 팝업에 관한 스크립트 */

  var target = document.querySelectorAll('.btn_open'); // 클릭할 버튼요소를 변수 처리
  var btnPopClose = document.querySelectorAll('.pop_wrap .btn_close');
  var targetID;  // 버튼 클릭시 버튼에 해당하는 팝업의 id값 담는 변수
  
// 팝업 열기
for(var i = 0; i < target.length; i++)
{
  target[i].addEventListener('click', function(){
  targetID = this.getAttribute('name');
  document.querySelector(targetID).style.display = 'block';
  });
}
  
// 팝업 닫기
for(var j = 0; j < target.length; j++)
{
  btnPopClose[j].addEventListener('click', function(){
  this.parentNode.parentNode.style.display = 'none';
  });
}
