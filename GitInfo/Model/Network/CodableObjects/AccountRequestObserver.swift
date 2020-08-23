
//
//  AccountRequestObserver.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

protocol AccountRequestObserver{
    var id : Int { get } 
    func update(requestManager: AccountRequestManager, data: Welcome?)
}
