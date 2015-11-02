//
//  MessageModel.swift
//  Tree
//
//  Created by Ouchi Taira on 2015/10/27.
//  Copyright © 2015年 tiara. All rights reserved.
//

import Foundation
import UIKit

class MessageModel: NSObject{
    let name: String
    let message: String
    
    init(_name: String, _message: String) {
        name = _name
        message = _message
    }
    
}