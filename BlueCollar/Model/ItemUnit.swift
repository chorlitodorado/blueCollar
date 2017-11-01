//
//  ItemUnit.swift
//  BlueCollar
//
//  Created by MiniStation on 1/11/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import Foundation



class ItemUnit {
    
    let modelName: String
    let manufacturer: String
    
    // add type
    // add difficulty
    // add
    let maxScore: Int
    var currentScore: Int
    
    var partsComponent = [ChassisGroup]()
    
    init(name: String, manufacturer: String, maxScore: Int, currentScore: Int, components: [ChassisGroup]) {
        self.modelName = name
        self.manufacturer = manufacturer
        self.maxScore = maxScore
        self.currentScore = currentScore
        self.partsComponent = components
        
    }
    
    
    
}
