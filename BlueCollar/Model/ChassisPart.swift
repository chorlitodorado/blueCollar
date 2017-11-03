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
    
    var score: Int = 0
    
    var isFilled = false {
        didSet {
            if isFilled {
                self.addChild(designedPart!)
                designedPart.isUserInteractionEnabled = true
                designedPart.anchorPoints.forEach{$0.isDisabled = false}
                score += 20
            }
        }
    }
    
   weak var sceneSelectionDelegate: SelectionHandlerProtocol?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       if UserSelectionManager.shared.selectionState == .assemblyComponent &&
        UserSelectionManager.shared.selectedSlotPartName == expectedPartName!, isFilled == false {
          isFilled = true
          sceneSelectionDelegate?.resetUserSelection()
        }
    }
    

    func getPartScore() -> Int {
        
        if designedPart.isCompleted && isFilled {
            return score + designedPart.score
        }
        return 0
    }
    
}
