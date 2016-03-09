SC.initialize({
  client_id: '544a211398f4cd88bb1a54ef02b51d64',
  redirect_uri: 'http://scp.dev-oshou.net/auth/soundcloud/js/callback'
});

var myPlayer = 0;

$(".playTrack").on("click",function(){
  var trackuri ='/tracks/'+$(this).attr("id");
  SC.stream(trackuri).then(function(player){
    player.play();
    myPlayer = player;
    console.log("State: Start");
  });
});

$(".pauseTrack").on("click",function(){
  myPlayer.pause();
  console.log("State: Pause");
});

$(".stopTrack").on("click",function(){
  myPlayer.stop();
  console.log("State: Stop");
});

$(".addTrack").on("click",function(){
  var trackuri ='/me/favorites/'+$(this).attr("id");
  SC.connect().then(function() {
    SC.put(trackuri);
    console.log("Like add Complete");
  })
});

$(".removeTrack").on("click",function(){
  var trackuri ='/me/favorites/'+$(this).attr("id");
  SC.connect().then(function() {
    SC.delete(trackuri);
    console.log("Like remove Complete");
  })
});
