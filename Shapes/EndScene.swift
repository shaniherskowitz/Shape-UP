//
//  EndScene.swift
//  Shapes
//
//  Created by shani herskowitz on 5/23/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import SpriteKit

class EndScene: SKScene {
  
  var playButton: SKSpriteNode?
  var score: SKLabelNode?
  var credits: SKLabelNode?
  
  //let playButtonTex = SKTexture(imageNamed: "play")
  
  override func didMove(to view: SKView) {
    
    playButton = self.childNode(withName: "playNode") as? SKSpriteNode
    credits = self.childNode(withName: "credits") as? SKLabelNode
    score = self.childNode(withName: "score") as? SKLabelNode
    score?.text = String(UserDefaults.standard.integer(forKey: "highScore"))
    score?.fontName = "Chalkboard SE"
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      if node == playButton {
        if view != nil {
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = GameScene(size: CGSize(width: 1536, height: 2048))
          
          self.view?.showsFPS = false
          self.view?.showsNodeCount = false
          self.view?.ignoresSiblingOrder = true
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene)
          
          self.view?.presentScene(scene, transition: transition)
        }
      } else if node == credits {
        if view != nil {
          let transition:SKTransition = SKTransition.fade(withDuration: 1)
          let scene:SKScene = CreditsScene(fileNamed: "CreditsScene")!
          
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene)
          
          self.view?.presentScene(scene, transition: transition)
        }
      }
      
    }
  }
}
