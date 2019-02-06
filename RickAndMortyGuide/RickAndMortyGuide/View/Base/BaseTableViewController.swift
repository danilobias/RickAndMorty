//
//  BaseTableViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 05/02/2019.
//  Copyright © 2019 Danilo Bias Lago. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var  tableView: UITableView!
    
    // MARK: - Lets and Vars
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BaseTableViewController.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var filteredResults: Bool = false
    var currentSearchTerm: String = ""
    
    let search = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureTableView()
        self.configureSearchBar()
    }
    
    // MARK: - Layout
    func configureSearchBar() {
        self.search.searchBar.delegate = self
        self.search.hidesNavigationBarDuringPresentation = true;
        self.search.dimsBackgroundDuringPresentation = false
        self.search.searchBar.tintColor = UIColor.white
        
        self.navigationItem.searchController = self.search
        self.definesPresentationContext = true;
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    func configureTableView() {
        self.tableView.isHidden = true
        self.tableView.addSubview(self.refreshControl)
        self.addFooterView()
    }
    
    func addFooterView(){
        if let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FooterViewCell") {
            self.tableView.tableFooterView = cell.contentView
        }
    }

    // MARK: - Pull To Refresh
    @objc func handleRefresh(_ refreshControl: UIRefreshControl?) {
        self.addFooterView()
    }
    
    
    // MARK: - Utils
    func reloadTableViewWithAnimation() {
        self.hideLoading()
        self.refreshControl.endRefreshing()
        self.tableView.isHidden = false
        self.verifyIfHasNextPage()
    }
    
    func verifyIfHasNextPage() {}
    
    // MARK: - Requests
    func makeSearchRequest(firstPage: Bool, term: String) {
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension BaseTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}

extension BaseTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() //hide keyboard
        
        if let text = searchBar.text, !text.isEmpty {
            super.showLoading()
            self.currentSearchTerm = text
            self.makeSearchRequest(firstPage: true, term: text)
        }
        else {
            super.showLoading()
            self.currentSearchTerm = ""
            self.handleRefresh(nil)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        super.showLoading()
        self.currentSearchTerm = ""
        self.handleRefresh(nil)
    }
}
