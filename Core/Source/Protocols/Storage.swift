//
//  Storable.swift
//  Core
//
//  Created by Daniel Tarazona on 5/22/21.
//

import Foundation

protocol Initializable {
    init()
}

protocol Storable: Identifiable, Initializable { }
