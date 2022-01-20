//
//  MainViewController.swift
//  Car exhibition
//
//  Created by Наталья Шарапова on 19.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeButton.backgroundColor = .black
        welcomeButton.alpha = 0.7
        welcomeButton.layer.cornerRadius = 20
        welcomeButton.tintColor = .white
        welcomeButton.titleLabel?.font = UIFont(name: "Gill Sans", size: 20)
        welcomeButton.layer.borderWidth = 1
        welcomeButton.layer.borderColor = UIColor.white.cgColor
        welcomeButton.frame = CGRect(x: view.bounds.midX - 150, y: 760, width: 300, height: 50)
        welcomeButton.setTitle("Start registration", for: .normal)
        
        UIButton.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat, .allowUserInteraction]) {
            self.welcomeButton.backgroundColor = .cyan
        }
    }
}
