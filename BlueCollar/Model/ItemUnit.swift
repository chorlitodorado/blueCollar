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
    
    var currentScore: Int {
        get {
            var sum = 0
            partsComponent.forEach({ sum += $0.getGroupScore()})
            return sum
            
        }
        
        
    }
    
    var partsComponent = [ChassisGroup]()
    
    init(name: String, manufacturer: String, maxScore: Int, components: [ChassisGroup]) {
        self.modelName = name
        self.manufacturer = manufacturer
        self.maxScore = maxScore
        self.partsComponent = components
        
    }
    
    
}
