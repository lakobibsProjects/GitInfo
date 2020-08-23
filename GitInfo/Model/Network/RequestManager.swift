
//
//  RequestManager.swift
//  GitInfo
//
//  Created by user166683 on 8/20/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager{
    let dafaultBeginURL = "https://api.github.com"
    let generalAcceptHeader = "application/vnd.github.v3+json"
    let searchForNameMiddleURL = "/search/users?q="
    var usersResponse: Welcome?
    
    private init(){
        
    }
    
    static var shared: RequestManager = {
        let instance = RequestManager()
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
            }
            print("\(self.usersResponse == nil)")
        }
    }
    
}
