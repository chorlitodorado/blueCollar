//
//  GamePlayScene.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit
import GameplayKit

enum SelectionState {
    
    case unselected
    case toolScrew
    case toolGlue
    case toolWelder
    case assemblyComponent
}



class GamePlayScene: SKScene {
    
    private var buttonToolScrew: ScrewToolSprite?
    private var buttonToolGlue: GlueToolSprite?
    private var buttonToolWelder: WelderToolSprite?
    
    var selectableComponents =  [SelectableComponent]()
    
    var selectedComponentIdx = 0
    
    var stateMachine: GKStateMachine!
    
    var selectionState: SelectionState = .unselected {
        
        didSet {
            self.buttonToolScrew?.isSelected = false
            self.buttonToolGlue?.isSelected = false
            self.buttonToolWelder?.isSelected = false
            selectableComponents.forEach{$0.isSelected = false}
        }
        
    }
    
    override func sceneDidLoad() {
        
        loadToolSlots()
        loadPartSlots()
       let _ = loadNewItem(fileName: "TestPhone")
    }
    
    func loadToolSlots() {
        
        guard let toolsBck = self.childNode(withName: "toolsBckg") as? SKSpriteNode,
            let btnScrew = toolsBck.childNode(withName: "toolBtnScrew") as? ScrewToolSprite,
            let btnGlue = toolsBck.childNode(withName: "toolBtnGlue") as? GlueToolSprite,
            let btnWelder = toolsBck.childNode(withName: "toolBtnWelder") as? WelderToolSprite else {
                return
        }
        self.buttonToolScrew = btnScrew
        self.buttonToolGlue = btnGlue
        self.buttonToolWelder = btnWelder

        
    }
    
    func loadPartSlots() {
        
        guard let partsBck = self.childNode(withName: "partsBckg") as? SKSpriteNode,
            let partSlot0 = partsBck.childNode(withName: "partSlot0") as? SelectableComponent,
            let partSlot1 = partsBck.childNode(withName: "partSlot1") as? SelectableComponent,
            let partSlot2 = partsBck.childNode(withName: "partSlot2") as? SelectableComponent,
            let partSlot3 = partsBck.childNode(withName: "partSlot3") as? SelectableComponent,
            let partSlot4 = partsBck.childNode(withName: "partSlot4") as? SelectableComponent else {
                
                return
        }
        
        partSlot0.tag = 0
        partSlot0.partNaming = "testPhoneBoard"
        partSlot0.addComponent(partName: "testPhoneBoardThumbnail@2x")
        self.selectableComponents.append(partSlot0)
        
        partSlot1.tag = 1
        partSlot1.partNaming = "testPhoneFlashMemo"
        partSlot1.addComponent(partName: "testPhoneFlashMemoThumbnail@2x")
        self.selectableComponents.append(partSlot1)
        
        partSlot2.tag = 2
        partSlot2.partNaming = "testPhoneCamera"
        partSlot2.addComponent(partName: "testPhoneCamera@2x")
        self.selectableComponents.append(partSlot2)
        
        partSlot3.tag = 3
        partSlot3.partNaming = "testPhoneBattery"
        partSlot3.addComponent(partName: "testPhoneBatteryThumbnail@2x")
        self.selectableComponents.append(partSlot3)
        
        partSlot4.tag = 4
        partSlot4.partNaming = "testPhoneFront"
        partSlot4.addComponent(partName: "testPhoneFrontThumbnail@2x")
        self.selectableComponents.append(partSlot4)
        
    }
    
    func loadNewItem(fileName: String) -> SKSpriteNode? {
        
        guard let beltBck = self.childNode(withName: "beltBckg") as? SKSpriteNode, let itemScene = SKScene(fileNamed: fileName),
            let partsBck = itemScene.childNode(withName: "testPhoneGuideChasis") as? ItemBaseSprite,
       let fillSpace0 = partsBck.childNode(withName: "testPhoneBoardGuideChasis") as? SelectableChasisSpace,
       let anchor0Space0 = fillSpace0.childNode(withName: "anchorWelder0") as? ComponentAnchorPoint,
       let anchor1Space0 = fillSpace0.childNode(withName: "anchorWelder1") as? ComponentAnchorPoint,
       let anchor2Space0 = fillSpace0.childNode(withName: "anchorWelder2") as? ComponentAnchorPoint,
       let anchor3Space0 = fillSpace0.childNode(withName: "anchorWelder3") as? ComponentAnchorPoint,
       let fillSpace1 = partsBck.childNode(withName: "testPhoneCameraGuideChasis") as? SelectableChasisSpace,
       let fillSpace2 = partsBck.childNode(withName: "testPhoneMemoryGuideChasis") as? SelectableChasisSpace,
       let fillSpace3 = partsBck.childNode(withName: "testPhoneBatteryGuideChasis") as? SelectableChasisSpace else {
                
                return nil
        }
        anchor0Space0.anchorType = .welder
        anchor1Space0.anchorType = .welder
        anchor2Space0.anchorType = .welder
        anchor3Space0.anchorType = .welder
        fillSpace0.expectedPartName = "testPhoneBoard"
        fillSpace0.anchorPoints = [anchor0Space0, anchor1Space0, anchor2Space0, anchor3Space0]
        fillSpace1.expectedPartName = "testPhoneCamera"
        fillSpace2.expectedPartName = "testPhoneFlashMemo"
        fillSpace3.expectedPartName = "testPhoneBattery"
        
        partsBck.fillableSpaces = [fillSpace0, fillSpace1, fillSpace2, fillSpace3]
        partsBck.removeFromParent()
        partsBck.parentScene = self
        
        beltBck.addChild(partsBck)
        
        return partsBck
        
        
    }
    
    func toolSlotTouched(state: SelectionState) {
        
        if selectionState != state {
            selectionState = state
            switch state {
            case .toolScrew:
                self.buttonToolScrew?.isSelected = true
            case .toolGlue:
                self.buttonToolGlue?.isSelected = true
            case .toolWelder:
                self.buttonToolWelder?.isSelected = true
            default:
                selectionState = .unselected
            }
        } else {
            selectionState = .unselected
        }
        
        
    }
    
    func componentSlotTouched(idx: Int) {
        
        if selectionState != .assemblyComponent {
            if !selectableComponents[idx].isEmpty  {
                selectionState = .assemblyComponent
                selectableComponents[idx].isSelected = true
                selectedComponentIdx = idx
            }
        } else {
            if selectableComponents[idx].isSelected == true {
                selectionState = .unselected
                
            } else {
                selectableComponents.forEach{$0.isSelected = false}
                selectableComponents[idx].isSelected = true
                selectedComponentIdx = idx
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch = touches.first! as UITouch
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        
        if let name = touchedNode.name {
            
            switch name {
            case "toolBtnScrew":
                toolSlotTouched(state: .toolScrew)
            case "toolBtnGlue":
                toolSlotTouched(state: .toolGlue)
            case "toolBtnWelder":
                toolSlotTouched(state: .toolWelder)
            case "partSlot0":
                self.componentSlotTouched(idx: 0)
            case "partSlot1":
                self.componentSlotTouched(idx: 1)
            case "partSlot2":
                self.componentSlotTouched(idx: 2)
            case "partSlot3":
                self.componentSlotTouched(idx: 3)
            case "partSlot4":
                self.componentSlotTouched(idx: 4)

            default:
                print("default")
            }
            
        }
        
    }
    
}
