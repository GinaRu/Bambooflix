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
    
    func configureNavigationProfile(_ sender: Int) {
        let profile = currentProfiles.first{$0.id == sender}
        ProfileViewModel.selectedProfileId = sender
        
        if isEditModeEnabled == true && profile != nil{
            performSegue(withIdentifier: "segueToEditProfile", sender: nil)
        } else if isEditModeEnabled == false && profile == nil {
            performSegue(withIdentifier: "segueToEditProfile", sender: nil)
        } else if isEditModeEnabled == false && profile != nil {
            MoviesViewModel.selectedProfile = profile
            performSegue(withIdentifier: "segueToMovies", sender: nil)
        }
    }
    func configureProfilesBeforeReading() {
        for l in nombrePerfilLabel {
            l.text = "AÑADIR"
        }
        for b in buttonsOutlet {
            let image = UIImage(systemName: "plus")
            b.setBackgroundImage(image, for: .normal)
        }
    }
    func configureProfileButtons() {
        configureProfilesBeforeReading()
        currentProfiles = profileManager.readProfiles()
        for p in currentProfiles {
            if p.id == nombrePerfilLabel[p.id].tag {
                nombrePerfilLabel[p.id].text = p.name
            }
            if p.id == buttonsOutlet[p.id].tag {
                let image = UIImage(named: p.imageName)
                buttonsOutlet[p.id].setBackgroundImage(image, for: .normal)
            }
 
            }
        }
    
    @IBOutlet var buttonsOutlet: [UIButton]!
    @IBOutlet var listoButtonOutlet: UIBarButtonItem!
    @IBOutlet var editarButtonOutlet: UIBarButtonItem!
    @IBOutlet var nombrePerfilLabel: [UILabel]!
    
    @IBAction func listoButton(_ sender: UIBarButtonItem) {
        listoButtonOutlet.hide()
        editarButtonOutlet.show()
        isEditModeEnabled = false
    }
    
    @IBAction func editarButton(_ sender: UIBarButtonItem) {
        listoButtonOutlet.show()
        editarButtonOutlet.hide()
        isEditModeEnabled = true
    }
    
    @IBAction func añadirPerfilTouched(_ sender: UIButton) {
        ProfileViewModel.reset()
        configureNavigationProfile(sender.tag)
    }

    override func viewDidAppear(_ animated: Bool) {
        editarButtonOutlet.show()
        listoButtonOutlet.hide()
        isEditModeEnabled = false
       configureProfileButtons()
    }
    
    
    }
    
  
    




