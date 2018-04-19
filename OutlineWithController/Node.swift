//
//  Node.swift
//  OutlineWithController
//
//  Created by Satyabrata Rath on 17/2/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Foundation

class Node: NSObject {
  dynamic var nodeTitle: String
  private var _children: [Node] = []
  dynamic var isLeaf: Bool = false    

    required override init() {
        self.nodeTitle = ""
        super.init()
    }
    
    init(title: String) {
        self.nodeTitle = title
    }
    // Commented for later use of isLeaf
//
//    @objc(initLeaf)
//    convenience init(leaf: Void) {
//        self.init()
//        self.setLeaf(true)
//    }
//
//    private func setLeaf(_ flag: Bool) {
//        self.isLeaf = flag
//    }
//    
    dynamic var children: [Node] {
        get {
            if self.isLeaf {
                return [self]
            } else {
                return _children
            }
        }
        set {
            _children = newValue
        }
    }
}
