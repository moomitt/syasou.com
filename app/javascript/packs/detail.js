/*global $*/
/*global Rosen*/

//路線図表示・路線データ取得機能
var rosen;
$(function(){                             // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map-detail", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    maxZoom: 16
  });

  //hidden_fieldの値から駅コード1,2・路線コードを取得して変数に格納
  var startStation = Number(document.getElementById('startStationCord').value);
  var endStation = Number(document.getElementById('endStationCord').value);
  var Line = Number(document.getElementById('LineCord').value);
  //駅コード1からstationオブジェクトを取得
  rosen.getStationByCode(startStation)
  .then(function(station) {
    $('#startStationName').text(station.name); //駅名欄にstationの駅名を表示
  });
  //駅コード2からstationオブジェクトを取得
  rosen.getStationByCode(endStation)
  .then(function(station) {
    $('#endStationName').text(station.name);   //駅名欄にstationの駅名を表示
  });
  //路線コードからlineオブジェクトを取得
  rosen.getLineByCode(Line)
  .then(function(line) {
    $('#LineName').text(line.name);            //路線名欄にlineの路線名を表示
  });
  //駅コード・路線コードからsectionオブジェクトを取得
  rosen.getSectionsByStations(Line, startStation, endStation)
  .then(function(sections) {
    sections.forEach(function(section) {
      rosen.fitBoundsBySectionCodes([section.code]); //sectionが画面に収まるよう表示
      rosen.highlightSections([section.code]);       //sectionを強調
    });
  });
});


//入力フォーム：字数カウンター
$(function(){
  //投稿者コメント
  //初期表示
  let countNum1 = String($("#input-body").val().length);
  $("#counter-body").text(countNum1);
  if (countNum1 > 200){
    $("#counter-body").css('color','red');
  };
  //キーアップ時
  $("#input-body").on("keyup", function() {
    countNum1 = String($(this).val().length);
    $("#counter-body").text(countNum1);
    if (countNum1 > 200){
      $("#counter-body").css('color','red');
    };
  });
  //おすすめ時間帯
  //初期表示
  let countNum2 = String($("#input-timezone").val().length);
  $("#counter-timezone").text(countNum2);
  if (countNum2 > 200){
    $("#counter-timezone").css('color','red');
  };
  //キーアップ時
  $("#input-timezone").on("keyup", function() {
    countNum2 = String($(this).val().length);
    $("#counter-timezone").text(countNum2);
    if (countNum2 > 200){
      $("#counter-timezone").css('color','red');
    };
  });
  //おすすめスポット
  //初期表示
  let countNum3 = String($("#input-spot").val().length);
  $("#counter-spot").text(countNum3);
  if (countNum3 > 200){
    $("#counter-spot").css('color','red');
  };
  //キーアップ時
  $("#input-spot").on("keyup", function() {
    countNum3 = String($(this).val().length);
    $("#counter-spot").text(countNum3);
    if (countNum3 > 200){
      $("#counter-spot").css('color','red');
    };
  });
});
