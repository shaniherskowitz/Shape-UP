//
//  EndScene.swift
//  Shapes
//
//  Created by shani herskowitz on 5/23/18.
//  Copyright © 2018 shani herskowitz. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
  
  var playButton: SKSpriteNode?
  var score: SKLabelNode?
  var settings: SKSpriteNode?
  let clickSound = SKAction.playSoundFileNamed("click", waitForCompletion: false)
  //let playButtonTex = SKTexture(imageNamed: "play")
  
  override func didMove(to view: SKView) {
    
    playButton = self.childNode(withName: "playNode") as? SKSpriteNode
    settings = self.childNode(withName: "settings") as? SKSpriteNode
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
          let transition:SKTransition = SKTransition.fade(withDuration: 0.1)
          let scene:SKScene = GameScene(size: CGSize(width: 1536, height: 2048))
          if soundOn {run(clickSound)}
          self.view?.showsFPS = false
          self.view?.showsNodeCount = false
          self.view?.ignoresSiblingOrder = true
          scene.scaleMode = .aspectFill
          self.view?.presentScene(scene, transition: transition)
        }
      } else if node == settings {
        if view != nil {
          if soundOn {run(clickSound)}
          let transition:SKTransition = SKTransition.doorway(withDuration: 1)
          let scene:SKScene = SettingsScene(fileNamed: "SettingsScene")!
          
          scene.scaleMode = .aspectFill
          
          self.view?.presentScene(scene, transition: transition)
        }
      }
      
    }
  }
}
