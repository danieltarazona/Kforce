//
//  Core+UIViewController.swift
//  Core
//
//  Created by Administrator on 6/1/21.
//

import UIKit

extension UIViewController {

  func configureNavigationBar() {

    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

    var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
  }
}
