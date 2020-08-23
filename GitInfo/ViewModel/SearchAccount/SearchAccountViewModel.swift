//
//  SearchAccountViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Bond

class SearchAccountViewModel: AccountRequestObserver {
    var id: Int = 0
    
    var tableContentDataSouce = MutableObservableArray<ShortAcc>()
    var error: Error?
    var refreshing = false
    
    private let dataManager = AccountRequestManager.shared
    
    init(){
        AccountRequestManager.shared.attach(self)
    }
    
    func initializeData(name: String){
        tableContentDataSouce.removeAll()
        AccountRequestManager.shared.getUsersByName(name: name, onPage: 1)
        if let temp = AccountRequestManager.shared.usersResponse{
            for acc in temp.items{
                let sa = ShortAcc(id: acc.id, name: acc.login, avatarURL: acc.avatarURL, type: acc.type)
                tableContentDataSouce.append(sa)
            }
        }
    }
    
    func apendData(name: String, onPage: Int){
        AccountRequestManager.shared.getUsersByName(name: name, onPage: onPage)
        if let temp = AccountRequestManager.shared.usersResponse{
            for acc in temp.items{
                let sa = ShortAcc(id: acc.id, name: acc.login, avatarURL: acc.avatarURL, type: acc.type)
                tableContentDataSouce.append(sa)
            }
        }
    }
    
    func update(requestManager: AccountRequestManager, data: Welcome?) {
        if let data = data{
            data.items.forEach({
                tableContentDataSouce.append(ShortAcc(id: $0.id, name: $0.login, avatarURL: $0.avatarURL, type: $0.type))
            })
        }
        
    }

}

struct ShortAcc{
    var id: Int
    var name: String
    var avatarURL: String
    var type: TypeEnum
}
