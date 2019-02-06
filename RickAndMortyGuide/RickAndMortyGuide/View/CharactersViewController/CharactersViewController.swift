//
//  CharactersViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 19/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import RevealingSplashView

class CharactersViewController: BaseTableViewController {
    
    // MARK: - Lets and Vars
    var charactersViewModel: CharactersViewModel? {
        didSet {
            charactersViewModel?.responseDidChange = { [weak self] viewModel in
                self?.reloadTableViewWithAnimation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showSplash()
    }
    
    // MARK: - Layout
    func showSplash() {
        // Do any additional setup after loading the view.
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "splash_v1")!,
                                                      iconInitialSize: CGSize(width: 112, height: 112),
                                                      backgroundColor: UIColor.white)
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.animationType = SplashAnimationType.squeezeAndZoomOut
        
        //Starts animation
        revealingSplashView.startAnimation(){
            print("Completed")
            self.showLoading()
            self.configureLayout()
            self.charactersViewModel = CharactersViewModel()
            self.makePeopleRequest(firstPage: true)
        }
    }
    
    func configureLayout() {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Get Info
    func makePeopleRequest(firstPage: Bool ) {
        
        self.charactersViewModel?.getElement(firstPage: firstPage, completion: { (error) in
            self.hideLoading()
            self.refreshControl.endRefreshing()
            
            if let errorDetail = error {
                //TO-DO
                //Add placeholder to tableview
                print("-->> Error get people [VC]: \(errorDetail)")
                self.showAlert(title: "Desculpe..." , message: errorDetail.localizedDescription)
            }
        })
    }
    
    override func makeSearchRequest(firstPage: Bool, term: String) {
        
        let params: [String: Any] = ["name": term]
        self.charactersViewModel?.searchElement(firstPage: firstPage, params: params, completion: { (error) in
            
            self.hideLoading()
            self.refreshControl.endRefreshing()
            
            if let errorDetail = error {
                //TO-DO
                //Add placeholder to tableview
                print("-->> Error get people [VC]: \(errorDetail)")
                self.showAlert(title: "Desculpe..." , message: errorDetail.localizedDescription)
            }
        })
    }
    
    // MARK: - Pull to Refresh
    @objc override func handleRefresh(_ refreshControl: UIRefreshControl?) {
        super.handleRefresh(refreshControl)
        if self.filteredResults == false {
            self.makePeopleRequest(firstPage: true)
        }else {
            self.makeSearchRequest(firstPage: true, term: self.currentSearchTerm)
        }
    }
    
    // MARK: - Utils
    override func verifyIfHasNextPage() {
        if self.charactersViewModel?.hasNextPage() == nil {
            self.tableView.tableFooterView = nil
        }else if self.tableView.tableFooterView == nil {
            self.addFooterView()
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewModel?.numberOfRows() ?? 0
    }
}

extension CharactersViewController: UITableViewDelegate {
    
    // MARK: - UITableView Datasource & Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CharactersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CharactersTableViewCell", for: indexPath) as! CharactersTableViewCell
        let characterResult: CharacterResult? = charactersViewModel?.getCharacterResponseBy(index: indexPath.row)
        cell.character = characterResult
        
        if let cardContent = storyboard?.instantiateViewController(withIdentifier: "CharacterCardContent") as? CharacterDetailsViewController {
            cardContent.character = characterResult
            cardContent.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 400)
            cell.card.shouldPresent(cardContent, from: self, fullscreen: true)            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPath.row == lastRowIndex - 1 {
            if self.filteredResults == false {
                self.makePeopleRequest(firstPage: false)
            }else {
                self.makeSearchRequest(firstPage: false, term: self.currentSearchTerm)
            }
        }
    }
}
