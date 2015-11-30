var socket = io();

$('form').submit(function(){
  /*var data = {
    name = "hoge",
    message = $('sendText').val(),
    date = Date()
  }*/
  //socket.emit('chat message', data);
  socket.emit('send message', $('#sendText').val());
  $('#sendText').val('');
  return false;
});

socket.on('received message', function(data){
  console.log("receive message");

  $('#messages').append($('<li>').text(data));
});
