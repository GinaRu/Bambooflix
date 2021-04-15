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
        listoButtonOutlet.hide()
        editarButtonOutlet.show()
        isEditModeEnabled = false
        for p in currentProfiles {
            print(p.name)
        }
    }
    
    @IBAction func editarButton(_ sender: UIBarButtonItem) {
        listoButtonOutlet.show()
        editarButtonOutlet.hide()
        isEditModeEnabled = true
    }
  

    
    @IBAction func añadirPerfilTouched(_ sender: UIButton) {
        let profile = currentProfiles.first{$0.id == sender.tag}
        ProfileViewModel.selectedProfileId = sender.tag
        
        if isEditModeEnabled == true && profile != nil{
            performSegue(withIdentifier: "segueToEditProfile", sender: nil)
        } else if isEditModeEnabled == false && profile == nil {
            performSegue(withIdentifier: "segueToEditProfile", sender: nil)
            
        }
    }
    
    
    @IBOutlet var buttonsOutlet: [UIButton]!
    
    
    @IBOutlet var listoButtonOutlet: UIBarButtonItem!
    @IBOutlet var editarButtonOutlet: UIBarButtonItem!
    
    @IBOutlet var nombrePerfilLabel: [UILabel]!
    
    func configureProfileButtons() {
        for l in nombrePerfilLabel {
            l.text = "AÑADIR"
        }
        for b in buttonsOutlet {
            let image = UIImage(systemName: "plus")
            b.setImage(image, for: .normal)
        }
        

        currentProfiles = profileManager.readProfiles()
        for p in currentProfiles {
            if p.id == nombrePerfilLabel[p.id].tag {
                nombrePerfilLabel[p.id].text = p.name
            }
            if p.id == buttonsOutlet[p.id].tag {
                let image = UIImage(named: p.imageName)
                buttonsOutlet[p.id].setImage(image, for: .normal)
            }
 
            }
        }
    override func viewDidAppear(_ animated: Bool) {
        editarButtonOutlet.show()
        listoButtonOutlet.hide()
        isEditModeEnabled = false
       configureProfileButtons()
    }
    
    }
    
  
    




