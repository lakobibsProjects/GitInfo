//
//  RepoRequestManager.swift
//  GitInfo
//
//  Created by user166683 on 8/25/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

class RepoRequestManager{
    let dafaultBeginURL = "https://api.github.com"
    let searchForNameMiddleURL = "/search/users?q="
    var repoResponse: Repos?
    //singleton
    private init(){
        
    }
    
    static var shared: RepoRequestManager = {
        let instance = RepoRequestManager()
        return instance
    }()
    
    //request logic
    func getReposByLogin(login: String, isUser: Bool) {
        var urlString = ""
        if isUser{
            urlString = "https://api.github.com/users/\(login)/repos"
        } else{
            urlString = "https://api.github.com/orgs/\(login)/repos"
        }
        
        print(urlString)
        let request =  AF.request(urlString)
        request.responseDecodable(of: Repos.self) { (response) in
            guard let response = response.value else {
                print("fail to response repos")
                let dialogMessage = UIAlertController(title: "", message: "Somthing wrong in interaction with server when request repositories" , preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                UIApplication.shared.windows.last?.rootViewController?.present(dialogMessage, animated: true)
                return }
            self.repoResponse = response
            self.notify(data: response)
        }
    }
    
    func getReposByURL(URL: String) {
        print(URL)
        let request =  AF.request(URL)
        request.responseDecodable(of: Repos.self) { (response) in
            guard let response = response.value else {
                print("fail to response repos")
                let dialogMessage = UIAlertController(title: "", message: "Somthing wrong in interaction with server when request repositories" , preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                dialogMessage.addAction(ok)
                UIApplication.shared.windows.last?.rootViewController?.present(dialogMessage, animated: true)
                return }
            self.repoResponse = response
            self.notify(data: response)
        }
    }
    //observer
    var state: Int = { return Int(arc4random_uniform(10)) }()
    
    private lazy var observers = [RepoRequestObserver]()
    
    func attach(_ observer: RepoRequestObserver) {
        observers.append(observer)
    }
    
    func detach(_ observer: RepoRequestObserver) {
        observers = observers.filter({$0.id != observer.id})
    }
    
    func notify(data: Repos) {
        observers.forEach({ $0.updateRepo(data: data)})
    }
    
}
