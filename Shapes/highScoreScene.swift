//
//  highScoreScene.swift
//  Shape Up
//
//  Created by shani herskowitz on 5/24/18.
//  Copyright © 2018 Shani Herskowitz. All rights reserved.
//

import Foundation

import SpriteKit

class highScoreScene: SKScene {
  
  override func didMove(to view: SKView) {
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  let scene = MenuScene(fileNamed: "MenuScene")
  let transition:SKTransition = SKTransition.fade(withDuration: 1)
  scene?.scaleMode = .aspectFill
  
  self.view?.presentScene(scene)
  
  self.view?.presentScene(scene!, transition: transition)
  }
  
}
