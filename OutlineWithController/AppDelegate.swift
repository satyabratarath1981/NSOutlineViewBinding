//
//  AppDelegate.swift
//  OutlineWithController
//
//  Created by Satyabrata Rath on 17/2/18.
//  Copyright © 2018 Exilant. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  var mainWindowController: MainWindowController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
      
    let mainWindowController = MainWindowController()
    mainWindowController.showWindow(self)
    
    self.mainWindowController = mainWindowController
  }
}

