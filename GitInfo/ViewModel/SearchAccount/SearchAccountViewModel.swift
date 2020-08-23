//
//  SearchAccountViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Bond

class SearchAccountViewModel {
    
    var tableContentDataSouce = MutableObservableArray<ShortAcc>()
    var error: Error?
    var refreshing = false
    
    private let dataManager = RequestManager.shared
    
    func initializeData(name: String){
        tableContentDataSouce.removeAll()
        RequestManager.shared.getUsersByName(name: name, onPage: 1)
        if let temp = RequestManager.shared.usersResponse{
            for acc in temp.items{
                let sa = ShortAcc(id: acc.id, name: acc.login, avatarURL: acc.avatarURL, type: acc.type)
                tableContentDataSouce.append(sa)
            }
        }
    }
    
    func apendData(name: String, onPage: Int){
        RequestManager.shared.getUsersByName(name: name, onPage: onPage)
        if let temp = RequestManager.shared.usersResponse{
            for acc in temp.items{
                let sa = ShortAcc(id: acc.id, name: acc.login, avatarURL: acc.avatarURL, type: acc.type)
                tableContentDataSouce.append(sa)
            }
        }
    }

}

struct ShortAcc{
    var id: Int
    var name: String
    var avatarURL: String
    var type: TypeEnum
}
