import UIKit
import SpriteKit

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = MenuScene(fileNamed: "MenuScene")
    let skView = self.view as! SKView
    skView.showsFPS = false
    skView.showsNodeCount = false
    skView.ignoresSiblingOrder = true
    scene?.scaleMode = .aspectFill
    skView.presentScene(scene)
    print("new game")
    
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
}


