/*global $*/
/*global Rosen*/

//路線図表示・区間選択機能
var rosen;
$(function(){                               // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map-new", {            // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY,   // アクセスキーを認証
    apiSetting: "https",                    // HTTPS版のAPIサーバを指定
    tileSetting: "https",                   // HTTPS版のタイルサーバを指定
    zoom: 10,
    sideMenuControl: true
  });

　//selectSection：駅間(section)をクリックしたときに発生するイベント
  rosen.on('selectSection', function(data) {
    rosen.clearHighlights();                         //すべての強調を解除
    data.sections.forEach(function(section) {        //クリックされたsectionに処理を行う
      rosen.highlightSections([section.code]);         //sectionを強調
      rosen.getStationsBySectionCode([section.code])   //sectionから両端のstationオブジェクトを取得
      .then(function(stations) {
        $('#startStationName').text(stations[0].name);   //station[0]の駅名を駅名欄1に表示
        $('#endStationName').text(stations[1].name);     //station[1]の駅名を駅名欄2に表示
        //station[0],[1]の各データをhidden_fieldに入力
        document.getElementById('startStationCord').value=stations[0].code;                  //駅1 駅コード
        document.getElementById('endStationCord').value=stations[1].code;                    //駅2 駅コード
        document.getElementById('startStationNameInput').value=stations[0].name;             //駅1 駅名
        document.getElementById('endStationNameInput').value=stations[1].name;               //駅2 駅名
        document.getElementById('startStationPrefecture').value=stations[0].prefecture_code; //駅1 都道府県コード
        document.getElementById('endStationPrefecture').value=stations[1].prefecture_code;   //駅2 都道府県コード
        document.getElementById('startStationLatitude').value=stations[0].latitude;          //駅1 緯度
        document.getElementById('startStationLongitude').value=stations[0].longitude;        //駅1 経度
      });
      const line_code = Rosen.getLineCodeBySectionCode([section.code]); //sectionから路線コードを取得
      rosen.getLineByCode(line_code)   //路線コードからlineオブジェクトを取得
      .then(function(line) {
        $('#LineName').text(line.name);     //lineの路線名を路線名欄に表示
        //lineのデータをhidden_fieldに入力
        document.getElementById('LineCord').value=line.code;      //路線コード
        document.getElementById('LineNameInput').value=line.name; //路線名
      });
    });

    //駅コード・路線コードが空白でない場合のみ、submitボタンが出現
    if( $('#startStationCord').value != "" && $('#endStationCord').value != "" && $('#lineCord').value != "" ){
      $('#submitBtn').html('<button type="submit" class="btn btn-sm btn-accent px-3 mb-1">登録画面へ進む</button>');
    };
  });

  //リセットボタンをクリックしたときのイベント
  $('#resetButton').on('click', function(){
    rosen.clearStationMarkers();      //すべての駅マーカーを削除（※サイドバー検索で表示される）
    rosen.clearHighlights();          //すべての強調を解除
    $('#startStationName').text("");  //駅名欄1を空白に
    $('#endStationName').text("");    //駅名欄2を空白に
    $('#LineName').text("");          //路線名欄を空白に
    //hidden_fieldの値を全て空白に
    document.getElementById('startStationCord').value=""       //駅1 駅コード
    document.getElementById('endStationCord').value=""　　     //駅2 駅コード
    document.getElementById('startStationNameInput').value=""  //駅1 駅名
    document.getElementById('endStationNameInput').value=""    //駅2 駅名
    document.getElementById('startStationPrefecture').value="" //駅1 都道府県コード
    document.getElementById('endStationPrefecture').value=""   //駅2 都道府県コード
    document.getElementById('startStationLatitude').value=""   //駅1 緯度
    document.getElementById('startStationLongitude').value=""  //駅1 経度
    document.getElementById('LineCord').value=""　　　　　     //路線コード
    //submitボタンをdisabledボタンに戻す
    $('#submitBtn').html('<button disabled class="btn btn-sm btn-accent px-4 mb-1">選択されていません</button>');
  });
});

// モーダルウィンドウ（操作方法）表示切り替え
$(function(){
	$("#modal-new-open").on('click',function(){
    $("#modal-new-overlay").fadeIn("fast");
  });
  $("#modal-new-close, #modal-new-overlay").on('click',function(){
    $("#modal-new-overlay").fadeOut("fast");
  });
});