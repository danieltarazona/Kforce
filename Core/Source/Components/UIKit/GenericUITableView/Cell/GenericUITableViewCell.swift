//
//  GenericUITableViewCell.swift
//  Core
//
//  Created by Administrator on 5/30/21.
//

import UIKit

struct GenericUITableViewCellModel {
    var title: String
    var action: (() -> Void)?

    init(title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }
}

class GenericUITableViewCell: UITableViewCell {
    
    var stackSubviews: [UIView] = []
    var extendedSetup: () -> Void = {}

    var viewModel: GenericUITableViewCellModel? {
        didSet {
            guard let _ = viewModel else { return }
        }
    }

    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var stackView = UIStackView(
        axis: .vertical,
        subviews: stackSubviews
    ).autolayout()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        mainView.addSubview(stackView)

        addSubview(mainView)

        mainView.anchorToView(self, insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))

        mainView.snp.makeConstraints { (make) in
            make.height.equalTo(360)
            make.width.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        
        extendedSetup()
    }
}
