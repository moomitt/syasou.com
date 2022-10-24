var rosen;
function init() {                         // Rosen：イニシャライザ（アクセスキー認証／路線図表示）
  rosen = new Rosen("map", {              // "map"=<div>のid
    apiKey: process.env.ROSEN_JS_API_KEY, // アクセスキーを認証
    apiSetting: "https",                  // HTTPS版のAPIサーバを指定
    tileSetting: "https",                 // HTTPS版のタイルサーバを指定
    zoom: 10,
    sideMenuControl: true,
  });

  /*global $*/
  var mapPosts = $('#mapPosts').data('posts');

  mapPosts.map(function(post){
    var src = post.post_image;
    var body = post.post_body;
    var url = '/posts/' + post.post_id;
    var latitude = Number(post.latitude);
    var longitude = Number(post.longitude);
    console.log(latitude);
    console.log(longitude);
    var html = '<a href=' + url + '><img class="popup-image" src=' +
               src + '></img></br> <p class="popup-text">' + body + '</p></a>'

    if(latitude > 40 && longitude > 142){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [-100, 200]
      }).setHTML(html);
    } else if(latitude > 40){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [0, 200]
      }).setHTML(html);
    } else if(longitude > 142){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [-100, 0]
      }).setHTML(html);
    } else if(longitude < 131){
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [60, 20]
      }).setHTML(html);
    } else {
      var hinode_popup = Rosen.htmlPopup({
        className: "popup",
        offset: [0, 20]
      }).setHTML(html);
    };

    rosen.setStationPopup([post.start_station], hinode_popup, false)
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