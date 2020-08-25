
//
//  MainCoordinator.swift
//  GitInfo
//
//  Created by user166683 on 8/19/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import Foundation

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        navigationController.delegate = self
        let vc = SearchAccountViewController.instantiate()
        vc.coordinator = self
        //vc.vm = SearchAccountViewModel()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func accounDescription(login: String, isUser: Bool){
        let vc = AccountDescriptionViewController.instantiate()
        vc.coordinator = self
        AccountRequestManager.shared.getUserByLogin(login: login)
        RepoRequestManager.shared.getReposByLogin(login: login, isUser: isUser)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func accountDescriptionAlternate(user: SearchedAccount){
        let vc = AccountDescriptionViewController.instantiate()
        vc.coordinator = self
        vc.vm.avaURL = user.avatarURL
        let url = NSURL(string: user.avatarURL)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            vc.vm.ava = UIImage(data: imageData as Data)
        }
        vc.vm.login = "Login: \(user.login)"
        AccountRequestManager.shared.getUserByURL(URL: user.url)
        RepoRequestManager.shared.getReposByURL(URL: user.reposURL)
        navigationController.pushViewController(vc, animated: true)
    }
    

}
