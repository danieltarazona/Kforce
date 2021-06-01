//
//  RSSFeedViewController.swift
//  Core
//
//  Created by Daniel Tarazona on 5/28/21.
//

import Foundation
import UIKit

class RSSFeedViewController: UIViewController {
    
    lazy var mainView: RSSFeedView = {
        let mainView = RSSFeedView().autolayout()
        return mainView
    }()
    
    lazy var presenter: GenericUITableViewPresenter<
        RSSFeedCategory,
        RSSFeedRequestObject,
        RSSFeed,
        Album,
        AlbumUITableViewCell,
        GenericUITableViewEmptyCell,
        UITableViewHeaderFooterView
    > = {
        return GenericUITableViewPresenter(
            uiViewController: self,
            uiTableView: mainView.tableView,
            keyPath: \RSSFeed.feed?.albums
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        view.addSubview(mainView)
        view.backgroundColor = .black
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension RSSFeedViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let album = presenter.cellItem(at: indexPath) {
            let cell = presenter.cellRowAt(indexPath: indexPath)
            cell?.viewModel = AlbumUITableViewCellModel(
                title: album.name ?? "",
                artistName: album.artistName ?? "",
                imageURL: album.artworkUrl100
            )

            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
}
