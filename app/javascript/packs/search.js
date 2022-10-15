var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https"                  // HTTPS版のタイルサーバを指定
  });
}

// 駅名で検索
function searchByName() {                 // searchByName(); 関数を定義
  rosen.searchStations({                  // 　rosenオブジェクトのsearchStaionメソッドを呼び出し
    stationName: $('#stationName').val(), // 　　駅名： id="stationName"要素のvalue値を取得
    stationNameMatchType: "partial"     　// 　　駅名のマッチング方法： 部分一致
  }).then(function(stations) {            //　 処理成功後、thenメソッド以降のメソッドが呼び出される
    var msg = "";                         //　 変数msgを宣言
    stations.forEach(function(station) {  // 　stations = searchStaionsの結果？ 内のstation個々に実行
      msg += station.name + "\n";         // 　　msgに駅名+改行コードを追加していく
    });
    alert(msg);
    // $('#map_message').text(msg);          //　 id="map_message"要素にテキスト（msgの中身）を追加
  });
};

window.addEventListener('DOMContentLoaded', init);
const btn = document.getElementById("btn");
btn.addEventListener('click', alert('msg'));

// // 指定路線上の駅を検索
// function searchByLineCode() {
//   rosen.searchStations({
//     lineCode: $('#lineCode').val()
//   }).then(function(stations) {
//     var msg = "";
//     stations.forEach(function(station) {
//       msg += station.name + "\n";
//     });
//     $('#map_message').text(msg);
//   });
// }

