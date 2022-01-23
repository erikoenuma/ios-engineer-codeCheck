//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    private var repositories: [RepositoryCodable] = []
    private var viewModel: SearchViewModel?
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SearchViewModel(searchButtonTap: searchBar.rx.searchButtonClicked.asSignal())
        bindInputStream()
        bindOutputStream()
    }
    
    private func bindInputStream() {
        
        guard let viewModel = viewModel else {
            return
        }
        searchBar.rx.text
            .asObservable()
            .bind(to: viewModel.input.searchWordObserver)
            .disposed(by: disposeBag)
    }
    
    private func bindOutputStream() {
        
        // RxDataSources
        let dataSource = RxTableViewSectionedReloadDataSource<SearchResultSectionModel> { datasource, tableView, indexPath, item in
            let cell = UITableViewCell()
            cell.textLabel?.text = item.repository.fullName
            cell.detailTextLabel?.text = item.repository.language
            cell.tag = indexPath.row
            return cell
        }
        
        // tableViewにdataを流す
        viewModel?.output.dataRelay.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        // tableViewのセルをタップした時の処理
        tableView.rx.modelSelected(SearchResultCellModel.self)
            .subscribe(onNext: { [weak self] item in
                self?.performSegue(withIdentifier: "Detail", sender: item.repository)
            }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailViewController,
           let repository = sender as? RepositoryCodable {
            vc.repository = repository
        }
    }
}
