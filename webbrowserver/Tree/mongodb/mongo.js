var mongoose = require('mongoose');

var con = mongoose.connect('mongodb://localhost/messagesInfo');
var db = con.connection;

//接続エラー時にコールバック実行
db.on('error', console.error.bind(console, 'connection error:'));

//接続成功時にコールバック実行
db.once('open', function (callback) {
    console.log("connect successfully")
});

var Schema = mongoose.Schema;

var messageInfoSchema = new Schema({
  name: String,
  message: String,
  date: Date
});

var MessageInfo = mongoose.model('MessageInfo',messageInfoSchema);
var messageInfo = new MessageInfo();
messageInfo.name = 'tiara';
messageInfo.message = 'hogehoge';
messageInfo.date = new Date();
messageInfo.save(function(err){
  if(err){
    console.error(err);
  } else {
    console.log("saved messageInfo");
  }
})
