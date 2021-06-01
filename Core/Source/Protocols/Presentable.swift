//
//  Presentable.swift
//  Core
//
//  Created by Daniel Tarazona on 5/31/21.
//

import Foundation

protocol Presentable {
    associatedtype View
    var view: View! { get set }
}
