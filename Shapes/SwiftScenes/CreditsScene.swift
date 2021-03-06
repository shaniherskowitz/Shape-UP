//
//  CreditsScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/24/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//


import SpriteKit

class CreditsScene: SKScene {
  
  var backButton: SKSpriteNode?
  let clickSound = SKAction.playSoundFileNamed("click", waitForCompletion: false)
  
  override func didMove(to view: SKView) {
    backButton = self.childNode(withName: "back") as? SKSpriteNode
    

  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      if node == backButton {
        if view != nil {
          if soundOn {run(clickSound)}
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = SettingsScene(fileNamed: "SettingsScene")!
          scene.scaleMode = .aspectFill 
          self.view?.presentScene(scene, transition: transition)
        }
      }
    }
  }
}
