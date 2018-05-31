//
//  LoserScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/24/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//

import Foundation

import SpriteKit
import AVFoundation

class LoserScene: SKScene {
  
  let gameoverSound = URL(fileURLWithPath: Bundle.main.path(forResource: "gameover2", ofType: "wav")!)
  var player = AVAudioPlayer()
  override func didMove(to view: SKView) {
   
    if(soundOn) {
      try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try! AVAudioSession.sharedInstance().setActive(true)
      
      try! player = AVAudioPlayer(contentsOf: gameoverSound)
      player.prepareToPlay()
      player.play()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let scene = MenuScene(fileNamed: "MenuScene")
    let transition:SKTransition = SKTransition.doorway(withDuration: 1)
    scene?.scaleMode = .aspectFill
    
    if(soundOn) {player.stop()}
    self.view?.presentScene(scene!, transition: transition)
  }
  
}
