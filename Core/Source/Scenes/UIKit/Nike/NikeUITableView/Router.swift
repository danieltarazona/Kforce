//
//  Router.swift
//  Core
//
//  Created by Daniel Tarazona on 5/28/21.
//

import Foundation
import UIKit

protocol Routeable {
    func start()
}

class Router: Routeable {
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        start()
    }

    func start() {
        let viewController = RSSFeedViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
