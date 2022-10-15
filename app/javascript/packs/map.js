var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https"                  // HTTPS版のタイルサーバを指定
  });
}

var params = {
  stationName: $('#stationName').val(), // 　　駅名： id="stationName"要素のvalue値を取得
  stationNameMatchType: "partial"       // 　　駅名のマッチング方法： 部分一致
}

/*global $*/
$(function () {
  $('#btn').on('click', function(){
    rosen.searchStations(params)
    .then(function (stations) {
      var msg = "";                         //　 変数msgを宣言
      stations.forEach(function(station) {  // 　stations = searchStaionsの結果？ 内のstation個々に実行
        msg += station.name + "\n";         // 　　msgに駅名+改行コードを追加していく
      });
      $('#station-data').text(msg);
    });
  });
});

window.addEventListener('DOMContentLoaded', init);