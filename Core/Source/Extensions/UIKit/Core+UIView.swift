//
//  Core+UIView.swift
//  Core
//
//  Created by Daniel Tarazona on 5/26/21.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult func autolayout() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func anchorToView(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        activate([
            self.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: insets.right),
            self.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: insets.left),
            self.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: insets.top),
            self.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: insets.bottom)
        ])
    }

    func anchorToLayoutGuide(_ layoutGuide: UILayoutGuide) {
        activate([
            self.trailingAnchor.constraint(
                equalTo: layoutGuide.trailingAnchor),
            self.leadingAnchor.constraint(
                equalTo: layoutGuide.leadingAnchor),
            self.topAnchor.constraint(
                equalTo: layoutGuide.topAnchor),
            self.bottomAnchor.constraint(
                equalTo: layoutGuide.bottomAnchor)
        ])
    }

    func activate(_ layoutConstraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(layoutConstraints)
    }
}

