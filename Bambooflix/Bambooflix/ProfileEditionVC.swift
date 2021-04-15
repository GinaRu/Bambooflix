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
            let profile = Profile(id: id, name: name, imageName: "avatar_20_mini")
            profileManager.saveProfile(profile)
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
    @IBOutlet var nameTexfield: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
     configureTextFieldEdition()
    }

}

