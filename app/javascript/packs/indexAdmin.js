/*global $*/
/*global Rosen*/

//路線図表示・ポップアップ機能
var rosen;
$(function(){                             // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    zoom: 10,                             // 初期ズーム：最小
    sideMenuControl: true,                // サイドメニュー表示
  });

  //htmlの#mappostsからjson形式で全投稿データを取得し、変数に格納
  var mapPosts = $('#mapPosts').data('posts');
  
  //投稿データ1件ごとに処理を行う
  mapPosts.map(function(post){
    //ポップアップ表示用の変数を準備
    var src = post.post_image;                //投稿データ 画像のurl
    var body = post.post_body;                //投稿データ 投稿者コメント
    var url = '/admin/posts/' + post.post_id; //投稿データ showページのurl
    //ポップアップ用のhtml
    var html = '<a href=' + url + '><img class="popup-image" src=' +
           src + '></img></br> <p class="popup-text">' + body + '</p></a>'
    var latitude = Number(post.latitude);     //投稿データ 駅1の緯度
    var longitude = Number(post.longitude);   //投稿データ 駅1の経度

    //htmlの内容でhtmlポップアップを作成
      // 緯度・経度によってポップアップのオフセット変更
      //（マップ外にはみ出す場合があるため）
      
      //緯度40度超かつ経度142度超の場合：左下に表示
    if(latitude > 40 && longitude > 142){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [-100, 200]
      }).setHTML(html);
      //緯度40度超の場合：中央下に表示
    } else if(latitude > 40){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [0, 200]
      }).setHTML(html);
      //経度142度超の場合：左上に表示
    } else if(longitude > 142){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [-100, 0]
      }).setHTML(html);
      //経度131度未満の場合：右寄りに表示
    } else if(longitude < 131){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [60, 20]
      }).setHTML(html);
      //緯度40度以下、経度131～142度の場合：中央上に表示
    } else {
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [0, 20]
      }).setHTML(html);
    };
    //駅1にポップアップをセット（自動ズーム:false）
    rosen.setStationPopup([post.start_station], hinode_popup, false)
    .then(function (marker) {
      //初期はポップアップを閉じた状態にする
      marker.closePopup();
    });
    //路線コード・駅コードからsectionオブジェクトを取得
    rosen.getSectionsByStations(post.line_code, post.start_station, post.end_station)
      .then(function(sections) {
      sections.forEach(function(section) {
        rosen.highlightSections([section.code]); //sectionを強調
      });
    });
  });
});