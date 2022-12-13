//
//  SearchViewController.swift
//  Odla KBZ
//
//  Created by Kevin Zetterlind on 2022-09-09.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    @IBOutlet var closeVCButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var data = ["Gul Paprika", "Äpple", "Apelsin", "Päron", "Tomat"]
    var filteredData: [String] = []
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewAndVcDetails()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadTableData, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if navigationController?.presentingViewController != nil {
            self.navigationItem.leftBarButtonItem = self.closeVCButton
        }
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        print("WORKING")
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        searchController.searchBar.becomeFirstResponder()
    }
    
    
    func tableViewAndVcDetails() {
        self.navigationItem.leftBarButtonItem = nil
        filteredData = data
        
        let nib = UINib(nibName: "SearchCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
    }
    
    @objc func reloadTableData(_ notification: Notification) {
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        }
        
        for word in data {
            if word.uppercased().contains(searchText.uppercased()) {
                filteredData.append(word)
            }
        }
        
        self.tableView.reloadData()
        
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.plantName.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select \(indexPath.row)")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "addplantVC") as? AddPlantViewController else {return}

        vc.textForLabel = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}



 extension Notification.Name{
 
    static let reloadTableData = Notification.Name("reloadTableData")
 
}
