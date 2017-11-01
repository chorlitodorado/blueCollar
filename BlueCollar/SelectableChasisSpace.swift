//
//  SelectableChasisSpace.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

class SelectableChasisSpace: SelectableNode {
    
    var expectedPartName: String!
    
    var isPartPlaced: Bool = false {
        didSet {
            if isPartPlaced == true {
                anchorPoints.forEach{$0.isDisabled = false}
            }
            
        }
    }
    var part: SKSpriteNode?
    var score: Int = 0
    var anchorPoints = [ComponentAnchorPoint]()
    var currentScene: GamePlayScene?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPartPlaced == false {
            if let base = self.parent as? ItemBaseSprite,
                let scene = base.parentScene,
                scene.selectionState == .assemblyComponent,
                let partName = scene.selectableComponents[scene.selectedComponentIdx].partNaming {
                
                placePart(partName: partName)
                scene.selectableComponents[scene.selectedComponentIdx].isSelected = false
                scene.selectionState = .unselected
            }
        } else {
            let touch: UITouch = touches.first! as UITouch
            let positionInScene = touch.location(in: self)
            let touchedNode = self.atPoint(positionInScene)
            
            if let node = touchedNode as? ComponentAnchorPoint,
            let base = self.parent as? ItemBaseSprite,
            let cScene = base.parentScene,
                node.state == .initial {
                switch node.anchorType! {
                case .screw:
                    if cScene.selectionState == .toolScrew {
                        node.state = .correct
                    } else {
                        node.state = .wrong
                    }
                case .glue:
                    if cScene.selectionState == .toolGlue {
                        node.state = .correct
                    } else {
                        node.state = .wrong
                    }
                case .welder:
                    if cScene.selectionState == .toolWelder {
                        node.state = .correct
                    } else {
                        node.state = .wrong
                    }
                }
                
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
        
        
        if let base = self.parent as? ItemBaseSprite,
            let scene = base.parentScene {
            self.currentScene = scene
        }
    }
    
    override var isSelected: Bool  {
        didSet {
            
            
        }
    }
    
    func placePart(partName: String) {
        if expectedPartName == partName {
            part = SKSpriteNode(imageNamed: partName)
            self.addChild(part!)
            isPartPlaced = true
            
        }
        
    }
    
    
}
