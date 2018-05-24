//
//  CreditsScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/24/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//


import SpriteKit

class CreditsScene: SKScene {
  
  var backButton: SKSpriteNode?
  
  override func didMove(to view: SKView) {
    backButton = self.childNode(withName: "back") as? SKSpriteNode
    

  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      if node == backButton {
        if view != nil {
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = MenuScene(fileNamed: "MenuScene")!
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene)
          
          self.view?.presentScene(scene, transition: transition)
        }
      }
    }
  }
}
