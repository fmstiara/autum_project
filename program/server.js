//expressモジュールのロード
var express = require('express');
var app = express();

//メッセージオブジェクトの準備
var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var MessagesSchema = new Schema({
	name: String,
	message: String,
	date: Date
});

mongoose.model('messages', MessagesSchema);
mongoose.connect('mongodb://localhost/message');
var Messages = mongoose.model('messages');

app.set('port', process.env.PORT || 3000);

var http = require('http').Server(app);
var io = require('socket.io')(http);

io.on('connection', function(socket){
  //通信をした際の処理

  socket.on('message init', function(data){
    console.log("init");
  });

  socket.on('message send', function(data){
    console.log("data:" + data.message);

  });


});

http.listen(app.get('port'), function(){
  console.log('listening on...');
});
