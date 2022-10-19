var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    zoom: 10,
    sideMenuControl: true
  });

  /*global $*/
  var mapPosts = $('#mapPosts').data('posts');

  mapPosts.map(function(post){
    var url = '/posts/' + post.post_id;
    var body = post.post_body;
    var text_popup = Rosen.imagePopup();
    text_popup.setComment(body);
    text_popup.setAnchor(url);
    rosen.setStationPopup([post.start_station], text_popup, false)
    .then(function (marker) {
      marker.closePopup();
    });

    rosen.getSectionsByStations(post.line_code, post.start_station, post.end_station)
      .then(function(sections) {
      sections.forEach(function(section) {
        rosen.highlightSections([section.code]);
      });
    });
  });
};

window.addEventListener('DOMContentLoaded', init);