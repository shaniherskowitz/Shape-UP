//
//  SettingsScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/29/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//

import SpriteKit

class SettingsScene: SKScene {
  
  var sound: SKSpriteNode?
  var credits: SKLabelNode?
  var backButton: SKSpriteNode?
  var soundOn =  true
  
  //let playButtonTex = SKTexture(imageNamed: "play")
  
  override func didMove(to view: SKView) {
    
    sound = self.childNode(withName: "sound") as? SKSpriteNode
    credits = self.childNode(withName: "credits") as? SKLabelNode
    backButton = self.childNode(withName: "back") as? SKSpriteNode
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      if node == sound {
        if (soundOn) {
          sound?.texture = SKTexture(imageNamed: "sound off");
          sound?.size = CGSize(width: 231, height: 231);
          sound?.position = CGPoint(x: (sound?.position.x)! - 12, y: (sound?.position.y)! - 2)
        } else {
          sound?.texture = SKTexture(imageNamed: "sound on");
          sound?.size = CGSize(width: 256, height: 256);
          sound?.position = CGPoint(x: (sound?.position.x)! + 12, y: (sound?.position.y)! + 2)
        }
        soundOn = !soundOn
      } else if node == credits {
        if view != nil {
          let transition:SKTransition = SKTransition.doorway(withDuration: 1)
          let scene:SKScene = CreditsScene(fileNamed: "CreditsScene")!
          
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene, transition: transition)
        }
      } else if node == backButton {
        if view != nil {
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = MenuScene(fileNamed: "MenuScene")!
          scene.scaleMode = .aspectFill
          
          self.view?.presentScene(scene, transition: transition)
        }
    }
  }
}
}
