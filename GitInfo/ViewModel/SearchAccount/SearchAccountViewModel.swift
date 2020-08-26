//
//  SearchAccountViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Bond

class SearchAccountViewModel: AccountSearchRequestObserver {
    var id: Int = 0
    
    var accountSearchResult = MutableObservableArray<SearchedAccount>()
    var error: Error?
    var refreshing = false
    
    private let dataManager = AccountSearchRequestManager.shared
    
    init(){
        AccountSearchRequestManager.shared.attach(self)
    }
    
    func initializeData(name: String){
        AccountSearchRequestManager.shared.updateUsersByName(name: name, onPage: 1)
    }
    
    func apendData(name: String, onPage: Int){
        AccountSearchRequestManager.shared.updateUsersByName(name: name, onPage: onPage)            
    }
    
    func update(data: AccountSearch?, page: Int) {
        if page != 1{
            if let data = data{
                data.accounts.forEach({
                    accountSearchResult.append($0)
                })
            }
        } else{
            if let data = data{
                accountSearchResult.removeAll()
                data.accounts.forEach({
                    accountSearchResult.append($0)
                })
            }
        }
        
        
    }
    
    func sort(){
        var array: [SearchedAccount] = accountSearchResult.array
        array.sort(by: {
            $0.login > $1.login
        })
        accountSearchResult.removeAll()
        for a in array{
            accountSearchResult.append(a)
        }
    }

}

struct ShortAcc{
    var id: Int
    var login: String
    var avatarURL: String
    var type: AccountType
}
