//
//  ProfileViewModel.swift
//  Bambooflix
//
//  Created by Georgina Rubira Pairó on 13/04/2021.
//

import Foundation


class ProfileViewModel {
    
static var selectedProfileId: Int?
static var selectedAvatar: String? = nil
    
  static  func reset() {
        selectedProfileId = nil
    selectedAvatar = nil
    }
    
}
