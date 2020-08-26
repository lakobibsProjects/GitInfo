//
//  AccountTableViewCell.swift
//  GitInfo
//
//  Created by user166683 on 8/22/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import UIKit
import SnapKit

class AccountTableViewCell: UITableViewCell {
    private var account: SearchedAccount?
    
    let avaImageView = UIImageView()
    let nameLabel = UILabel()
    let typeImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func setup(){
        initViews()
        setupViews()
        setupConstraints()
    }
    
    
    private func initViews(){
        self.backgroundColor = AppColor.superviewBackgroundColor
    }
    
    func setProductData(account: SearchedAccount){
        self.account = account
        if let url = URL(string: account.avatarURL){
            self.avaImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "photoPlaceholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
            ])
        }
        
        self.nameLabel.text = account.login
        
        
        if #available(iOS 13, *) {
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
    
    private func setAccountImage(type: AccountType){
        switch type{
        case .organization:
            self.typeImageView.image = UIImage(named: "companyWhite")
        case .user:
            self.typeImageView.image = UIImage(named: "userWhite")
        }
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
    
    private func setWhiteTheme(){
        if let acc = self.account{
            switch acc.type{
            case .organization:
                self.typeImageView.image = UIImage(named: "companyWhite")
            case .user:
                self.typeImageView.image = UIImage(named: "userWhite")
            }
        }
    }
    
    private func setDarkTheme(){
        if let acc = self.account{
            switch acc.type{
            case .organization:
                self.typeImageView.image = UIImage(named: "companyBlack")
            case .user:
                self.typeImageView.image = UIImage(named: "userBlack")
            }
        }
    }
    
    @objc func onTap(){
        
    }
    
    private func setupViews(){
        self.addSubview(avaImageView)
        self.addSubview(nameLabel)
        self.addSubview(typeImageView)
    }
    
    private func setupConstraints(){
        avaImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.leading.equalToSuperview().inset(16)
        })
        
        nameLabel.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(56)
        })
        
        typeImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.trailing.equalToSuperview().inset(16)
        })
    }
    
}
