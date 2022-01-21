//
//  CellManager.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 17.01.2022.
//

import UIKit

class CellManager {
    
    func configure(_ cell: RegistrationCell, with registration: Registration) {
        
        cell.brandLabel.text = registration.brand
        cell.modelLabel.text = registration.model
        cell.imageCar.image = registration.image
    }
}
