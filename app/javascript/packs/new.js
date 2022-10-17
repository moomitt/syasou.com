var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                  // HTTPS版のタイルサーバを指定
    sideMenuControl: true
  });

  /*global $*/
  rosen.on('selectSection', function(data) {
    rosen.clearHighlights();
    data.sections.forEach(function(section) {
      rosen.highlightSections([section.code]);
      rosen.getStationsBySectionCode([section.code])
      .then(function(stations) {
        $('#startStationName').text(stations[0].name);
        $('#endStationName').text(stations[1].name);
        document.getElementById('startStationCord').value=stations[0].code;
        document.getElementById('endStationCord').value=stations[1].code;
        document.getElementById('startStationPrefecture').value=stations[0].prefecture_code;
        document.getElementById('endStationPrefecture').value=stations[1].prefecture_code;
      });
      const line_code = Rosen.getLineCodeBySectionCode([section.code]);
      rosen.getLineByCode(line_code)
      .then(function(line) {
        $('#LineName').text(line.name);
        document.getElementById('LineCord').value=line.code;
      });
    });
  });

  $(function () {
    $('#resetButton').on('click', function(){
      rosen.clearHighlights();
      $('#startStationName').text("");
      $('#endStationName').text("");
      $('#LineName').text("");
      document.getElementById('startStationCord').value=""
      document.getElementById('endStationCord').value=""
      document.getElementById('LineCord').value=""
    });
  });
};

window.addEventListener('DOMContentLoaded', init);