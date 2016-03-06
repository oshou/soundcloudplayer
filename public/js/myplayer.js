SC.initialize({
  client_id: '544a211398f4cd88bb1a54ef02b51d64',
  redirect_uri: 'http://scp.dev-oshou.net/auth/soundcloud/js/callback'
});

$(".playTrack").on("click",function(){
  var trackuri ='/tracks/'+$(this).attr("id");
  SC.stream(trackuri).then(function(s){
    s.play();
  });
});

/*
var is_playing = "false"
$(".playTrack").on("click",function(){
  var trackuri ='/tracks/'+$(this).attr("id");
  SC.stream(trackuri).then(function(s){
    if (is_playing === "true")
    {
      s.pause();
      is_playing = "false";
      console.log(is_playing);
    }
    else if(is_playing === "false")
    {
      s.play();
      is_playing = "true";
      console.log(is_playing);
    }
  });
});
*/

$(".pauseTrack").on("click",function(){
  var trackuri ='/tracks/'+$(this).attr("id");
  SC.stream(trackuri).then(function(s){
    s.pause();
    console.log(s.pause());
  });
});

$(".addTrack").on("click",function(){
  var trackuri ='/me/favorites/'+$(this).attr("id");
  SC.connect().then(function() {
    SC.put(trackuri);
    console.log("add Complete");
  })
});
