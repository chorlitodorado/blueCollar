//
//  ChassisPart.swift
//  BlueCollar
//
//  Created by MiniStation on 1/11/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit



class ChassisPart: SKSpriteNode {
    
    var designedPart: Part!
    
    var expectedPartName: String!
    
    var isFilled = false {
        didSet {
            if isFilled {
                self.addChild(designedPart!)
                designedPart.isUserInteractionEnabled = true
                designedPart.anchorPoints.forEach{$0.isDisabled = false}
            }
        }
        
    }
    
   weak var sceneSelectionDelegate: SelectionHandlerProtocol?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        if let base = self.parent as? ItemBaseSprite,
//            let cScene = base.parentScene, cScene.selectionState == .assemblyComponent,
//            let partName = cScene.selectableComponents[cScene.selectedComponentIdx].partNaming,
//            partName == expectedPartName, isFilled == false {
//            isFilled = true
//            cScene.selectableComponents[cScene.selectedComponentIdx].isSelected = false
//            cScene.selectionState = .unselected
//        }
        
       if UserSelectionManager.shared.selectionState == .assemblyComponent &&
        UserSelectionManager.shared.selectedSlotPartName == expectedPartName!, isFilled == false {
          isFilled = true
          sceneSelectionDelegate?.resetUserSelection()
        
        }
        
    }
    
    
    
}
