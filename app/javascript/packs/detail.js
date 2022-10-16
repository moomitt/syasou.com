var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https"                  // HTTPS版のタイルサーバを指定
  });

  /*global $*/
  var startStation = Number(document.getElementById('startStationCord').value);
  var endStation = Number(document.getElementById('endStationCord').value);
  rosen.getStationByCode(startStation)
  .then(function(station) {
    $('#startStationName').text(station.name);
  });
  rosen.getStationByCode(endStation)
  .then(function(station) {
    $('#endStationName').text(station.name);
  });
}

window.addEventListener('DOMContentLoaded', init);
