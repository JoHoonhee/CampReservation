var bigImg = document.querySelector('#big'); // 메인 이미지 선택
var smallImg = document.querySelectorAll('.small'); // 선택 이미지 노드 리스트

for (var i = 0; i < smallImg.length; i++) {
	smallImg[i].addEventListener('click', changeImg); // 클릭 시 changeImg 실행
}

function changeImg() {
	var newImg = this.src; // click 이벤트가 발생하면 대상의 src 속성 값을 가져옴
	bigImg.setAttribute('src', newImg); // 선택한 이미지를 큰 이미지의 src 속성에 주입
}