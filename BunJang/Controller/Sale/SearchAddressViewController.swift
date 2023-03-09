//
//  SearchAddressViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/09.
//

import UIKit
import MapKit
import CoreLocation
protocol SearchAddressViewDelegate: AnyObject {
    func SendAddress(_ data :String?)
}
class SearchAddressViewController: UIViewController, MKLocalSearchCompleterDelegate {
    
    weak var delegate: SearchAddressViewDelegate?

    let searchBar = UISearchBar()
    var sendAd :String?
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var BGImg: UIImageView!

    @IBOutlet weak var SearchBar: UISearchBar!
    private var searchCompleter: MKLocalSearchCompleter?
        private var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
        var completerResults: [MKLocalSearchCompletion]?

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            completerResults = completer.results
            TableView.reloadData()
        }
        
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            if let error = error as NSError? {
                print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(completer.queryFragment)\"")
            }
        }
    @IBAction func GoBack(_ sender: Any) {
        self.delegate?.SendAddress(self.sendAd)

        
        self.dismiss(animated: false)
        
    }
    private func configureSearchBar() {
        self.searchBar.delegate = self
        
        //navigation bar - add search bar
        searchBar.placeholder = "검색어를 입력해 주세요"
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 250/255, alpha: 1.0)
        searchBar.searchTextField.font = .systemFont(ofSize: 15, weight: .semibold)
        searchBar.searchTextField.tintColor =  UIColor(red: 203/255, green: 204/255, blue: 203/255, alpha: 1.0)
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        self.navigationItem.titleView = searchBar
        SearchBar.delegate = self
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
         searchCompleter?.resultTypes = .address
        searchCompleter?.region = searchRegion
        TableView.dataSource = self
        TableView.delegate = self
        TableView.register(UINib(nibName: "SearchAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchAddressTableViewCell")
    }
    
}
extension SearchAddressViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            completerResults = nil
        }
        BGImg.isHidden = true

        searchCompleter?.queryFragment = searchText
       // print(searchText)
    }
}
extension SearchAddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchAddressTableViewCell") as? SearchAddressTableViewCell else { return UITableViewCell()}
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        if let suggestion = completerResults?[indexPath.row] {
            cell.Label.text = suggestion.title
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let suggestion = completerResults?[indexPath.row]
        let str:String = suggestion!.title
        let startIdx:String.Index = str.index(str.startIndex, offsetBy: 5)
        sendAd = String(str[startIdx...])
        self.delegate?.SendAddress(self.sendAd)
        self.dismiss(animated: false)

    }
    
    
}
