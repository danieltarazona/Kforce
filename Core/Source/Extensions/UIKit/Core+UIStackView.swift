//
//  Core+UIStackView.swift
//  Core
//
//  Created by Administrator on 5/26/21.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis = .horizontal,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 12,
        subviews: [UIView] = []
    ) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }

    convenience init(axis: NSLayoutConstraint.Axis = .vertical) {
        self.init(arrangedSubviews: [])
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        self.axis = .vertical
        self.spacing = 0
        self.distribution = .equalSpacing
    }

    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }

    func add(_ view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, margin: Bool = false) {
        addArrangedSubview(view)
        setCustomSpacing(top, after: arrangedSubviews.last ?? UIView())
        setCustomSpacing(bottom, after: view)
        view.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin ? 16 : 0)
            make.right.equalToSuperview().offset(margin ? -16 : 0)
        }
    }

    func remove(_ view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func removeAll() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}

