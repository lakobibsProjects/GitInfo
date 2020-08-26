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
    private var currentPage = 0
    private var isLoadData = false
    
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
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("hideKeyboard")))
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.view.backgroundColor = AppColor.superviewBackgroundColor
        backgroungImageView = UIImageView()
        
        navigationBar = UIView()
        
        statusBarView = UIView()
        
        navigationView = UIView()
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(32)
        titleLabel.text = "GitInfo"
        titleLabel.textColor = AppColor.labelTextColor
        titleLabel.backgroundColor = AppColor.labelBackgroundColor
        
        searchView = UIView()
        searchLabel = UILabel()
        searchLabel.text = "Login:"
        searchLabel.textColor = AppColor.labelTextColor
        searchLabel.backgroundColor = AppColor.labelBackgroundColor
        searchTextField = UITextField()
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 4
        searchTextField.delegate = self
        searchTextField.textColor = AppColor.textFieldTextColor
        searchTextField.backgroundColor = AppColor.textFieldBackgroundColor
        searchTextField.layer.borderColor = AppColor.bordersGeneralColor.cgColor
        searchButton =  UIButton()
        searchButton.layer.borderWidth = 1
        searchButton.layer.cornerRadius = 4
        searchButton.addTarget(self, action: #selector(searchButtonClick), for: .touchUpInside)
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        searchButton.layer.borderColor = AppColor.bordersGeneralColor.cgColor
        
        accountsTableView = UITableView()
        accountsTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.backgroundColor = AppColor.white00
        accountsTableView.allowsSelection = true
        accountsTableView.isUserInteractionEnabled = true
        vm.accountSearchResult.bind(to: accountsTableView, cellType: AccountTableViewCell.self){ (cell, acc) in
            cell.setProductData(account: acc)
        }
        
        if #available(iOS 13, *),  overrideUserInterfaceStyle  == .dark {
            setDarkTheme()
        } else {
            setWhiteTheme()
        }
        
    }
    
    //MARK: -Assistant functions
    private func setWhiteTheme(){
        backgroungImageView.image = UIImage(named: "logoWhite")
        searchButton.setImage(UIImage(named: "searchWhite"), for: .normal)
    }
    
    private func setDarkTheme(){
        backgroungImageView.image = UIImage(named: "logoBlack")
        searchButton.setImage(UIImage(named: "searchBlack"), for: .normal)
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
    
    //MARK: Event Handlers
    @objc func searchButtonClick(){
        if let name = searchTextField.text{
            self.searchTextField.endEditing(false)
            if !name.isEmpty{
                DispatchQueue.main.async {
                    self.currentPage = 1
                    self.accountsTableView.beginUpdates()
                    self.vm.initializeData(name: name)
                    self.accountsTableView.endUpdates()
                    print("\(self.vm.accountSearchResult.count)")
                    print("\(self.accountsTableView.numberOfRows(inSection: 0))")                    
                }
            }
        }
    }
}

//MARK: - TableView delegate and dataSource
extension SearchAccountViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.accountSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        let account = vm.accountSearchResult[indexPath.section]
        
        cell.setProductData(account: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedAcc = vm.accountSearchResult[indexPath.row]
        
        if (!selectedAcc.login.isEmpty){
            coordinator?.accountDescriptionAlternate(user: vm.accountSearchResult[indexPath.row])
        }
        
        accountsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       DispatchQueue.main.async { self.isLoadData = true
        if self.isLoadData{
            let count = self.vm.accountSearchResult.count
            
            print(count)
            if indexPath.row == (count - 1) && indexPath.row < 20 {
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(144))
                self.currentPage += 1
                self.vm.apendData(name: self.searchTextField.text!, onPage: self.currentPage)
                self.accountsTableView.tableFooterView = spinner
            }
            self.isLoadData = false
        }
        }
    }
}

//MARK: -TextFiewld delegate
extension SearchAccountViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.addGestureRecognizer(tap)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.removeGestureRecognizer(tap)
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
            $0.height.width.equalTo(28)
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
