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
    
    var reposTableView: UITableView!
    
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
        self.view.backgroundColor = AppColor.superviewBackgroundColor
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
        titleLabel.textColor = AppColor.labelTextColor
        
        contentView = UIView()
        avaImageView = UIImageView()
        nameLabel = UILabel()
        nameLabel.bind(signal: .init(just: vm.name))
        nameLabel.textColor = AppColor.labelTextColor
        loginLabel = UILabel()
        loginLabel.bind(signal: .init(just: vm.login))
        loginLabel.textColor = AppColor.labelTextColor
        creationDateLabel = UILabel()
        creationDateLabel.bind(signal: .init(just: vm.creationDate))
        creationDateLabel.textColor = AppColor.labelTextColor
        locationLabel = UILabel()
        locationLabel.bind(signal: .init(just: vm.location))
        locationLabel.textColor = AppColor.labelTextColor
        
        avaImageView.bind(signal: .init(just: vm.ava))
        
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
        reposTableView = UITableView()
        reposTableView.rowHeight = UITableView.automaticDimension
        reposTableView.estimatedRowHeight = 44
        reposTableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "RepoTableViewCell")
        
        
        if #available(iOS 13, *), overrideUserInterfaceStyle  == .dark {
          setDarkTheme()
            
        } else {
            setWhiteTheme()
        }
        
    }
    
    //MARK: Assistant functions
    private func setWhiteTheme(){
        backgroungImageView.image = UIImage(named: "logoWhite")
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)
    }
    
    private func setDarkTheme(){
        backgroungImageView.image = UIImage(named: "logoWhite")
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                setDarkTheme()
            }
            else {
                setWhiteTheme()
            }
        } else {
            setWhiteTheme()
        }
    }
    
    //MARK: Event handlers
    @objc func popToRoot(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension AccountDescriptionViewController: UITableViewDelegate, UITableViewDataSource, ExpandableCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expandableCell", for: indexPath) as! RepoTableViewCell
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RepoTableViewCell {
            cell.isExpanded = true
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RepoTableViewCell {
            cell.isExpanded = false
        }
    }

    func expandableCellLayoutChanged(_ expandableCell: RepoTableViewCell) {
        refreshTableAfterCellExpansion()
    }

    func refreshTableAfterCellExpansion() {
        self.reposTableView.beginUpdates()
        self.reposTableView.setNeedsDisplay()
        self.reposTableView.endUpdates()
    }
}


//MARK: -Layout
extension AccountDescriptionViewController{
    private func setupViews(){
        //self.view.addSubview(backgroungImageView)
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
        /*backgroungImageView.snp.makeConstraints({
            $0.width.centerX.centerY.equalToSuperview().inset(16)
            $0.height.equalTo(backgroungImageView.snp.width)
        })*/
        
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
