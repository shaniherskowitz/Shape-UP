//
//  EndScene.swift
//  Shapes
//
//  Created by shani herskowitz on 5/23/18.
//  Copyright © 2018 shani herskowitz. All rights reserved.
//


import GameKit

// Global scope (I generally put these in a new file called Global.swift)

class MenuScene: SKScene , GKGameCenterControllerDelegate {

  var playButton: SKSpriteNode?
  var score: SKLabelNode?
  var settings: SKSpriteNode?
  var leader: SKLabelNode?
  let clickSound = SKAction.playSoundFileNamed("click", waitForCompletion: false)
  // Declare a new node, then initialize it
  var highscore = 0
  //let playButtonTex = SKTexture(imageNamed: "play")
  
  override func didMove(to view: SKView) {

    highscore = UserDefaults.standard.integer(forKey: "highScore")
    playButton = self.childNode(withName: "playNode") as? SKSpriteNode
    settings = self.childNode(withName: "settings") as? SKSpriteNode
    score = self.childNode(withName: "score") as? SKLabelNode
    leader = self.childNode(withName: "leaderboard") as? SKLabelNode
    score?.text = String(UserDefaults.standard.integer(forKey: "highScore"))
    score?.fontName = "Chalkboard SE"
    
    saveHighscore(gameScore: highScore)
    
  }

  //shows leaderboard screen
  func showLeader() {
    let viewControllerVar = self.view?.window?.rootViewController
    let gKGCViewController = GKGameCenterViewController()
    gKGCViewController.gameCenterDelegate = self
    viewControllerVar?.present(gKGCViewController, animated: true, completion: nil)
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
      } else if node == leader {
        showLeader()
      }
    }
    }
   //sends the highest score to leaderboard
  func saveHighscore(gameScore: Int) {
    print ("You have a high score!")
    print("\n Attempting to authenticating with GC...")
    
    if GKLocalPlayer.localPlayer().isAuthenticated {
      print("\n Success! Sending highscore of \(String(describing: score)) to leaderboard")

      let my_leaderboard_id = "shapeup"
      let scoreReporter = GKScore(leaderboardIdentifier: my_leaderboard_id)
      
      scoreReporter.value = Int64(gameScore)
      let scoreArray: [GKScore] = [scoreReporter]
      
      GKScore.report(scoreArray, withCompletionHandler: {error -> Void in
        if error != nil {
          print("An error has occured:")
          print("\n \(String(describing: error)) \n")
        }
      })
    }
  }
    
    
    // Gamecenter
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
    }
  }


