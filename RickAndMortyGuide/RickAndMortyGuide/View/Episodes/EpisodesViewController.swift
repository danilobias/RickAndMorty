//
//  EpisodesViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 28/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseUI

class EpisodesViewController: BaseTableViewController {
    
    // MARK: - Lets and Vars
    var episodesViewModel: EpisodesViewModel? {
        didSet {
            episodesViewModel?.responseDidChange = { [weak self] viewModel in
                self?.reloadTableViewWithAnimation()
            }
        }
    }
    
    var storage: Storage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showLoading()
        self.episodesViewModel = EpisodesViewModel()
        self.makeEpisodesRequest(firstPage: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.storage = Storage.storage()
    }
    
    // MARK: - Get Info
    func makeEpisodesRequest(firstPage: Bool ) {
        
        self.episodesViewModel?.getElement(firstPage: firstPage, completion: { (error) in
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
        self.episodesViewModel?.searchElement(firstPage: firstPage, params: params, completion: { (error) in
            
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
    
    // MARK: - Utils
    override func verifyIfHasNextPage() {
        if self.episodesViewModel?.hasNextPage() == nil {
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

extension EpisodesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodesViewModel?.numberOfRows() ?? 0
    }
}

extension EpisodesViewController: UITableViewDelegate {
    
    // MARK: - UITableView Datasource & Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: EpisodesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EpisodesTableViewCell", for: indexPath) as! EpisodesTableViewCell
        if let episodeResult: EpisodeResult = episodesViewModel?.getEpisodeResponseBy(index: indexPath.row) {
            cell.showEpisodeInfo(episode: episodeResult, firebaseStorage: self.storage)
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
                self.makeEpisodesRequest(firstPage: false)
            }else {
                self.makeSearchRequest(firstPage: false, term: self.currentSearchTerm)
            }
        }
    }
}
