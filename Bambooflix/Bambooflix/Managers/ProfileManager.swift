//
//  ProfileManager.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 14/04/2021.
//

import Foundation

struct ProfileManager {
    func readProfiles() -> [Profile] {
        
        guard let encodedData = UserDefaults.standard.data(forKey: ProfileKeys.profileList.rawValue) else {return []}
        guard let profileArray: [Profile] = try?
                JSONDecoder().decode([Profile].self, from: encodedData) else {return []}
    
       return profileArray
        }
        
    
    
    func saveProfile(_ profile: Profile) {
        removeProfile(profile)
       var profilesList = readProfiles()
        profilesList.append(profile)
        saveAllProfiles(profilesList)
    }
    
    func removeProfile(_ profile: Profile) {
        var index = 0
        var profilesList = readProfiles()
        
        // Exemple 1
        for p in profilesList {
            if profile.id == p.id {
                profilesList.remove(at: index)
                saveAllProfiles(profilesList)
                return
            }
            index += 1
        }
        
        // Exemple 2
//        for (index, p) in profilesList.enumerated() {
//            if profile.id == p.id {
//                profilesList.remove(at: index)
//                saveAllProfiles(profilesList)
//                return
//            }
//        }
        
        // Exemple 3 Eliminem tots els elements que compleixen la condició de la closure:
       // profilesList.removeAll(){$0.id == profile.id}
       // saveProfile(profilesList)
         
    }
    
    private func saveAllProfiles(_ profiles: [Profile]) {
        guard let encodedData = try? JSONEncoder().encode(profiles) else { return }
        UserDefaults.standard.set(encodedData, forKey: ProfileKeys.profileList.rawValue)
        UserDefaults.standard.synchronize()
    }


enum ProfileKeys: String {
    case profileList
}

}
