//
//  AccountDescriptionViewController.swift
//  GitInfo
//
//  Created by user166683 on 8/23/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import UIKit
import Bond

class AccountDescriptionViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    var vm = AccountDescriptionViewModel()
    
    
    var backgroungImageView: UIImageView!
    
    var navigationBar:UIView!
    
    var statusBarView: UIView!
    
    var navigationView: UIView!
    var backButton: UIButton!
    var titleLabel: UILabel!
    
    var contentView: UIView!
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
        
        backButton = UIButton()
        
        backButton.addTarget(self, action: #selector(popToRoot), for: .touchUpInside)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(32)
        titleLabel.text = "GitInfo"
        
        contentView = UIView()
        avaImageView = UIImageView()
        nameLabel = UILabel()
        nameLabel.bind(signal: .init(just: vm.name))
        loginLabel = UILabel()
        loginLabel.bind(signal: .init(just: vm.login))
        creationDateLabel = UILabel()
        creationDateLabel.bind(signal: .init(just: vm.creationDate))
        locationLabel = UILabel()
        locationLabel.bind(signal: .init(just: vm.location))
        
        //avaImageView.bind(signal: .init(just: vm.ava))
        
        if let url = URL(string:vm.avaURL){
            self.avaImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "photoPlaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }

        
        
        
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
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)
        
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        
    }
    
    @objc func popToRoot(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: -Layout
extension AccountDescriptionViewController{
    private func setupViews(){
        self.view.addSubview(backgroungImageView)
        self.view.addSubview(navigationBar)
        self.view.addSubview(contentView)
        
        navigationBar.addSubview(statusBarView)
        navigationBar.addSubview(navigationView)
        
        navigationView.addSubview(backButton)
        navigationView.addSubview(titleLabel)
        
        contentView.addSubview(avaImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(loginLabel)
        contentView.addSubview(creationDateLabel)
        contentView.addSubview(locationLabel)
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
        
        backButton.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.height.equalTo(navigationView.snp.height).multipliedBy(0.5)
            $0.width.equalTo(backButton.snp.height)
        })
        
        titleLabel.snp.makeConstraints({$0.top.bottom.equalToSuperview()
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(6)
            $0.width.equalToSuperview().multipliedBy(0.75)
        })
        
        contentView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(navigationBar.snp.bottom).offset(8)
            $0.height.equalTo(132)
        })
        
        avaImageView.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(avaImageView.snp.width)
        })
        
        nameLabel.snp.makeConstraints({
            $0.leading.equalTo(avaImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.top.equalToSuperview().inset(4)
        })
        
        loginLabel.snp.makeConstraints({
            $0.leading.equalTo(avaImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        })
        
        creationDateLabel.snp.makeConstraints({
            $0.leading.equalTo(avaImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.top.equalTo(loginLabel.snp.bottom).offset(4)
        })
        
        locationLabel.snp.makeConstraints({
            $0.leading.equalTo(avaImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.top.equalTo(creationDateLabel.snp.bottom).offset(4)
        })
    }
}
