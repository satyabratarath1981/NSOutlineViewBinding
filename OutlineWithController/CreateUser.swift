//
//  CreateUser.swift
//  OutlineWithController
//
//  Created by satyabrata rath on 23/02/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

// MARK: - protocol for access main window controller methods

protocol CreateUserDelegate: class {
    func createTree(data:AnyObject)
}

class CreateUser: NSWindowController{
    @IBOutlet weak var buttonCreateUser: NSButton!
    @IBOutlet weak var userTextField: NSTextField!
    
    // MARK: - protocol stufs for access main window controller methods
    weak var delegate: CreateUserDelegate?
    var data:AnyObject?
    var createUserWindow: CreateUser?
    
    // MARK: - lifecycle
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    // MARK: - action buttons
    
    @IBAction func createUser(_ sender: Any) {
        let string = userTextField.stringValue
        if !string.isEmpty{
            delegate?.createTree(data: userTextField.stringValue as AnyObject)
            window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseOK)
        }
        else{
            window?.shakeWindow()
            buttonCreateUser.isEnabled = true
        }
    }
    
    @IBAction func cancelUser(_ sender: Any) {
        window?.sheetParent?.endSheet(window!, returnCode: NSModalResponseCancel)
    }
}

extension NSWindow {
    
    func shakeWindow(){
        let numberOfShakes      = 3
        let durationOfShake     = 0.25
        let vigourOfShake : CGFloat = 0.015
        
        let frame : CGRect = self.frame
        let shakeAnimation :CAKeyframeAnimation  = CAKeyframeAnimation()
        
        let shakePath = CGMutablePath()
        shakePath.move(to: CGPoint(x: frame.minX, y: frame.minY))
        
        for _ in 0...numberOfShakes-1 {
            shakePath.addLine(to: CGPoint(x: frame.minX - frame.size.width * vigourOfShake, y: frame.minY))
            shakePath.addLine(to: CGPoint(x: frame.minX + frame.size.width * vigourOfShake, y: frame.minY))
        }
        
        shakePath.closeSubpath()
        
        shakeAnimation.path = shakePath;
        shakeAnimation.duration = durationOfShake;
        
        self.animations = ["frameOrigin":shakeAnimation]
        self.animator().setFrameOrigin(self.frame.origin)
    }
    
}
