//
//  GlueToolSprite.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

class GlueToolSprite: SelectableNode {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.selectedTexture = SKTexture.init(imageNamed: "toolGlueButtonSel@2x")
        super.unSelectedTexture = SKTexture.init(imageNamed: "toolGlueButtonUnSel@2x")
    }
    
    
    


}
