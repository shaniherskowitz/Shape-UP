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
  
  var party: SKEmitterNode?
  
  override func didMove(to view: SKView) {
    party = SKEmitterNode(fileNamed: "PartyAnimation.sks")
    party?.position = CGPoint(x: 0, y:-200)
    self.addChild(party!)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  let scene = MenuScene(fileNamed: "MenuScene")
  let transition:SKTransition = SKTransition.doorway(withDuration: 1)
  scene?.scaleMode = .aspectFill
  party?.removeFromParent()
  self.view?.presentScene(scene!, transition: transition)
  }
  
}
