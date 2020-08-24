
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
    
    func accounDescription(accId: Int){
        let vc = AccountDescriptionViewController.instantiateFromStoryboard()
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: true)
    }
    

}
