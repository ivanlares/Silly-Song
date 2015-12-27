//
//  Global.swift
//  Silly Song
//
//  Created by ivan lares on 12/26/15.
//  Copyright © 2015 ivan lares. All rights reserved.
//

import Foundation

struct Global{
  
  static let soundButtonName = "Sound"
  static let muteButtonName = "Mute"
  
  static let FULL_NAME_TEMP = "<FULL_NAME>"
  static let SHORT_NAME_TEMP = "<SHORT_NAME>"
  
  static let bananaTemplateURL = NSBundle.mainBundle().URLForResource("bananaLyrics", withExtension: "txt")!
  static let bananaTemplate = try! String(contentsOfURL: bananaTemplateURL)

}