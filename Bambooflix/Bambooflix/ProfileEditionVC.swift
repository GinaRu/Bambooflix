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
    var currentProfile: Profile? = nil
    
    func popNavigation() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    func configureTextFieldEdition() {
        if let id = ProfileViewModel.selectedProfileId {
            let profileList = profileManager.readProfiles()
            for p in profileList {
                if id == p.id {
                    if p.name == "AÑADIR" {
                        nameTexfield.text = ""
                    } else {
                        nameTexfield.text = p.name
                    }
                }
            }
        }
    }
    func eliminarPerfil() {
        if let id = ProfileViewModel.selectedProfileId {
            let profileList = profileManager.readProfiles()
            for p in profileList {
                if id == p.id {
                    profileManager.removeProfile(p)
                }
            }
        }
    }
    func crearGuardarPerfil() {
        if let id = ProfileViewModel.selectedProfileId
        {
            var name = nameTexfield.text ?? "Unknown"
            if name.isEmpty {
                name = "SIN NOMBRE"
            }
          
            
            if isEditingProfile() == true {
                if var profile = currentProfile {
                profile.name = name
                if let selectedAvatar = ProfileViewModel.selectedAvatar {
                    profile.imageName = selectedAvatar
                }
                profileManager.saveProfile(profile)
                }
            } else {
                var imageAvatar: String
               
                if let selectedAvatar = ProfileViewModel.selectedAvatar {
                    imageAvatar = selectedAvatar
                } else {
               imageAvatar = "avatar_20_mini"
                }
                let profile = Profile(id: id, name: name, imageName: imageAvatar)
                profileManager.saveProfile(profile)
            }
        } else {
            print("No hi ha selectedProfileId")
        }
    }
    func alertaEliminar() {
        let alert = UIAlertController(title: "¡ALERTA!", message: "¿Estás seguro que quieres eliminar el perfil y todos sus datos?", preferredStyle: .alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel , handler:
        { action in
        print("El usuario ha cancelado el borrado de datos.")
        })
        alert.addAction(cancelAction)
        let removeAction: UIAlertAction = UIAlertAction(title: "Eliminar", style: .destructive , handler:
            {
            action in self.eliminarPerfil()
                self.nameTexfield.text = ""
                self.popNavigation()
        })
        alert.addAction(removeAction)
        self.present(alert, animated: true)
    }
    
    func isEditingProfile() -> Bool {
        return currentProfile != nil
    }
    
    @IBOutlet var nameTexfield: UITextField!
    
    @IBAction func cancelarButton(_ sender: UIBarButtonItem) {
       popNavigation()
    }
    @IBAction func guardarButton(_ sender: UIBarButtonItem) {
        crearGuardarPerfil()
        popNavigation()
    }
    @IBAction func eliminarButton(_ sender: Any) {
        alertaEliminar()
    }
    
    
    @IBOutlet var pencilButtonOutlet: UIButton!
    
    
   
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        nameTexfield.resignFirstResponder()
        view.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
      
        currentProfile = profileManager.readProfiles().first{
            $0.id == ProfileViewModel.selectedProfileId
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureTextFieldEdition()
        if ProfileViewModel.selectedAvatar == nil {
            print("selected avatar és nil") // el que teniem
        }
    
        if let image = ProfileViewModel.selectedAvatar {
            pencilButtonOutlet.setImage(nil, for: .normal
            )
        pencilButtonOutlet.setBackgroundImage(UIImage(named: image), for: .normal)
        } else if isEditingProfile() == true {
            guard let currentProfile = currentProfile  else { return
            }
            pencilButtonOutlet.setImage(nil, for: .normal
            )
            pencilButtonOutlet.setBackgroundImage(UIImage(named: currentProfile.imageName), for: .normal)
        } else {
            pencilButtonOutlet.setImage(UIImage(systemName: "pencil"), for: .normal
            )
        }
        
        
 
       
    }

}

