//
//  ProfileSelectionVC.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 13/04/2021.
//

import Foundation
import UIKit

class ProfileSelectionVC: UIViewController {
    
    private let profileManager = ProfileManager()
    private var currentProfiles: [Profile] = []
    private var isEditModeEnabled: Bool = false
    
    @IBAction func listoButton(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func editarButton(_ sender: UIBarButtonItem) {
        
    }
    
    
    
    
    @IBAction func añadirPerfilTouched(_ sender: UIButton) {
        ProfileViewModel.selectedProfileId = sender.tag
       performSegue(withIdentifier: "segueToEditProfile", sender: nil)
    }
    
    
    @IBOutlet var buttonsOutlet: [UIButton]!
    
    @IBOutlet var nombrePerfilLabel: [UILabel]!
    
    func configureProfileButtons() {
        let profileList = profileManager.readProfiles()
        for p in profileList {
            if p.id == nombrePerfilLabel[p.id].tag {
                nombrePerfilLabel[p.id].text = p.name
            }
            if p.id == buttonsOutlet[p.id].tag {
                let image = UIImage(named: p.imageName)
                buttonsOutlet[p.id].setImage(image, for: .normal)
            }
 
            }
        }
    override func viewWillAppear(_ animated: Bool) {
       configureProfileButtons()
    }
    
    }
    
  
    




