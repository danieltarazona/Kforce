//
//  GenericUITableViewPresenter.swift
//  Core
//
//  Created by Daniel Tarazona on 5/26/21.
//

import Foundation
import UIKit

let requestManager = RequestManager()

class GenericUITableViewPresenter<
    Category: Hashable & CaseIterable,
    Request: RequestObject,
    Response: Codable & Initializable,
    Item: Codable & Initializable,
    TableViewCell: UITableViewCell,
    TableViewEmptyCell: UITableViewCell,
    TableViewHeader: UITableViewHeaderFooterView
> {
    
    typealias ReuseIdentifier = String

    var isLoading: Bool = false
    var withActivityIndicator: Bool = false
    var loadingView: UIView?
    var loadingIdentifier: Int?
    
    var items: [Item] = []
    var request: Request = Request()
    var response: Response = Response()
    var category: Category = Category.allCases.first.unsafelyUnwrapped
    var categoriesOrder: [Int: [Category: Response]]?

    var reuseIdentifiers: [Category: ReuseIdentifier] = [:]
    var reuseIdentifier: ReuseIdentifier = "\(TableViewCell.self)"
    var previousPageLink: String?
    
    var viewContoller: UIViewController!
    var tableView: UITableView!
    var headerView: UITableViewHeaderFooterView!
    
    weak var tableViewDelegate: UITableViewDelegate!
    weak var tableViewDataSource: UITableViewDataSource!
    
    let itemsKeyPath: KeyPath<Response, [Item]?>

    required init(uiViewController: UIViewController, uiTableView: UITableView, keyPath: KeyPath<Response, [Item]?>) {

        viewContoller = uiViewController
        tableView = uiTableView
        itemsKeyPath = keyPath
        
        setup()
        load()
    }

    func load(completion: (() -> Void)? = nil) {
        guard !isLoading else { return }
        loading(with: true)
        
        requestManager.request(object: request, type: Response.self) { requestResponse, _ in
            if let requestResponse = requestResponse {
                DispatchQueue.main.async {
                    self.response = requestResponse
                    self.items = requestResponse[keyPath: self.itemsKeyPath] ?? []
                    print(self.items)
                }
            }
            self.finish()
        }
    }

    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.setContentOffset(.zero, animated: true)
        }
    }

    func setup() {
        Category.allCases.forEach { category in
            reuseIdentifiers = [category: reuseIdentifier]
        }
    
        registerCells()
    }

    func setReuseIdentifier(for category: Category, _ id: String = "\(TableViewCell.self)") {
        reuseIdentifiers[category] = id
    }

    func getReuseIdentifier(for category: Category, indexPath: IndexPath) -> String {
        return reuseIdentifiers[category] ?? reuseIdentifier
    }

    func registerCells() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "\(TableViewCell.self)")
        tableView.register(TableViewEmptyCell.self, forCellReuseIdentifier: "\(TableViewEmptyCell.self)")
        
        tableView.register(
            TableViewHeader.self,
            forHeaderFooterViewReuseIdentifier: "\(TableViewHeader.self)"
        )

        headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "\(TableViewHeader.self)"
        ) as? TableViewHeader
    }

    func loading(with activityIndicator: Bool = false) {
        isLoading = true
    }

    func finish() {
        isLoading = false
        reload()
    }

    func loadMore() {
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows() -> Int {
        if items.count > 1 {
            return items.count
        }
        return 1
    }

    func cellEmpty() -> TableViewEmptyCell {
        return TableViewEmptyCell()
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    func getItem(at indexPath: IndexPath?) -> Item? {
        if let indexPath = indexPath, !items.isEmpty {
            return items[indexPath.row]
        }
        return nil
    }
    
    func cellItem(at indexPath: IndexPath?) -> Item? {
        if let indexPath = indexPath, !items.isEmpty {
            return items[indexPath.row]
        }
        return Item()
    }

    func cellRowAt(indexPath: IndexPath) -> TableViewCell? {
        
        let cellIdentifier = reuseIdentifiers[category]

        if let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier ?? reuseIdentifier
        ) as? TableViewCell {
            return cell
        }
        
        return TableViewCell()
    }
}
