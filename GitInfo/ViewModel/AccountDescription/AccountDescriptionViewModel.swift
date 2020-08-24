
//
//  AccountDescriptionViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

class AccountDescriptionViewModel: AccountByLoginRequestObserver{
    var id: Int = 1
    
    func update(user: UserByLogin) {
        print("\(user.name ?? "")")
    }
    
}
