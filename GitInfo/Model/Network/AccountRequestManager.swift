
//
//  AccountRequestManager.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

class AccountRequestManager{
    let dafaultBeginURL = "https://api.github.com"
    let generalAcceptHeader = "application/vnd.github.v3+json"
    let searchForNameMiddleURL = "/search/users?q="
    var usersResponse: Welcome?
    
    private init(){
        
    }
    
    static var shared: AccountRequestManager = {
        let instance = AccountRequestManager()
        return instance
    }()
    
    func getUsersByName(name: String, onPage: Int) {
        DispatchQueue.main.async {
            let urlString = "\(self.dafaultBeginURL)\(self.searchForNameMiddleURL)\(name)&page=\(onPage)&per_page=20"
            print(urlString)
            let request =  AF.request(urlString)
            
            request.responseDecodable(of: Welcome.self) { (response) in
                guard let response = response.value else { return }
                self.usersResponse = response
                self.notify(data: response)
            }
            print("\(self.usersResponse == nil)")
        }
    }
    
    var state: Int = { return Int(arc4random_uniform(10)) }()

    private lazy var observers = [AccountRequestObserver]()

    func attach(_ observer: AccountRequestObserver) {
        observers.append(observer)
    }

    func detach(_ observer: AccountRequestObserver) {
         observers = observers.filter({$0.id != observer.id})
    }

    func notify(data: Welcome?) {
        observers.forEach({ $0.update(requestManager: self, data: data)})
    }
    
}
