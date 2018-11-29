//
//  CardSearchViewController.swift
//  Cards
//
//  Created by Bern on 27.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift
import SDWebImage

class CardSearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var cardTrackerModel: CardTrackerModel!
    var latestCardName: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCardsView()
    }
    
    func setupCardsView() {
        cardTrackerModel = CardTrackerModel(provider: MoyaProvider(),cardName: latestCardName)
        
        cardTrackerModel
            .trackCards()
            .filterNil()
            .bind(to: self.tableView.rx.items(cellIdentifier: "cardCell", cellType: CardCell.self)) { (row, element, cell) in
                cell.setModel(card: element)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension CardSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
