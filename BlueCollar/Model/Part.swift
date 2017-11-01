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
    
    var anchorPoints = [ComponentAnchorPoint]()
    
    var isCompleted: Bool {
        // REFACTOR
        get {
            var r = false
            for anch in anchorPoints {
                if anch.state == .initial {
                    r = false
                    state = .incomplete
                } else {
                    state = .complete
                    r = true
                }
            }
            return r
        }
    }
    
    
    var score: Int {
        get {
            var sum = 0
            anchorPoints.forEach({ sum += $0.score})
            return sum
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


    
    
}
