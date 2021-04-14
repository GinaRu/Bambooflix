//
//  ProfileEditionVC.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 13/04/2021.
//

import Foundation
import UIKit

class ProfileEditionVC: UIViewController {
    
    let profileManager = ProfileManager()
    
    @IBAction func cancelarButton(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func guardarButton(_ sender: UIBarButtonItem) {
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
        if let id = ProfileViewModel.selectedProfileId
             {
            var name = nameTexfield.text ?? "Unknown"
            if name.isEmpty {
                name = "Añadir"
            }
        let profile = Profile(id: id, name: name, imageName: "avatar_20_mini")
            
            profileManager.saveProfile(profile)
        }
        
        

    }
    
    
    @IBAction func nameTextField(_ sender: Any) {
        
    }
    
    @IBOutlet var nameTexfield: UITextField!
    
    @IBAction func eliminarButton(_ sender: Any) {
        // pop up alert
    }
    
    
    
    
    
}
