//
//  BarButtonExtension.swift
//  BambooTV
//
//  Created by Francesc Navarro on 27/11/2020.
//  Copyright © 2020 Bamboo Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    func hide() {
        self.isEnabled = false
        self.tintColor = .clear
    }
    
    func show() {
        self.isEnabled = true
        self.tintColor = .white
    }
}
