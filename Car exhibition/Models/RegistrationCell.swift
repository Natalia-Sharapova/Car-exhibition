//
//  RegistrationCell.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 17.01.2022.
//

import UIKit

class RegistrationCell: UITableViewCell {
    
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var imageCar: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       //self.imageCar.frame = CGRect(x: (imageCar.frame.origin.x) ,y: (imageCar.frame.origin.y), width: 155, height: 88)
        
        self.imageCar.clipsToBounds = true
        
       // self.brandLabel.frame = CGRect(x: 0, y: 0, width: 160, height: 25)
    }
    
}
