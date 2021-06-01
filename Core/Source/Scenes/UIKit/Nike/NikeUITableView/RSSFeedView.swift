//
//  RSSFeedViewModel.swift
//  Core
//
//  Created by Administrator on 5/30/21.
//

import Foundation
import UIKit

class RSSFeedView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = true
        tableView.allowsMultipleSelectionDuringEditing = false
        return tableView
    }()
    
    lazy var titleView: TextView = {
        let titleView = TextView()
        titleView.viewModel = TextViewModel(size: 24, title: "Top 100 Songs", color: .white, bold: true, align: .center)
        return titleView
    }()

    required init?(coder: NSCoder) {
        super.init(frame: CGRect.zero)
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    func setup() {
        addSubview(tableView)
        addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview()
            make.height.equalTo(32)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
