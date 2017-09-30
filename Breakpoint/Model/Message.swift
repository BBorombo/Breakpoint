//
//  Message.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import Foundation

class Message {
    
    private var _content: String
    private var _senderId: String
    
    var content: String{ return _content}
    var senderId: String{ return _senderId}
    
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
    
}
