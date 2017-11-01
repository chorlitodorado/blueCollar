//
//  File.swift
//  BlueCollar
//
//  Created by MiniStation on 1/11/17.
//  Copyright © 2017 mcl. All rights reserved.
//

import Foundation



final class UserSelectionManager {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared = UserSelectionManager()

    var selectionState: SelectionState = .unselected
    var selectedSlotPartName: String = ""

}
