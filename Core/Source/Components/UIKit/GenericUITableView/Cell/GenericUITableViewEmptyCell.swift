//
//  GenericUITableViewEmptyCell.swift
//  Core
//
//  Created by Administrator on 5/26/21.
//

import UIKit

class GenericUITableViewEmptyCell: UITableViewCell {

    var view = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        selectionStyle = .none
    }
}
