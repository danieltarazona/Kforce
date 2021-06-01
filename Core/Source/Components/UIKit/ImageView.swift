//
//  ImageView.swift
//  Core
//
//  Created by Daniel Tarazona on 6/1/21.
//

import Foundation
import UIKit

class ImageView: UIImageView {
    
    var height: CGFloat = 200
    var width: CGFloat = 200
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    func setup() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
}
