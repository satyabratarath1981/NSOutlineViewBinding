//
//  MainWindowController.swift
//  OutlineWithController
//
//  Created by Satyabrata Rath on 17/2/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@objc class MainWindowController: NSWindowController, CreateUserDelegate,NSWindowDelegate{
    
  dynamic var contents: [AnyObject] = []
    
  @IBOutlet weak var outlineView: NSOutlineView!
  @IBOutlet weak var treeController: NSTreeController!
    
    @IBOutlet weak var boxtreeController: NSBox!
    var myCreateUserWindowController:CreateUser?
    
  override var windowNibName: String? {
    return "MainWindowController"
  }
    func initNodes() {
        let user1 = Node(title: "User")
        let user2 = Node(title: "User")
        contents = [user1,user2]
    }
 
    // MARK: - lifecycle
    override func windowWillLoad() {
        initNodes()
    }
    
    // MARK: - window present as sheet
    @IBAction func addNode(_ sender: NSObject) {
        myCreateUserWindowController = CreateUser(windowNibName: "CreateUser")
        if let aWindow = myCreateUserWindowController?.window {
            window?.beginSheet(aWindow, completionHandler: {(_ returnCode: NSApplication.ModalResponse) -> Void in
                print("Sheet closed")
                switch returnCode {
                case NSModalResponseOK:
                    print("User Created")
                case NSModalResponseCancel:
                    print("User Creation Cancelled")
                default:
                    break
                }
                self.myCreateUserWindowController = nil
            })
        }
        myCreateUserWindowController?.delegate = self
    }
    
    func window(_ window: NSWindow, willPositionSheet sheet: NSWindow, using rect: NSRect) -> NSRect {
        if sheet == self.myCreateUserWindowController?.window
        {
            var rectToReturn = self.boxtreeController.frame
            rectToReturn.origin.y = rectToReturn.origin.y + 682
            return rectToReturn
        }
        else
        {
            return rect
        }
    }
    
    // MARK: - tree controller root and child item
    func createTree(data: AnyObject) {
        var indexPath: IndexPath
        
        if self.treeController.selectedObjects.isEmpty {
            indexPath = IndexPath(index: self.contents.count)
        } else {
            indexPath = self.treeController.selectionIndexPath!
            if (self.treeController.selectedObjects[0] as! Node).isLeaf {
                self.selectParentFromSelection()
            } else {
                indexPath.append((self.treeController.selectedObjects[0] as! Node).children.count)
            }
        }
        
        let node = SubNode()
        node.nodeTitle = "\(data)"
        
        self.treeController.insert(node, atArrangedObjectIndexPath: indexPath)
    }
    
    private func selectParentFromSelection() {
        if !self.treeController.selectedNodes.isEmpty {
            let firstSelectedNode = self.treeController.selectedNodes[0]
            if let parentNode = firstSelectedNode.parent {
                // select the parent
                let parentIndex = parentNode.indexPath
                self.treeController.setSelectionIndexPath(parentIndex)
            } else {
                // no parent exists (we are at the top of tree), so make no selection in our outline
                let selectionIndexPaths = self.treeController.selectionIndexPaths
                self.treeController.removeSelectionIndexPaths(selectionIndexPaths)
            }
        }
    }
}


