//
//  Addition.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 12.01.2022.
//

import Foundation

struct Addition {
    
    var name: String
    var id: Int
}

extension Addition: Equatable {
    
    static func ==(lhs: Addition, rhs: Addition) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Addition {
    
    static var all: [Addition] {
        return [
            
            Addition(name: "Air suspension", id: 0),
            Addition(name: "Soft top", id: 1),
            Addition(name: "Rain sensor", id: 2),
            Addition(name: "Climate control", id: 3),
            Addition(name: "Leather interior", id: 4)
        ]
    }
}
