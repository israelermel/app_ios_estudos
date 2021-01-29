//
//  SearchSavePetLocationMapViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 23/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import MapKit

public protocol SearchSavePetLocationMapDelegate: class {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    func searchBarSelectedLocation(_ coordinate: CLLocationCoordinate2D)
    func userLocationDidSelected()
}

class SearchSavePetLocationMapViewController: UIViewController  {

    weak var delegate: SearchSavePetLocationMapDelegate?
    
    lazy var searchCompleter : MKLocalSearchCompleter = {
        let sc = MKLocalSearchCompleter()
        sc.delegate = self
        return sc
    }()
    
    var searchResults = [MKLocalSearchCompletion]()
    
    var tableView: UITableView = UITableView()
    var searchBar : UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Informe uma cidade/endereço ou local"
        
        return sb
    }()
    
    override func loadView() {
        super.loadView()                
        view.backgroundColor = .white
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.isTranslucent = true
        searchBar.setSearchText(fontSize: 15.0)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
        searchBar.anchor(top: view.safeTopAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 44, paddingRight: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func updateLocationSelected(_ coordinate: CLLocationCoordinate2D) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
        delegate?.searchBarSelectedLocation(coordinate)
    }
    
    public func showHeader(animated: Bool) {
        changeHeader(height: 116.0, aniamted: animated)
    }

    public func hideHeader(animated: Bool) {
        changeHeader(height: 0.0, aniamted: animated)
    }
    
    private func changeHeader(height: CGFloat, aniamted: Bool) {
        guard let headerView = tableView.tableHeaderView, headerView.bounds.height != height else { return }
        if aniamted == false {
            updateHeader(height: height)
            return
        }
        tableView.beginUpdates()
        UIView.animate(withDuration: 0.25) {
            self.updateHeader(height: height)
        }
        tableView.endUpdates()
    }
    
    private func updateHeader(height: CGFloat) {
        guard let headerView = tableView.tableHeaderView else { return }
        var frame = headerView.frame
        frame.size.height = height
        tableView.tableHeaderView?.frame = frame
    }

    @objc
    func handleHeaderSectionDidSelected() {
        delegate?.userLocationDidSelected()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchSavePetLocationMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let searchResult = searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        let searchCompletion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: searchCompletion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if error == nil {
                guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
                self.updateLocationSelected(coordinate)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 90))
         let headerCell = tableView.dequeueReusableCell(withIdentifier: "cell")
         headerCell?.textLabel?.text = "Buscar pelo sua localizacao"
         headerCell?.frame = headerView.bounds
         headerView.addSubview(headerCell!)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleHeaderSectionDidSelected))
        headerView.addGestureRecognizer(tap)
        
         return headerView
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchSavePetLocationMapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
        if #available(iOS 13.0, *) {
            searchCompleter.resultTypes = .query
        } else {
            searchCompleter.filterType = .locationsAndQueries
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton  = false
        delegate?.searchBarCancelButtonClicked(searchBar)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        delegate?.searchBarTextDidBeginEditing(searchBar)
    }
}

// MARK: - Config UISearchBar
extension UISearchBar {
    func setSearchText(fontSize: CGFloat) {
        if #available(iOS 13, *) {
            let font = searchTextField.font
            searchTextField.font = font?.withSize(fontSize)
        } else {
            let textField = value(forKey: "_searchField") as! UITextField
            textField.font = textField.font?.withSize(fontSize)
        }
    }
}

// MARK: - MKLocalSearchCompleterDelegate
extension SearchSavePetLocationMapViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        let results = completer.results
        
        let filteredResults = results.filter { searchCompleter in
            return searchCompleter.subtitle.localizedCaseInsensitiveContains("brazil") || searchCompleter.subtitle.localizedCaseInsensitiveContains("brasil") ||
            searchCompleter.title.localizedCaseInsensitiveContains("brazil") || searchCompleter.title.localizedCaseInsensitiveContains("brasil")
        }
        
        
        if !completer.isSearching {
            debugPrint("DEBUG: isSearching = \(completer.isSearching)")
            searchResults = filteredResults
            tableView.reloadData()
        }
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handler error
        if completer.queryFragment.isEmpty {
            searchResults.removeAll()
            tableView.reloadData()
        }
    }
        
}
