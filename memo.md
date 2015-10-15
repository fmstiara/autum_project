#カラム式会話アプリ
##基本
- node.js socket.io を利用して双方向通信
- swiftで頑張って, iOSアプリをつくる.

##分かったこと
**チャットの仕組み**  

1. メッセージと送り主のデータを送る(サーバに送る)
2. サーバからメッセージと送り主のデータをクライアントに送る
3. サーバからのデータをメッセージの配列に追加する

**クライアントswift**  
クライアントからサーバにデータを送るとき  

```swift
//これをボタンにリンクさせる
let model = NSDictionary(dictionary: ["name": username, "message": textView.text, "date": convertDateToStr(NSDate())]);
socket.emit("message send", args:[model] as SIOParameterArray)
```

サーバからメッセージが来た時  

```swift
self.socket.on("message send", callback:{(data:[AnyObject]!)  in
    let dic = data[0] as NSDictionary
    let model = MessageModel(_name: dic["name"] as String, _message: dic["message"] as String)
    self.messages?.append(model)
    self.tableView.reloadData()
})
```

***Dictionaryを利用することで複数データの送受信が可能***

**node.js(メッセージを受け取ったときの処理)**  

```javascript
socket.on('message send', function(data) {
    console.log('message send');

    data.date = Date.parse(data.date);
    var message = new Messages(data);
    message.save(function(err, message) {
        if (err) return console.error(err);
        io.emit('message send', message);
    });
});
```

##試すこと
メッセージをただの配列ではなくてカラムの機能を持ったオブジェクトにすると実現できるのでは？

##調べること
- [socket.io-client-swift](https://github.com/socketio/socket.io-client-swift)

##参考サイト  
- [☆swiftでsocket通信](http://qiita.com/ytakzk/items/c0a3af0f1b9e5a349d05)  
- [☆swiftでwebsocket](http://grandbig.github.io/blog/2015/03/11/socketio-in-swift/)  
- [iOSからnode.jsで双方向通信](http://dev.classmethod.jp/smartphone/ios-socketioobjc/)  
- [swift✕node.js](http://qiita.com/hiyuzawa/items/15c9f10dcdf0fcb37b4a)  
- [socket.io × SIOSocket](http://qiita.com/mito_log/items/a6207d2b43189687d750)  
- [node.js(サーバサイド)の参考に](http://qiita.com/hosomichi/items/66b309a6c3c20d910218)
