//
//  AccountDescriptionViewController.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import UIKit

class AccountDescriptionViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var vm = AccountDescriptionViewModel()
    
    
    var backgroungImageView: UIImageView!
    
    var navigationBar:UIView!
    
    var statusBarView: UIView!
    
    var navigationView: UIView!
    var titleLabel: UILabel!
    
    var contentVIew: UIView!
    var avaImageView: UIImageView!
    var nameLabel: UILabel!
    var loginLabel: UILabel!
    var creationDateLabel: UILabel!
    var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup(){
        initViews()
        setupViews()
        setupConstraints()
    }
    
    private func initViews(){
        self.view.backgroundColor = .white
        backgroungImageView = UIImageView()
        
        navigationBar = UIView()
        
        statusBarView = UIView()
        
        navigationView = UIView()
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(32)
        
        
        
        if #available(iOS 13, *) {
            
            if overrideUserInterfaceStyle  == .dark {
                
            } else {
                setWhiteTheme()
            }
            
        } else {
            setWhiteTheme()
        }
        
    }
    
    private func setWhiteTheme(){
        backgroungImageView.image = UIImage(named: "logoWhite")
        
        titleLabel.text = "GitInfo"
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        
    }
    
}


//MARK: -Layout
extension AccountDescriptionViewController{
    private func setupViews(){
        self.view.addSubview(backgroungImageView)
        self.view.addSubview(navigationBar)
        
        navigationBar.addSubview(statusBarView)
        navigationBar.addSubview(navigationView)
        
        navigationView.addSubview(titleLabel)
        
        
    }
    
    private func setupConstraints(){
        backgroungImageView.snp.makeConstraints({
            $0.width.centerX.centerY.equalToSuperview().inset(16)
            $0.height.equalTo(backgroungImageView.snp.width)
        })
        
        navigationBar.snp.makeConstraints({
            $0.trailing.leading.top.equalToSuperview()
            $0.height.equalTo(104)
        })
        
        statusBarView.snp.makeConstraints({
            $0.trailing.leading.top.equalToSuperview()
            $0.height.equalTo(40)
        })
        
        navigationView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
            $0.top.equalTo(statusBarView.snp.bottom)
        })
        
        titleLabel.snp.makeConstraints({$0.top.bottom.equalToSuperview()
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(6)
            $0.width.equalToSuperview().multipliedBy(0.75)
        })
        
        
    }
}
