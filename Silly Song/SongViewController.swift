//
//  SongViewController.swift
//  Silly Song
//
//  Created by ivan lares on 12/26/15.
//  Copyright © 2015 ivan lares. All rights reserved.
//

import UIKit
import AVFoundation

class SongViewController: UIViewController{
  
  let synthesizer = AVSpeechSynthesizer()
  
  @IBOutlet weak var soundButton: UIButton!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var textField: UITextField!
  
  // MARK: - Life Cycle 
  
  override func viewDidLoad() {
    soundButton.setBackgroundImage(UIImage(named: Global.muteButtonName), forState: .Selected)
    textField.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    textView.setContentOffset(CGPointZero, animated: false)
  }
  
  // MARK: - Lyrics
  
  func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercaseString.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: NSLocale.currentLocale())
    let vowelSet = NSCharacterSet(charactersInString: "aeiouy")
    
    // Get Range of first vowel
    if let firstVowelRange = lowercaseName.rangeOfCharacterFromSet(vowelSet, options:.CaseInsensitiveSearch){
      return
        lowercaseName.substringFromIndex(firstVowelRange.startIndex)
    }
    
    // No vowels, return the full name
    return lowercaseName
  }
  
  func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    var customLyrics = lyricsTemplate as NSString
    customLyrics = customLyrics.stringByReplacingOccurrencesOfString(Global.FULL_NAME_TEMP, withString: fullName)
    customLyrics = customLyrics.stringByReplacingOccurrencesOfString(Global.SHORT_NAME_TEMP, withString: shortNameFromName(fullName))
    
    return customLyrics as String
  }
  
  // MARK: - Dictation 
  
  func dictate(text: String?) {
    if let text = text {
      let utterance = AVSpeechUtterance(string: text)
      utterance.voice = AVSpeechSynthesisVoice(identifier: "en-US")

      synthesizer.speakUtterance(utterance)
      
    }
  }
  
  // MARK: - Target Action
  
  @IBAction func soundButtonWasTouched(sender: UIButton) {
    if sender.selected{
      sender.selected = false
      if !synthesizer.speaking{
        dictate(textView.text)
      }
    } else {
      sender.selected = true
      synthesizer.stopSpeakingAtBoundary(.Word)
    }
  }
  
}

extension SongViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(textField: UITextField) {
    textField.text = nil
    textView.text = nil
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    if let name = textField.text{
      guard !name.isEmpty else {return}
      textField.text = textField.text?.capitalizedString
      textView.text = lyricsForName(Global.bananaTemplate, fullName: name)
      dictate(textView.text)
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}