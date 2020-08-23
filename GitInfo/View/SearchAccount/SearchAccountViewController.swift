//
//  SearchAccountViewController.swift
//  GitInfo
//
//  Created by user166683 on 8/19/20.
//  Copyright © 2020 Lakobib. All rights reserved.
//

import UIKit
import Kingfisher

class SearchAccountViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?    
    var vm = SearchAccountViewModel()
    
    var backgroungImageView: UIImageView!
    
    var navigationBar:UIView!
    
    var statusBarView: UIView!
    
    var navigationView: UIView!
    var titleLabel: UILabel!
    
    var searchView: UIView!
    var searchLabel: UILabel!
    var searchTextField: UITextField!
    var searchButton: UIButton!
    
    var accountsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("hideKeyboard")))
        view.addGestureRecognizer(tap)
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        
        searchView = UIView()
        searchLabel = UILabel()
        searchLabel.text = "GitInfo"
        searchTextField = UITextField()
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 4
        searchButton =  UIButton()
        searchButton.layer.borderWidth = 1
        searchButton.layer.cornerRadius = 4
        searchButton.addTarget(self, action: #selector(searchButtonClick), for: .touchUpInside)
        
        accountsTableView = UITableView()
        accountsTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.backgroundColor = AppColor.white00
        accountsTableView.allowsSelection = true
        accountsTableView.isUserInteractionEnabled = true
        vm.tableContentDataSouce.bind(to: accountsTableView, cellType: AccountTableViewCell.self){ (cell, acc) in
            cell.setProductData(account: acc)
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
        
        titleLabel.text = "GitInfo"
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        
        
        searchLabel.textColor = .black
        searchLabel.backgroundColor = .white
        
        searchTextField.textColor = .black
        searchTextField.backgroundColor = .white
        searchTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        searchButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        searchButton.setImage(UIImage(named: "searchWhite"), for: .normal)
    }
    
    //MARK: Event Handlers
    @objc func searchButtonClick(){
        if let name = searchTextField.text{
            if !name.isEmpty{
                DispatchQueue.main.async {
                    self.accountsTableView.beginUpdates()
                    self.vm.initializeData(name: name)
                    self.accountsTableView.endUpdates()
                    print("\(self.vm.tableContentDataSouce.count)")
                    print("\(self.accountsTableView.numberOfRows(inSection: 0))")
                    //accountsTableView.reloadData()
                }
                
            }
        }
    }
}

//MARK: - TableView delegate and dataSource
extension SearchAccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.tableContentDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        let account = vm.tableContentDataSouce[indexPath.section]
        
        cell.setProductData(account: account)
        
        return cell
    }
    
    
}

//MARK: -Layout
extension SearchAccountViewController{
    private func setupViews(){
        self.view.addSubview(backgroungImageView)
        self.view.addSubview(navigationBar)
        self.view.addSubview(searchView)
        self.view.addSubview(accountsTableView)
        
        navigationBar.addSubview(statusBarView)
        navigationBar.addSubview(navigationView)
        
        navigationView.addSubview(titleLabel)
        
        searchView.addSubview(searchTextField)
        searchView.addSubview(searchButton)
        searchView.addSubview(searchLabel)
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
        
        searchView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(navigationBar.snp.bottom).offset(8)
            $0.height.equalTo(32)
        })
        
        searchTextField.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(36)
        })
        
        searchButton.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.width.equalTo(24)
        })
        
        accountsTableView.snp.makeConstraints({
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(searchView.snp.bottom).offset(8)
        })
    }
}

//MARK: -Keyboard interaction
extension SearchAccountViewController{
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}
