//
//  UserSelectionState.swift
//  BlueCollar
//
//  Created by MiniStation on 29/10/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import SpriteKit
import GameplayKit


class UserSelectionState: GKState {
    
    let game: GamePlayScene
    
    let associatedNodeName: String
    
    var associatedNode: SelectableNode? {
        return game.childNode(withName: "//\(associatedNodeName)") as? SelectableNode
    }
    
    init(game: GamePlayScene, associatedNodeName: String) {
        self.game = game
        self.associatedNodeName = associatedNodeName
    }
    
    override func didEnter(from previousState: GKState?) {
        guard let associatedNode = associatedNode else { return }
        associatedNode.isSelected = true
    }
    
    override func willExit(to nextState: GKState) {
        guard let associatedNode = associatedNode else { return }
        associatedNode.isSelected = false
    }


}
