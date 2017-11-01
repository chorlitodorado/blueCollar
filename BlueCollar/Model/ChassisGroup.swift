//
//  ChassisGroup.swift
//  BlueCollar
//
//  Created by MiniStation on 1/11/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit


class ChassisGroup: SKSpriteNode {
    
    var chassisParts = [ChassisPart]()
    
    var isCompleted = false
    
    var isItemBase: Bool = false
    
    var maxScore: Int = 0
    
    var currentScore: Int = 0
    
    
    
    func getGroupScore() -> Int {
        var sum = 0
        chassisParts.forEach({ sum += $0.getPartScore()})
        return sum
        
    }
    
}
