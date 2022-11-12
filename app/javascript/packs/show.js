/*global $*/
/*global Rosen*/
/*global Swiper*/

//路線図表示機能
var rosen;
$(function(){                         　　// Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map-show", {         // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    maxZoom: 16
  });

  //hidden_fieldの値から駅コード1,2・路線コードを取得して変数に格納
  var startStation = Number(document.getElementById('startStationCord').value);
  var endStation = Number(document.getElementById('endStationCord').value);
  var Line = Number(document.getElementById('LineCord').value);
  //駅コード・路線コードからsectionオブジェクトを取得
  rosen.getSectionsByStations(Line, startStation, endStation)
  .then(function(sections) {
    sections.forEach(function(section) {
      rosen.fitBoundsBySectionCodes([section.code]); //sectionが画面に収まるよう表示
      rosen.highlightSections([section.code]);       //sectionを強調
    })
  });
});

//スライダー
$(function(){
  var mySwiper = new Swiper ('.swiper-container', {
		slidesPerView: 1,
		spaceBetween: 10,
		loop: true,
		pagination: {
		 el: '.swiper-pagination',
		 type: 'bullets',
		 clickable: true,
		},
		navigation: {
		 nextEl: '.swiper-button-next',
		 prevEl: '.swiper-button-prev',
		}
	});
});

//モーダルウィンドウ（ゲストログイン用）
$(function(){
  //表示・非表示
	$(".modal-open").on('click',function(){
      $("#modal-overlay").fadeIn("fast");
  });
  $("#modal-close,#modal-overlay").on('click',function(){
    $("#modal-overlay").fadeOut("fast");
  });
  // ログイン・新規登録ボタンを押すと非表示のlink_toをクリックする
  $("#modal-login").on('click',function(){
    document.getElementById("logInBtn").click();
  });
  $("#modal-signup").on('click',function(){
    document.getElementById("signUpBtn").click();
  });
});

//コメント投稿フォーム：字数カウンター
$(function(){
  //初期表示
  let countNum = String($("#input-comment").val().length);
  $("#counter-comment").text(countNum);
  if (countNum > 150){
    $("#counter-comment").css('color','red');
  };
  //キーアップ時
  $("#input-comment").on("keyup", function() {
    countNum = String($(this).val().length);
    $("#counter-comment").text(countNum);
    if (countNum > 150){
      $("#counter-comment").css('color','red');
    } else {
      $("#counter-comment").css('color','black');
    }
  });
});
