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


protocol SelectionHandlerProtocol: class {
    
    func resetUserSelection()
    
}


class GamePlayScene: SKScene {
    
    private var buttonToolScrew: ScrewToolSprite?
    private var buttonToolGlue: GlueToolSprite?
    private var buttonToolWelder: WelderToolSprite?
    
    var selectableComponents =  [SelectableComponent]()
    
    var selectedComponentIdx = 0
    
    var stateMachine: GKStateMachine!
    
    var item: ItemUnit!
    
    var selectionState: SelectionState = .unselected {
        didSet {
            UserSelectionManager.shared.selectionState = selectionState
            self.buttonToolScrew?.isSelected = false
            self.buttonToolGlue?.isSelected = false
            self.buttonToolWelder?.isSelected = false
            selectableComponents.forEach{$0.isSelected = false}
        }
    }
    
    override func sceneDidLoad() {
        selectionState = .unselected
        loadToolSlots()
        loadPartSlots()
        // let _ = loadNewItem(fileName: "TestPhone")
        
      //  let _ = loadNewProductTest(fileName: "SmartPhoneABase")
        
        item = loadNewProductTest2(fileName: "SmartPhoneABase")
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
            let partSlot4 = partsBck.childNode(withName: "partSlot4") as? SelectableComponent,
            let partSlot5 = partsBck.childNode(withName: "partSlot5") as? SelectableComponent else {
                
                return
        }
        
        partSlot0.tag = 0
        partSlot0.partNaming = "testPhoneBoard"
        partSlot0.addComponent(partName: "testPhoneBoardThumbnail@2x")
        self.selectableComponents.append(partSlot0)
        
        partSlot1.tag = 1
        partSlot1.partNaming = "flashMemoryA0"
        partSlot1.addComponent(partName: "flashMemoryA0Thumbnail")
        self.selectableComponents.append(partSlot1)
        
        partSlot2.tag = 2
        partSlot2.partNaming = "cameraA0"
        partSlot2.addComponent(partName: "cameraA0")
        self.selectableComponents.append(partSlot2)
        
        partSlot3.tag = 3
        partSlot3.partNaming = "batteryA0"
        partSlot3.addComponent(partName: "batteryA0Thumbnail")
        self.selectableComponents.append(partSlot3)
        
        partSlot4.tag = 4
        partSlot4.partNaming = "testPhoneFront"
        partSlot4.addComponent(partName: "testPhoneFrontThumbnail@2x")
        self.selectableComponents.append(partSlot4)
        
        partSlot5.tag = 5
        partSlot5.partNaming = "boardA0"
        partSlot5.addComponent(partName: "BoardA0Thumbnail")
        self.selectableComponents.append(partSlot5)
        
        
    }
    
    func loadNewProductTest(fileName: String) -> SKSpriteNode? {
        
        guard let beltBck = self.childNode(withName: "beltBckg") as? SKSpriteNode, let itemScene = SKScene(fileNamed: fileName),
            let partsBck = itemScene.childNode(withName: "testPhoneGuideChasis") as? ItemBaseSprite else {
                
                return nil
        }
        
        partsBck.removeFromParent()
        beltBck.addChild(partsBck)
        
        guard let fillSpace0 = partsBck.childNode(withName: "testPhoneBoardGuideChasis") as? ChassisPart,
            let partScene = SKScene(fileNamed: "BoardA0"),
            let board = partScene.childNode(withName: "boardA0") as? Part,
            let anchor0Space0 = board.childNode(withName: "anchorWelder0") as? ComponentAnchorPoint,
            let anchor1Space0 = board.childNode(withName: "anchorWelder1") as? ComponentAnchorPoint,
            let anchor2Space0 = board.childNode(withName: "anchorWelder2") as? ComponentAnchorPoint,
            let anchor3Space0 = board.childNode(withName: "anchorWelder3") as? ComponentAnchorPoint
            else {
                return nil
        }
        
        anchor0Space0.anchorType = .welder
        anchor1Space0.anchorType = .welder
        anchor2Space0.anchorType = .welder
        anchor3Space0.anchorType = .welder
        
        
        board.partName = board.name!
        board.anchorPoints = [anchor0Space0, anchor1Space0, anchor2Space0, anchor3Space0]
        board.removeFromParent()
        fillSpace0.sceneSelectionDelegate = self
        fillSpace0.designedPart = board
        fillSpace0.expectedPartName = board.name!
        fillSpace0.isUserInteractionEnabled = true
        
        return partsBck
        
    }
    
    
    func loadNewProductTest2(fileName: String) -> ItemUnit? {

        guard let beltBck = self.childNode(withName: "beltBckg") as? SKSpriteNode, let itemScene = SKScene(fileNamed: fileName),
            let group = itemScene.childNode(withName: "testPhoneGuideChasis") as? ChassisGroup else {
                
                return nil
        }
        
        group.removeFromParent()
        beltBck.addChild(group)
        
        // BOARD
        
        guard let fillSpace0 = group.childNode(withName: "testPhoneBoardGuideChasis") as? ChassisPart,
            let partScene = SKScene(fileNamed: "BoardA0"),
            let board = partScene.childNode(withName: "boardA0") as? Part,
            let anchor0Space0 = board.childNode(withName: "anchorWelder0") as? ComponentAnchorPoint,
            let anchor1Space0 = board.childNode(withName: "anchorWelder1") as? ComponentAnchorPoint,
            let anchor2Space0 = board.childNode(withName: "anchorWelder2") as? ComponentAnchorPoint,
            let anchor3Space0 = board.childNode(withName: "anchorWelder3") as? ComponentAnchorPoint
            else {
                return nil
        }
        
        anchor0Space0.anchorType = .welder
        anchor1Space0.anchorType = .welder
        anchor2Space0.anchorType = .welder
        anchor3Space0.anchorType = .welder
        
        
        board.partName = board.name!
        board.anchorPoints = [anchor0Space0, anchor1Space0, anchor2Space0, anchor3Space0]
        board.removeFromParent()
        fillSpace0.sceneSelectionDelegate = self
        fillSpace0.designedPart = board
        fillSpace0.expectedPartName = board.name!
        fillSpace0.isUserInteractionEnabled = true
        
        // MEMORY
        
        guard let fillSpace1 = group.childNode(withName: "testPhoneMemoryGuideChasis") as? ChassisPart,
            let part2Scene = SKScene(fileNamed: "FlashMemoryA0"),
            let memo = part2Scene.childNode(withName: "flashMemoryA0") as? Part,
            let anchor0Space1 = memo.childNode(withName: "anchorGlue0") as? ComponentAnchorPoint,
            let anchor1Space1 = memo.childNode(withName: "anchorGlue1") as? ComponentAnchorPoint
            else {
                return nil
        }

        anchor0Space1.anchorType = .glue
        anchor1Space1.anchorType = .glue
        
        
        memo.partName = memo.name!
        memo.anchorPoints = [anchor0Space1, anchor1Space1]
        memo.removeFromParent()
        fillSpace1.sceneSelectionDelegate = self
        fillSpace1.designedPart = memo
        fillSpace1.expectedPartName = memo.name!
        fillSpace1.isUserInteractionEnabled = true
        
        
        // BATTERY
        
        guard let fillSpace2 = group.childNode(withName: "testPhoneBatteryGuideChasis") as? ChassisPart,
            let part3Scene = SKScene(fileNamed: "BatteryA0"),
            let battery = part3Scene.childNode(withName: "batteryA0") as? Part,
            let anchor0Space2 = battery.childNode(withName: "anchorScrew0") as? ComponentAnchorPoint,
            let anchor1Space2 = battery.childNode(withName: "anchorScrew1") as? ComponentAnchorPoint
            else {
                return nil
        }
        
        anchor0Space2.anchorType = .screw
        anchor1Space2.anchorType = .screw
        
        
        battery.partName = battery.name!
        battery.anchorPoints = [anchor0Space2, anchor1Space2]
        battery.removeFromParent()
        fillSpace2.sceneSelectionDelegate = self
        fillSpace2.designedPart = battery
        fillSpace2.expectedPartName = battery.name!
        fillSpace2.isUserInteractionEnabled = true

        
        // CAMERA
        
        
        guard let fillSpace3 = group.childNode(withName: "testPhoneCameraGuideChasis") as? ChassisPart,
            let part4Scene = SKScene(fileNamed: "CameraA0"),
            let camera = part4Scene.childNode(withName: "cameraA0") as? Part,
            let anchor0Space3 = camera.childNode(withName: "anchorGlue0") as? ComponentAnchorPoint
            else {
                return nil
        }

        anchor0Space3.anchorType = .glue
        
        camera.partName = camera.name!
        camera.anchorPoints = [anchor0Space3]
        camera.removeFromParent()
        fillSpace3.sceneSelectionDelegate = self
        fillSpace3.designedPart = camera
        fillSpace3.expectedPartName = camera.name!
        fillSpace3.isUserInteractionEnabled = true

        
        // GROUP

        group.chassisParts = [fillSpace0, fillSpace1, fillSpace2, fillSpace3]
        group.isItemBase = true
        group.maxScore = 110
        
        var chs = [ChassisGroup]()
        chs.append(group)
        
        let item = ItemUnit(name: "testPhone", manufacturer: "Acme", maxScore: 110, components: chs)
        
        return item


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
            case "partSlot5":
                self.componentSlotTouched(idx: 5)
                
            default:
                print("default")
            }
            
        }
        
    }
    
}

extension GamePlayScene: SelectionHandlerProtocol {
    
    func resetUserSelection() {
        selectionState = .unselected
    }
    
    
    

}
