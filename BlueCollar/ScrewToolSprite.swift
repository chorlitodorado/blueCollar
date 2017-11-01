//
//  ScrewToolSprite.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

class ScrewToolSprite: SelectableNode {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.selectedTexture = SKTexture.init(imageNamed: "toolScrewButtonSel@2x")
        super.unSelectedTexture = SKTexture.init(imageNamed: "toolScrewButtonUnSel@2x")
    }
    


}
