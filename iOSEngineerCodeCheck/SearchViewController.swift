//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var repositories: [RepositoryCodable] = []
    private var task: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchWord = searchBar.text,
              !searchWord.isEmpty,
              let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        else {
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data,
                  let searchResult = try? JSONDecoder().decode(SearchResultCodable.self, from: data)
            else {
                return
            }
            self?.repositories = searchResult.items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task?.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController,
           let repository = sender as? RepositoryCodable {
            vc.repository = repository
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language ?? "-"
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "Detail", sender: repositories[indexPath.row])
    }
}
