//
//  IconVC.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 15/04/2021.
//

import Foundation
import UIKit

class IconVC: UIViewController {
    
    
    let imageNames: [String] = ["avatar_20", "avatar_12", "avatar_16", "avatar_18", "avatar_11", "avatar_50"]
    
    func configureButtons() {
        var index = 0
        for icon in iconOutlet {
            icon.setBackgroundImage(UIImage(named: imageNames[index]), for: .normal)
            index += 1
        }
    }
    
    @IBOutlet var iconOutlet: [UIButton]!
    
    @IBAction func iconTouched(_ sender: UIButton) {
        ProfileViewModel.selectedAvatar = imageNames[sender.tag]
        print(sender.tag)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
     configureButtons()
        
    }
    
    
    
}
