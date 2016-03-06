SC.initialize({
  client_id: '544a211398f4cd88bb1a54ef02b51d64',
  redirect_uri: 'http://scp.dev-oshou.net/auth/soundcloud/js/callback'
});

//SC.stream('/tracks/159906303').then(function(player){
//  player.play();
//});

SC.stream('/tracks/159906303').then(function(sound){
  s = sound;
});

$("#play").click(function(){
  s.play();
});

$("#pause").click(function(){
  s.pause();
});

$("#stop").click(function(){
  s.stop();
});
