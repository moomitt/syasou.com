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


  //字数カウンター

  let countNum1 = String($("#input-body").val().length);
  $("#counter-body").text(countNum1);
  if (countNum1 > 200){
    $("#counter-body").css('color','red');
  };

  let countNum2 = String($("#input-timezone").val().length);
  $("#counter-timezone").text(countNum2);
  if (countNum2 > 200){
    $("#counter-timezone").css('color','red');
  };

  let countNum3 = String($("#input-spot").val().length);
  $("#counter-spot").text(countNum3);
  if (countNum3 > 200){
    $("#counter-spot").css('color','red');
  };

  $("#input-body").on("keyup", function() {
    countNum1 = String($(this).val().length);
    $("#counter-body").text(countNum1);
    if (countNum1 > 200){
      $("#counter-body").css('color','red');
    };
  });

  $("#input-timezone").on("keyup", function() {
    countNum2 = String($(this).val().length);
    $("#counter-timezone").text(countNum2);
    if (countNum2 > 200){
      $("#counter-timezone").css('color','red');
    };
  });

  $("#input-spot").on("keyup", function() {
    countNum3 = String($(this).val().length);
    $("#counter-spot").text(countNum3);
    if (countNum3 > 200){
      $("#counter-spot").css('color','red');
    };
  });
});
