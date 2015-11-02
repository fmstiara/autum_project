//
//  ViewController.swift
//  Tree
//
//  Created by Ouchi Taira on 2015/10/24.
//  Copyright © 2015年 tiara. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var MessageView: UIScrollView!
    @IBOutlet weak var sendText: UITextField!
    
    //socket通信
    var socket:SIOSocket! = nil
    
    var isObserving = false
    
    var messages: Array<MessageModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SIOSocket.socketWithHost("ws://localhost:3000", response:  { (_socket: SIOSocket!) in
            self.socket = _socket
            
            self.socket.onConnect = {() in
                print("connected")
                self.socket.emit("message init", args: [])
            }
            
            self.socket.on("message send", callback:{(data:[AnyObject]!)  in
                let dic = data[0] as! NSDictionary
                let model = MessageModel(_name: dic["name"] as! String, _message: dic["message"] as! String)
                self.messages?.append(model)
                print(self.messages)
            })
            
        })
        
        
        
    }

    override func viewWillAppear(animated: Bool) {
        // Viewの表示時にキーボード表示・非表示を監視するObserverを登録する
        super.viewWillAppear(animated)
        if(!isObserving) {
            let notification = NSNotificationCenter.defaultCenter()
            notification.addObserver(self, selector: "keyboardWillShow:"
                , name: UIKeyboardWillShowNotification, object: nil)
            notification.addObserver(self, selector: "keyboardWillHide:"
                , name: UIKeyboardWillHideNotification, object: nil)
            isObserving = true
        }
    }
    override func viewWillDisappear(animated: Bool) {
        // Viewの表示時にキーボード表示・非表示時を監視していたObserverを解放する
        super.viewWillDisappear(animated)
        if(isObserving) {
            let notification = NSNotificationCenter.defaultCenter()
            notification.removeObserver(self)
            notification.removeObserver(self
                , name: UIKeyboardWillShowNotification, object: nil)
            notification.removeObserver(self
                , name: UIKeyboardWillHideNotification, object: nil)
            isObserving = false
        }
    }
    //画面がタップされた際にキーボードを閉じる処理
    func tapGesture(sender: UITapGestureRecognizer) {
        sendText.resignFirstResponder()
        
    }
    //キーボードのreturnが押された際にキーボードを閉じる処理
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendText.resignFirstResponder()
        return true
    }
    //textFieldを編集する際に行われる処理
    func keyboardWillShow(notification: NSNotification?) {
        // キーボード表示時の動作をここに記述する
        let rect = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let duration:NSTimeInterval = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey]as! Double
        UIView.animateWithDuration(duration, animations: {
            let transform = CGAffineTransformMakeTranslation(0, -rect.size.height)
            self.view.transform = transform
            },completion:nil)
    }
    func keyboardWillHide(notification: NSNotification?) {
        // キーボード消滅時の動作をここに記述する
        let duration = (notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double)
        UIView.animateWithDuration(duration, animations:{
            self.view.transform = CGAffineTransformIdentity
            },
            completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMessage(sender: AnyObject) {
        print("push")
        let model = NSDictionary(dictionary: ["name": "taira", "message": sendText.text!]);
        socket.emit("message send", args:[model])

    }

}

