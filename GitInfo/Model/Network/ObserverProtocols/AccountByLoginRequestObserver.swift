//
//  AccountByLoginRequestObserver.swift
//  GitInfo
//
//  Created by user166683 on 8/24/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

protocol AccountByLoginRequestObserver{
    var id : Int { get }
    func update(user: UserByLogin)
}
