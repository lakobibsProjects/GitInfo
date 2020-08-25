
//
//  RepoTableViewCell.swift
//  GitInfo
//
//  Created by user166683 on 8/25/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    weak var delegate: ExpandableCellDelegate?

    fileprivate let stack = UIStackView()
    fileprivate let topView = UIView()
    fileprivate let bottomView = UIView()
    
    let nameLabel = UILabel()
    let languageLabel = UILabel()
    let updateDateLabel = UILabel()
    let starsLabel = UILabel()

    var isExpanded: Bool = false {
        didSet {
            bottomView.isHidden = !isExpanded
            delegate?.expandableCellLayoutChanged(self)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(){
        initViews()
        setupViews()
        setupContraints()
    }
    
    func initViews(){
        stack.addArrangedSubview(topView)
        stack.addArrangedSubview(bottomView)
        stack.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0

        bottomView.isHidden = true
    }
    
    func setRepoData(account: RepoResponse){
    
    }
    
    func setupViews(){
        contentView.addSubview(stack)
        
        topView.addSubview(nameLabel)
        topView.addSubview(languageLabel)
        
        bottomView.addSubview(updateDateLabel)
        bottomView.addSubview(starsLabel)
    }
    
    func setupContraints(){
        stack.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        topView.snp.makeConstraints({
            $0.height.equalTo(60)
        })
        
        bottomView.snp.makeConstraints({
            $0.height.equalTo(60)
        })
        
        nameLabel.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(4)
        })
        
        languageLabel.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
        })
        
        updateDateLabel.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(4)
        })
        
        starsLabel.snp.makeConstraints({
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
        })
    }
}

protocol ExpandableCellDelegate: class {
    func expandableCellLayoutChanged(_ expandableCell: RepoTableViewCell)
}
