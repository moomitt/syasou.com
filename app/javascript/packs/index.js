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
  alert('success');
  console.log(mapPosts);

  // var datas = document.getElementById('mapPosts');
  // var mapPosts = JSON.parse(datas.getAttribute('posts'));
  // alert('success');
  // console.log(mapPosts);

  mapPosts.map(function(post){
    rosen.getSectionsByStations(post.line_code, post.start_station, post.end_station)
      .then(function(sections) {
      sections.forEach(function(section) {
        rosen.highlightSections([section.code]);
      });
    });
  });
};

window.addEventListener('DOMContentLoaded', init);