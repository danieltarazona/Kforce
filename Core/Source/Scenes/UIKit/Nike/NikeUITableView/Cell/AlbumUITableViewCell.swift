//
//  AlbumUITableViewCell.swift
//  Core
//
//  Created by Administrator on 5/30/21.
//

import Foundation
import UIKit

struct AlbumUITableViewCellModel {
    var title: String
    var artistName: String
    var imageURL: String?
    var action: (() -> Void)?

    init(title: String, artistName: String, imageURL: String?, action: (() -> Void)? = nil) {
        self.title = title
        self.artistName = artistName
        self.imageURL = imageURL
        self.action = action
    }
}

class AlbumUITableViewCell: UITableViewCell {

    var viewModel: AlbumUITableViewCellModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleView.viewModel = TextViewModel(
                size: 16,
                title: viewModel.title,
                color: .white,
                align: .center
            )
            artistView.viewModel = TextViewModel(
                size: 12,
                title: viewModel.artistName,
                color: .white,
                align: .center
            )
            
            if let imageURL = viewModel.imageURL {
                requestManager.getImage(imageURL) { data in
                    DispatchQueue.main.async {
                        self.posterView.image = UIImage(data: data ?? Data())
                    }
                }
            }
        }
    }

    private lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleView: TextView = {
        let titleView = TextView()
        return titleView
    }()
    
    lazy var artistView: TextView = {
        let artistView = TextView()
        return artistView
    }()
    
    lazy var posterView: ImageView = {
        let posterView = ImageView()
        return posterView
    }()

    private lazy var stackView = UIStackView(
        axis: .vertical,
        subviews: [
            titleView,
            artistView,
            posterView
        ]
    ).autolayout()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setup() {
        mainView.addSubview(stackView)

        backgroundColor = .black
        contentView.addSubview(mainView)
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(300)
        }
    }
}

