//
//  AccountRequestManager.swift
//  GitInfo
//
//  Created by user166683 on 8/24/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

class AccountRequestManager{
    let dafaultBeginURL = "https://api.github.com"
    let generalAcceptHeader = "application/vnd.github.v3+json"
    let searchForNameMiddleURL = "/users/"
    var userResponse: UserByLogin?
    
    private init(){
        
    }
    
    static var shared: AccountRequestManager = {
        let instance = AccountRequestManager()
        return instance
    }()
    
    func getUserByLogin(login: String) {
        DispatchQueue.main.async {
            let urlString = "\(self.dafaultBeginURL)\(self.searchForNameMiddleURL)\(login)"
            print(urlString)
            let request =  AF.request(urlString)
            
            request.responseDecodable(of: UserByLogin.self) { (response) in
                guard let response = response.value else { return }
                self.userResponse = response
                self.notify(user: response)
            }
            print("\(self.userResponse == nil)")
        }
    }
    
    var state: Int = { return Int(arc4random_uniform(10)) }()

    private lazy var observers = [AccountByLoginRequestObserver]()

    func attach(_ observer: AccountByLoginRequestObserver) {
        observers.append(observer)
    }

    func detach(_ observer: AccountByLoginRequestObserver) {
         observers = observers.filter({$0.id != observer.id})
    }

    func notify(user: UserByLogin) {
        observers.forEach({ $0.update(user: user)})
    }
    
}
