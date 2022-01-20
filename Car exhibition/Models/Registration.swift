//
//  Registration.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 12.01.2022.
//

import Foundation
import  UIKit

struct Registration {
    
    var brand: String
    var model: String
    var enginePower: Int
    var engine: String
    var trunkCapacity: Int
    
    var image: UIImage!
    
    var startDateOfParticipation: Date
    var endDateOfParticipation: Date
    
    var numberOfArea: Int
    var numberOfStand: Int
    var electricEngine: Bool
    
    init(brand: String = "",
         model: String = "",
         enginePower: Int = 0,
         engine: String = "",
         trunkCapacity: Int = 0,
         image: UIImage = UIImage(named: "default")!,
         startDateOfParticipation: Date = Date.init(),
         endDateOfParticipation: Date = Date.init(), numberOfArea: Int = 0, numberOfStand: Int = 0, electricEngine: Bool = false) {
        
        self.brand = brand
        self.model = model
        self.enginePower = enginePower
        self.engine = engine
        self.trunkCapacity = trunkCapacity
        self.image = image
        self.startDateOfParticipation = startDateOfParticipation
        self.endDateOfParticipation = endDateOfParticipation
        self.numberOfArea = numberOfArea
        self.numberOfStand = numberOfStand
        self.electricEngine = electricEngine
    }
}

extension Registration {
    
    static var all: [Registration] {
        
        return [
            Registration(brand: "Mercedes", model: "EQS", enginePower: 560, engine: "Electric", trunkCapacity: 500, image: UIImage(named: "Mercedes")!, startDateOfParticipation: Date(), endDateOfParticipation: Date(), numberOfArea: 3, numberOfStand: 6, electricEngine: true),
        ]
    }
    
    static func loadAll() -> [Registration]? {
        return nil
    }
    
    static func loadDefaults() -> [Registration] {
        return Registration.all
    }
}
