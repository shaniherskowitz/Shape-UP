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
  var rabbit: SKSpriteNode?
  var snail: SKSpriteNode?
  var cheetta: SKSpriteNode?
  var circle: SKSpriteNode?
  var soundOn =  true
  
  
  override func didMove(to view: SKView) {
    
    sound = self.childNode(withName: "sound") as? SKSpriteNode
    credits = self.childNode(withName: "credits") as? SKLabelNode
    backButton = self.childNode(withName: "back") as? SKSpriteNode
    circle = self.childNode(withName: "circle") as? SKSpriteNode
    snail = self.childNode(withName: "snail") as? SKSpriteNode
    rabbit = self.childNode(withName: "rabbit") as? SKSpriteNode
    cheetta = self.childNode(withName: "cheetta") as? SKSpriteNode
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      switch node {
      case sound:
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
        
      case credits:
        if view != nil {
          let transition:SKTransition = SKTransition.doorway(withDuration: 1)
          let scene:SKScene = CreditsScene(fileNamed: "CreditsScene")!
          
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene, transition: transition)
        }
        
      case backButton:
        if view != nil {
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = MenuScene(fileNamed: "MenuScene")!
          scene.scaleMode = .aspectFill
          
          self.view?.presentScene(scene, transition: transition)
        }
        
      case snail: circle?.position = CGPoint(x: -354.211, y: -626.22)
        
      case rabbit: circle?.position = CGPoint(x: -2.276, y: -626.22)
        
      case cheetta: circle?.position = CGPoint(x: 336.743, y: -626.22)
        
      default: print("no button")
      
    }
    }
  }
}
