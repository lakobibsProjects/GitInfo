
//
//  AccountSearchRequestManager.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

class AccountSearchRequestManager{
    let dafaultBeginURL = "https://api.github.com"
    let searchForNameMiddleURL = "/search/users?q="
    var usersResponse: AccountSearch?
    //singleton
    private init(){
        
    }
    
    static var shared: AccountSearchRequestManager = {
        let instance = AccountSearchRequestManager()
        return instance
    }()
    //request logic
    func updateUsersByName(name: String, onPage: Int) {
        let urlString = "\(self.dafaultBeginURL)\(self.searchForNameMiddleURL)\(name)&page=\(onPage)&per_page=20"
        print(urlString)
        let request =  AF.request(urlString)
        request.responseDecodable(of: AccountSearch.self) { (response) in
            guard let response = response.value else {
                let dialogMessage = UIAlertController(title: "", message: "Somthing wrong in interaction with server when request result of search" , preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                UIApplication.shared.windows.last?.rootViewController?.present(dialogMessage, animated: true)
                return }
            self.usersResponse = response
            self.notify(data: response, page: onPage)
        }
    }
    //observer
    var state: Int = { return Int(arc4random_uniform(10)) }()
    
    private lazy var observers = [AccountSearchRequestObserver]()
    
    func attach(_ observer: AccountSearchRequestObserver) {
        observers.append(observer)
    }
    
    func detach(_ observer: AccountSearchRequestObserver) {
        observers = observers.filter({$0.id != observer.id})
    }
    
    func notify(data: AccountSearch?, page: Int) {
        observers.forEach({ $0.update(data: data, page: page)})
    }
    
}
