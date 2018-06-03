import GameKit

class GameViewController: UIViewController {

  var gcEnabled = Bool() // Check if the user has Game Center enabled
  var gcDefaultLeaderBoard = String() // Check the default leaderboardID
  let LEADERBOARD_ID = "com.score.shapeup"
  var score =  UserDefaults.standard.integer(forKey: "highScore")
  
  override func viewDidLoad() {
    authenticateLocalPlayer()
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
  // MARK: - AUTHENTICATE LOCAL PLAYER
  func authenticateLocalPlayer() {
    let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
    
    localPlayer.authenticateHandler = {(ViewController, error) -> Void in
      if((ViewController) != nil) {
        // 1. Show login if player is not logged in
        self.present(ViewController!, animated: true, completion: nil)
      } else if (localPlayer.isAuthenticated) {
        // 2. Player is already authenticated & logged in, load game center
        self.gcEnabled = true
        
        // Get the default leaderboard ID
        localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: { (leaderboardIdentifer, error) in
          if error != nil { print(error as Any)
          } else { self.gcDefaultLeaderBoard = leaderboardIdentifer! }
        })
        
      } else {
        // 3. Game center is not enabled on the users device
        self.gcEnabled = false
        print("Local player could not be authenticated!")
        print(error as Any)
      }
    }
  }
  }


