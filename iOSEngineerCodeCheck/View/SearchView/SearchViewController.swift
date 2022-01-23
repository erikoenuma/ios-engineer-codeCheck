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
                let vc = DetailViewController.configure(repository: item.repository)
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        // エラーメッセージ表示
        viewModel?.output.showError
            .subscribe(onNext: { [weak self] error in
                self?.showErrorMessage(of: error)
            })
            .disposed(by: disposeBag)
    }
}
