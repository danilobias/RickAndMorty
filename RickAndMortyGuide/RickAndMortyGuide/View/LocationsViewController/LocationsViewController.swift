//
//  LocationsViewController.swift
//  RickAndMortyGuide
//
//  Created by Danilo Bias Lago on 28/11/2018.
//  Copyright © 2018 Danilo Bias Lago. All rights reserved.
//

import UIKit
import FirebaseStorage
import AXPhotoViewer

class LocationsViewController: BaseTableViewController {
    
    // MARK: - Lets and Vars
    var locationsViewModel: LocationsViewModel? {
        didSet {
            locationsViewModel?.responseDidChange = { [weak self] viewModel in
                self?.reloadTableViewWithAnimation()
            }
        }
    }
    
    var storage: Storage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.showLoading()
        self.locationsViewModel = LocationsViewModel()
        self.makeLocationsRequest(firstPage: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.storage = Storage.storage()
    }
    
    // MARK: - Get Info
    func makeLocationsRequest(firstPage: Bool ) {
        
        self.locationsViewModel?.getElement(firstPage: firstPage, completion: { (error) in
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
        self.locationsViewModel?.searchElement(firstPage: firstPage, params: params, completion: { (error) in
            
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
        self.addFooterView()
        if self.filteredResults == false {
            self.makeLocationsRequest(firstPage: true)
        }else {
            self.makeSearchRequest(firstPage: true, term: self.currentSearchTerm)
        }
    }
    
    // MARK: - Utils
    override func verifyIfHasNextPage() {
        if self.locationsViewModel?.hasNextPage() == nil {
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

extension LocationsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsViewModel?.numberOfRows() ?? 0
    }
}

extension LocationsViewController: UITableViewDelegate {
    
    // MARK: - UITableView Datasource & Delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: LocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationTableViewCell
        if let locationResult: LocationResult = locationsViewModel?.getLocationResponseBy(index: indexPath.row) {
            cell.showLocationInfo(location: locationResult, firebaseStorage: self.storage)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let locationResult: LocationResult = locationsViewModel?.getLocationResponseBy(index: indexPath.row) {
            let dataSource = AXPhotosDataSource(photos: locationResult.photos)
            let photosViewController = AXPhotosViewController(dataSource: dataSource)
            self.present(photosViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPath.row == lastRowIndex - 1 {
            if self.filteredResults == false {
                self.makeLocationsRequest(firstPage: false)
            }else {
                self.makeSearchRequest(firstPage: false, term: self.currentSearchTerm)
            }
        }
    }
}
