//
//  highScoreScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/24/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//

import Foundation

import SpriteKit
import AVFoundation

class highScoreScene: SKScene {
  
  var party: SKEmitterNode?
  let highscoreSound =  URL(fileURLWithPath: Bundle.main.path(forResource: "highscore", ofType: "mp3")!)
  var player = AVAudioPlayer()
  
  override func didMove(to view: SKView) {
    party = SKEmitterNode(fileNamed: "PartyAnimation.sks")
    party?.position = CGPoint(x: 0, y:-200)
    self.addChild(party!)
    if(soundOn) {
      try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
      try! AVAudioSession.sharedInstance().setActive(true)
      
      try! player = AVAudioPlayer(contentsOf: highscoreSound)
      player.prepareToPlay()
      player.play()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  let scene = MenuScene(fileNamed: "MenuScene")
  self.removeAllActions()
  let transition:SKTransition = SKTransition.doorway(withDuration: 1)
  scene?.scaleMode = .aspectFill
  if(soundOn) {player.stop()}
  self.view?.presentScene(scene!, transition: transition)
  }
  
}
