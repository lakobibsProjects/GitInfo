
//
//  AccountDescriptionViewModel.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation
import UIKit

class AccountDescriptionViewModel: AccountByLoginRequestObserver{
    var id: Int = 1
    var login: String?
    //var user: UserByLogin?
    var avaURL = ""
    var ava = UIImage(named: "photoPlaceholder")
    var name = ""
    var creationDate = ""
    var location = ""
    
    func update(user: UserByLogin) {
        //self.user = user
        avaURL = user.avatarURL ?? ""
        let url = NSURL(string: avaURL)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            ava = UIImage(data: imageData as Data)
        }        
        name = "Name: \(user.name ?? "")"
        //login = "Login: \(user.login ?? "")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        creationDate = "Name: \(dateFormatter.string(from: user.createdAt ?? Date.init(timeIntervalSince1970: 0)))"
        
        location = "Location: \(user.location ?? "unknow")"
    }
    
}
