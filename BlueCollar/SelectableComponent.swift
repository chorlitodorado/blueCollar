//
//  SelectableComponent.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

class SelectableComponent: SelectableNode {
    
    var tag: Int!
    var part: SKSpriteNode?
    var partNaming: String?
    var isEmpty: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.selectedTexture = SKTexture.init(imageNamed: "partSlotSelect")
        super.unSelectedTexture = SKTexture.init(imageNamed: "partSlotUnselect")
    }
    
   override var isSelected: Bool  {
        didSet {
            
            self.texture = isSelected ? super.selectedTexture : super.unSelectedTexture
            UserSelectionManager.shared.selectedSlotPartName = isSelected ? partNaming ?? "UNKNOWN" : ""
        }
    }

    
    func addComponent(partName: String) {
        
        part = SKSpriteNode(imageNamed: partName)
        part?.name = self.name
        
        self.addChild(part!)
        
        
    }

    

}
