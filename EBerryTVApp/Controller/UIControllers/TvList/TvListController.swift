//
//  ViewController.swift
//  EBerryTVApp
//
//  Created by Mehmet Can Seyhan on 2019-09-12.
//  Copyright © 2019 Mehmet Can Seyhan. All rights reserved.
//

import UIKit
import Alamofire

class TvListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //MARK: IBOutlets
    @IBOutlet var activityIndicatorTvList: UIActivityIndicatorView!
    @IBOutlet var tableViewTVList: UITableView!
    
    //MARK: Variables
    var tvListModel:[TvListModel]?
    var filterTvListModel:[TvListModel]?
    
    //MARK: Constants
    let TV_CELL_IDENTIFIER:String = "TvListCell"
    let FROM_TV_LIST_TO_TV_LIST_DETAIL:String = "fromTvListToTvListDetailIdentifier"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: TEMP VARIABLES
    var tvName:String?
    var tvDescritpion:String?
    var tvImageUrl:String?

    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setTableView()
        addSeacrhBar()
        checkInternetConnectionAndGetData()
        setFirstValues()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentTvListModel = tvListModel else { return 0 }
        return currentTvListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TV_CELL_IDENTIFIER) as! TvListCell
        cell.cellConfiguretion(tvListModel: tvListModel![indexPath.row], indexPathRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tvName = tvListModel![indexPath.row].show?.name
        self.tvDescritpion = Helper.replaceContent(text: tvListModel![indexPath.row].show?.summary)
        self.tvImageUrl = tvListModel![indexPath.row].show?.image?.medium
        performSegue(withIdentifier: FROM_TV_LIST_TO_TV_LIST_DETAIL, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FROM_TV_LIST_TO_TV_LIST_DETAIL {
            let listDetailVC = segue.destination as! TvListDetailController
            listDetailVC.lblName = self.tvName
            listDetailVC.lblDesctiption = self.tvDescritpion
            listDetailVC.imageViewUrl = self.tvImageUrl
        }
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        guard let text = searchController.searchBar.text else { return }
        let searchText = text.lowercased()
        if !text.isEmpty && filterTvListModel != nil {
            self.tvListModel = filterTvListModel!.filter({ ($0.show?.name!.lowercased().contains(searchText))! })
        } else {
             self.tvListModel = filterTvListModel
        }
        self.tableViewTVList.reloadData()
        
    }

    //Get data from server after checking internet connection
    func checkInternetConnectionAndGetData() {
        if InternetController.isConnectedToNetwork() {
            self.getData(url: Services.SHOW_SEARCH + "girls")
        } else {
            Helper.dialogMessage(message: "Please check you internet connection", vc: self)
            self.activityIndicatorTvList.stopAnimating()
        }
    }
    
    //Get all films data from server and set your model
    func getData(url: String) {
        Alamofire.request(url).responseJSON { (dataResponse) in
            if dataResponse.result.isSuccess {
                do {
                    self.tvListModel = try JSONDecoder().decode([TvListModel].self, from: dataResponse.data!)
                    self.setData()
                } catch {
                    Helper.dialogMessage(message: error.localizedDescription, vc: self)
                }
            } else {
                Helper.dialogMessage(message: "Your service request isn't successfull", vc: self)
            }
        }
    }
    
    //set ui element data which incoming
    func setData() {
        filterTvListModel = tvListModel
        activityIndicatorTvList.stopAnimating()
        tableViewTVList.reloadData()
    }
    
    // Setup the Search Controller
    func addSeacrhBar() {
       // navigationItem.searchController = searchController
        tableViewTVList.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Shows..."
        definesPresentationContext = true
       /* searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.red*/
    }
    
    //Setup table view contents
    func setTableView() {
        tableViewTVList.rowHeight = UITableView.automaticDimension
        tableViewTVList.estimatedRowHeight = tableViewTVList.rowHeight
        tableViewTVList.tableFooterView = UIView()
    }
    
    //set first cons value to super view
    func setFirstValues() {
        title = "TV Shows"
    }
    
}

