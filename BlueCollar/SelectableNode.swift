//
//  SelectableNode.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

class SelectableNode: SKSpriteNode {

    
    var selectedTexture = SKTexture.init(imageNamed: "toolGlueButtonSel@2x")
    
    var unSelectedTexture = SKTexture.init(imageNamed: "toolGlueButtonUnSel@2x")

    
    var isSelected: Bool = false {
        didSet {
            self.texture = isSelected ? selectedTexture : unSelectedTexture
            
        }
        
        
    }

    
}
