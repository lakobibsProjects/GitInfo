
//
//  AccountDescriptionViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import UIKit

class AccountDescriptionViewModel: AccountByLoginRequestObserver, RepoRequestObserver{
    var id: Int = 1
    var login = "Login: "
    var avaURL = ""
    var ava = UIImage(named: "photoPlaceholder")
    var name = "Name: "
    var creationDate = "Creation date: "
    var location = "Location: "
    var repos = RepoResponse()
    
    init(){
        AccountRequestManager.shared.attach(self)
        RepoRequestManager.shared.attach(self)
    }
    
    func update(user: UserByLogin) {
        avaURL = user.avatarURL
        let url = NSURL(string: avaURL)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            ava = UIImage(data: imageData as Data)
        }        
        name = "Name: \(user.name ?? "")"
        login = "Login: \(user.login ?? "")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        creationDate = "Creation date: \(dateFormatter.string(from: user.createdAt ))"
        
        location = "Location: \(user.location)"
    }
    
    func updateRepo(data: RepoResponse) {
        repos = data
    }
    
}
