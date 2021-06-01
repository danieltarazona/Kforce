//
//  GenericUIViewController.swift
//  Core
//
//  Created by Daniel Tarazona on 5/26/21.
//

import Foundation
import UIKit

class GenericUIViewController: UIViewController {
    
    var tableView: UITableView {
        let tableView = UITableView()
        return tableView
    }
    
    var presenter: GenericUITableViewPresenter<
        GenericCategory,
        GenericRequestObject,
        GenericRoot,
        Generic,
        GenericUITableViewCell,
        GenericUITableViewEmptyCell,
        UITableViewHeaderFooterView
    >!

    override func viewDidLoad() {
        presenter = GenericUITableViewPresenter(
            uiViewController: self,
            uiTableView: tableView,
            keyPath: \GenericRoot.generic
        )
    }
}
