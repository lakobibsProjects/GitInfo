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
        let urlString = "https://api.github.com/users/\(login)"
        print(urlString)
        let request =  AF.request(urlString)
        request.responseDecodable(of: UserByLogin.self) { (response) in
            guard let response = response.value else {
                print("fail to response user")
                let dialogMessage = UIAlertController(title: "", message: "Somthing wrong in interaction with server when request info about user" , preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                UIApplication.shared.windows.last?.rootViewController?.present(dialogMessage, animated: true)
                return }
            self.userResponse = response
            self.notify(user: response)
        }
        print("\(self.userResponse == nil)")
    }
    
    func getUserByURL(urlString: String) {
        print(urlString)
        let request =  AF.request(urlString)
        request.responseDecodable(of: UserByLogin.self) { (response) in
            guard let response = response.value else {
                print("fail to response user")
                let dialogMessage = UIAlertController(title: "", message: "Somthing wrong in interaction with server when request info about user" , preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                UIApplication.shared.windows.last?.rootViewController?.present(dialogMessage, animated: true)
                return }
            self.userResponse = response
            self.notify(user: response)
        }
        print("\(self.userResponse == nil)")
        
        
        /*guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(UserByLogin.self, from:dataResponse) //Decode JSON Response Data
                print(model)
                self.notify(user: model)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()*/
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
