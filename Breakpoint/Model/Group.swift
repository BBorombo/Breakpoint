//
//  Group.swift
//  Breakpoint
//
//  Created by Erwan Rombo on 30/09/2017.
//  Copyright © 2017 Borombo. All rights reserved.
//

import Foundation

class Group{
    
    private var _groupeTitle: String
    private var _groupeDesc: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    var groupeTitle: String { return _groupeTitle }
    var groupeDesc: String { return _groupeDesc }
    var key: String { return _key }
    var memberCount: Int { return _memberCount }
    var members: [String] { return _members }
    
    init(title: String, description: String, key: String, members: [String], memberCount: Int) {
        self._groupeTitle = title
        self._groupeDesc = description
        self._key = key
        self._memberCount = memberCount
        self._members = members
    }
}
