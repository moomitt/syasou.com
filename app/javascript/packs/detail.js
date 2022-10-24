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
  rosen.getStationByCode(startStation)
  .then(function(station) {
    $('#startStationName').text(station.name);
    document.getElementById('startStationNameInput').value=station.name;
  });
  rosen.getStationByCode(endStation)
  .then(function(station) {
    $('#endStationName').text(station.name);
    document.getElementById('endStationNameInput').value=station.name;
  });
  rosen.getLineByCode(Line)
  .then(function(line) {
    $('#LineName').text(line.name);
    document.getElementById('lineNameInput').value=line.name;
  });
  rosen.getSectionsByStations(Line, startStation, endStation)
  .then(function(sections) {
    sections.forEach(function(section) {
      rosen.fitBoundsBySectionCodes([section.code]);
      rosen.highlightSections([section.code]);
    });
  });
});
