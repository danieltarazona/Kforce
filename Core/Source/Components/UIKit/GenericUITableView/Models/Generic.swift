//
//  Generic.swift
//  Core
//
//  Created by Administrator on 5/26/21.
//

import Foundation

enum GenericCategory: String, CaseIterable {
    case ALL
}

class GenericRequestObject: RequestObject {}

class RequestObject: Initializable {
    var URL: String

    required init() {
        self.URL = ""
    }
    
    init(URL: String) {
        self.URL = URL
    }
}

class GenericRoot: Codable, Initializable {
    required init() {}
    
    var generic: [Generic]?
    
    init(generic: [Generic]?) {
        self.generic = generic
    }
}

class Generic: Codable, Initializable {
    required init() {}
    
    var name: String?
    
    init(name: String) {
        self.name = name
    }
}

