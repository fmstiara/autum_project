var socket = io();

$(function($){
  //Ctrlキー+エンター
  $(window).keydown(function(e){
    if(event.ctrlKey){
      if(e.keyCode === 13){
        alert("ctrl+enter");
         return false;
      }
    }
  });
  //Shiftキー+エンター ←今回のやりたかったこと
  $(window).keydown(function(e){
    if(event.shiftKey){
      if(e.keyCode === 13){
         return false;
      }
    }
  });
});
/*
//when command key is pressed
$('body').keydown(function(e){
    if(e.keyCode === 93){
      socket.emit('brunch change', 1);
    }

    if(e.keyCode === 13){
      var messageInfo = {
        message: $('#sendText').val(),
        brunchNumber: 0,
        brunch: false
      };
      //keep story
      socket.emit('send message', messageInfo);
      $('#sendText').val('');
      return false;
    }
});

//when send message
$('form').submit(function(){
  var messageInfo = {
    message: $('#sendText').val(),
    brunchNumber: 0,
    brunch: false
  };

  if($('#brunchFlag').is(':checked')){
    //start story brunch...
    messageInfo.brunch = true;
    socket.emit('send message', messageInfo);
    $('#sendText').val('');
    return false;

  } else {
    //keep story
    socket.emit('send message', messageInfo);
    $('#sendText').val('');
    return false;

  }

});
*/

$('#reset').on('click', function(data){
  socket.emit('send reset', 0);
})

socket.on('html remove', function(data){
  $('#messages').empty();
});
socket.on('received message', function(data){
  if(data != null){
    console.log("receive message " + data);
    $('#messages').append($('<li>').text(data.message));
  }

});
