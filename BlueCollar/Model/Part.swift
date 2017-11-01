//
//  Part.swift
//  BlueCollar
//
//  Created by MiniStation on 1/11/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit

enum PartProgressState {
    case incomplete
    case complete
}

class Part: SKSpriteNode {
    
    var partName: String!
    
    var pointsToComplete: Int!
    
    var isPlaced: Bool = false
    
    var currentPoints: Int = 0 {
        didSet {
            if currentPoints >= pointsToComplete {
                state = .complete
            }
        }
        
    }
    
    var state: PartProgressState = .incomplete {
        didSet {
            if state == .complete {
                self.isUserInteractionEnabled = false
            } else {
                self.isUserInteractionEnabled = true
            }
        }
    }


    var anchorPoints = [ComponentAnchorPoint]()
    
    var childrenParts = [Part]()
    
    
//    init(texture: SKTexture, expectedPartName: String, pointsComplete: Int, currentPoints: Int, anchors: [ComponentAnchorPoint], parts: [Part], placed: Bool) {
//        self.partName = expectedPartName
//        self.pointsToComplete = pointsComplete
//        self.currentPoints = currentPoints
//        self.anchorPoints = anchors
//        self.childrenParts = parts
//        self.isPlaced = placed
//
//        super.init(texture: texture, color: .clear, size: texture.size())
//  }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
    }
    
    
}
