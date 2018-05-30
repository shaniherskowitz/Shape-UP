//
//  SettingsScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/29/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//

import SpriteKit


var soundOn: Bool {
  get {
    return UserDefaults.standard.bool(forKey: "soundOn")
  }
  set {
    UserDefaults.standard.set(newValue, forKey: "soundOn")
  }
}
var circlePlace: Float {
  get {
    return UserDefaults.standard.float(forKey: "circlePlace")
  }
  set {
    UserDefaults.standard.set(newValue, forKey: "circlePlace")
  }
}

class SettingsScene: SKScene {
  
  var sound: SKSpriteNode?
  var credits: SKLabelNode?
  var backButton: SKSpriteNode?
  var rabbit: SKSpriteNode?
  var snail: SKSpriteNode?
  var cheetta: SKSpriteNode?
  var circle: SKSpriteNode?
  
  
  override func didMove(to view: SKView) {
    UserDefaults.standard.register(defaults: ["soundOn" : true])
    sound = self.childNode(withName: "sound") as? SKSpriteNode
    credits = self.childNode(withName: "credits") as? SKLabelNode
    backButton = self.childNode(withName: "back") as? SKSpriteNode
    circle = self.childNode(withName: "circle") as? SKSpriteNode
    snail = self.childNode(withName: "snail") as? SKSpriteNode
    rabbit = self.childNode(withName: "rabbit") as? SKSpriteNode
    cheetta = self.childNode(withName: "cheetta") as? SKSpriteNode
    if(circlePlace == 0.0) {
      circlePlace = Float((circle?.position.x)!)
    } else {circle?.position.x = CGFloat(circlePlace)}
    setSound(start: true)
    
  }
  
  func setSound(start: Bool) {
    if (soundOn && !start || !soundOn && start) {
      sound?.texture = SKTexture(imageNamed: "sound off");
      sound?.size = CGSize(width: 231, height: 231);
      sound?.position = CGPoint(x: (sound?.position.x)! - 12, y: (sound?.position.y)! - 2)
    } else {
      sound?.texture = SKTexture(imageNamed: "sound on");
      sound?.size = CGSize(width: 256, height: 256);
      sound?.position = CGPoint(x: (sound?.position.x)! + 12, y: (sound?.position.y)! + 2)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      switch node {
      case sound:
        setSound(start: false)
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
        
      case snail:
        circlePlace = -354.211
        circle?.position = CGPoint(x: -354.211, y: -607.433)
        
      case rabbit:
        circlePlace = -2.276
        circle?.position = CGPoint(x: -2.276, y: -607.433)
        
      case cheetta:
        circlePlace = 336.743
        circle?.position = CGPoint(x: 336.743, y: -607.433)
        
      default: print("no button")
      
    }
    }
  }
}
