//
//  ComponentAnchorPoint.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

enum AnchorType {
    case screw
    case glue
    case welder
}

enum AnchorState {
    case initial
    case correct
    case wrong
}

class ComponentAnchorPoint: SelectableNode {
    
    var anchorType: AnchorType!
    var score: Double = 0
    
    var isDisabled: Bool = true {
        didSet {
            if isDisabled == false {
                self.alpha = 1.0
                self.isUserInteractionEnabled = true
            } else {
                
                self.isUserInteractionEnabled = false
            }
        }
        
    }
    
    var state: AnchorState = .initial {
        didSet {
            if state == .correct {
                self.texture = SKTexture(imageNamed: "anchorPointOk")
                score += 10
                isDisabled = true
            } else {
                self.texture = SKTexture(imageNamed: "anchorPointFail")
                score -= 10
                isDisabled = true
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override var isSelected: Bool  {
        didSet {
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if UserSelectionManager.shared.selectionState != .unselected &&
            UserSelectionManager.shared.selectionState != .assemblyComponent {
        
        switch anchorType! {
        case .screw:
            if UserSelectionManager.shared.selectionState == .toolScrew {
                state = .correct
            } else {
                state = .wrong
            }
        case .glue:
            if UserSelectionManager.shared.selectionState == .toolGlue {
                state = .correct
            } else {
                state = .wrong
            }
        case .welder:
            if UserSelectionManager.shared.selectionState == .toolWelder {
                state = .correct
            } else {
                state = .wrong
            }
        }
            
        }

    }
    
    
}
