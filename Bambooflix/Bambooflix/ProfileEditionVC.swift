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
    
    func alertaEliminar() {
        let alert = UIAlertController(title: "¡ALERTA!", message: "Vas a eliminar un perfil de usuario, ¿estás seguro de ello?", preferredStyle: .alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancelar", style: .cancel , handler:
                                                        { action in
                                                            print("El usuario ha cancelado el borrado de datos.")
                                                        })
        alert.addAction(cancelAction)
        
        let removeAction: UIAlertAction = UIAlertAction(title: "Eliminar", style: .destructive , handler:
                                                            {
                                                                action in self.eliminarPerfil()
                                                                self.nameTexfield.text = ""
                                                                if let navController = self.navigationController {
                                                                    navController.popViewController(animated: true)
                                                                }
                                                                
                                                            })
        
        alert.addAction(removeAction)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func cancelarButton(_ sender: UIBarButtonItem) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func guardarButton(_ sender: UIBarButtonItem) {
        
        if let id = ProfileViewModel.selectedProfileId
        {
            var name = nameTexfield.text ?? "Unknown"
            if name.isEmpty {
                name = "SIN NOMBRE"
            }
            let profile = Profile(id: id, name: name, imageName: "avatar_20_mini")
            profileManager.saveProfile(profile)
        }
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    @IBAction func nameTextField(_ sender: Any) {
        
    }
    
    @IBOutlet var nameTexfield: UITextField!
    
    @IBAction func eliminarButton(_ sender: Any) {
        alertaEliminar()
        // pop up alert
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    
    
    
    
}

