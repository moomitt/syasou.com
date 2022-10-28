var rosen;
$(function(){                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    maxZoom: 16
  });

  /*global $*/
  var startStation = Number(document.getElementById('startStationCord').value);
  var endStation = Number(document.getElementById('endStationCord').value);
  var Line = Number(document.getElementById('LineCord').value);

  rosen.getSectionsByStations(Line, startStation, endStation)
  .then(function(sections) {
    sections.forEach(function(section) {
      rosen.fitBoundsBySectionCodes([section.code]);
      rosen.highlightSections([section.code]);
    })
  })

  var mySwiper = new Swiper ('.swiper-container', {
		slidesPerView: 1,      //画像を何枚表示するか
		spaceBetween: 10,      //何ピクセル画像の間隔をあけるか
		centeredSlides : true, //見切らせたい場合メイン画像をセンターにもってくるか,
		loop: true,            //最後の画像までいったらループする
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
