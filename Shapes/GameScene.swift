import SpriteKit
import GameplayKit

struct PhysicsCategory {
  static let Player: UInt32 = 1
  static let Obstacle: UInt32 = 2
  static let Edge: UInt32 = 4
  static let Color: UInt32 = 5
}

var highScore: Int {
  get {
    return UserDefaults.standard.integer(forKey: "highScore")
  }
  set {
    UserDefaults.standard.set(newValue, forKey: "highScore")
  }
}
class GameScene: SKScene {
  
  let colors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),  #colorLiteral(red: 0.8823529412, green: 0.4196078431, blue: 0.3529411765, alpha: 1),  #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
  let player = SKShapeNode(circleOfRadius: 40)
  let obstacleSpacing: CGFloat = 1000
  let cameraNode = SKCameraNode()
  let scoreLabel = SKLabelNode()
  let hsButton = SKSpriteNode()
  var addObstacles: Obstacles?
  var score = 0
  var stopped = false
  
  override func didMove(to view: SKView) {
    addObstacles = Obstacles(colors: self.colors, width: size.width, space: obstacleSpacing)
    self.backgroundColor = .black
    setupPlayerAndObstacles()
    physicsWorld.contactDelegate = self
    addChild(cameraNode)
    camera = cameraNode
    setUpHighScore()
    cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
    scoreLabel.position = CGPoint(x: -450, y: 810)
    scoreLabel.fontColor = .white
    scoreLabel.fontSize = 200
    scoreLabel.text = String(score)
    scoreLabel.fontName = "Chalkboard SE"
    cameraNode.addChild(scoreLabel)
  }
  
  func setUpHighScore() {
    let hsLabel = SKLabelNode()
    hsButton.position = CGPoint(x: 450, y: 850)
    hsButton.size = CGSize(width: 150, height: 150)
    hsButton.texture = SKTexture(imageNamed: "High Score")
    cameraNode.addChild(hsButton)
    
    hsLabel.position = CGPoint(x: 450, y: 940)
    hsLabel.text = String(highScore)
    hsLabel.fontName = "Chalkboard SE"
    hsLabel.fontSize = 70
    cameraNode.addChild(hsLabel)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    player.physicsBody?.velocity.dy = 1000.0
    if let touch = touches.first {
      let pos = touch.location(in: self)
      let node = self.atPoint(pos)
      
      if node == hsButton {
//         highScore = 0
//         print("updated")
        /* if(!stopped) {
         
         self.pauseButton.texture = SKTexture(imageNamed: "play")
         self.stopped = true
         print("pause")
         self.view?.isPaused = true
         
         
         } else {
         pauseButton.texture = SKTexture(imageNamed: "pause")
         stopped = false
         
         self.view?.isPaused = false
         }
         } else { player.physicsBody?.velocity.dy = 1000.0 }*/
      }
    }
  }
  
  override func update(_ currentTime: TimeInterval) {
    if player.position.y > obstacleSpacing * CGFloat((addObstacles?.obstacles.count)! - 2) {
      print("score")
      score += 1
      scoreLabel.text = String(score)
      scoreLabel.fontName = "Chalkboard SE"
      addChild((addObstacles?.addObstacle())!)
    }
    
    let playerPositionInCamera = cameraNode.convert(player.position, from: self)
    if playerPositionInCamera.y > 0 && !cameraNode.hasActions() {
      cameraNode.position.y = player.position.y
    }
    
    if playerPositionInCamera.y < -size.height/2 {
      dieAndRestart()
    }
  }
  
  /// sets up the player and starting shapes
  func setupPlayerAndObstacles() {
    addChild((addObstacles?.addObstacle())!)
    addChild((addObstacles?.addObstacle())!)
    addChild((addObstacles?.addObstacle())!)
    addPlayer()
    
    let playerBody = SKPhysicsBody(circleOfRadius: 30)
    playerBody.mass = 1.5
    playerBody.categoryBitMask = PhysicsCategory.Player
    playerBody.collisionBitMask = 4
    player.physicsBody = playerBody
    
    let ledge = SKNode()
    ledge.position = CGPoint(x: size.width/2, y: 160)
    let ledgeBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 10))
    ledgeBody.isDynamic = false
    ledgeBody.categoryBitMask = PhysicsCategory.Edge
    ledgeBody.collisionBitMask = 8
    ledge.physicsBody = ledgeBody
    addChild(ledge)
    physicsWorld.gravity.dy = -22
  }
  
  func changeColor(point: CGPoint) {
    let color = SKShapeNode()
    
    color.position = point
    let colorBody = SKPhysicsBody()
    colorBody.isDynamic = false
    colorBody.categoryBitMask = PhysicsCategory.Color
    color.physicsBody = colorBody
    color.fillColor = .white
    addChild(color)
  }
  
  
  /// adds the player to the game
  func addPlayer() {
    setPlayerColor()
    player.position = CGPoint(x: size.width/2, y: 200)
    
    addChild(player)
  }
  
  /// sets random color for player ball
  func setPlayerColor(){
    let choice = Int(arc4random_uniform(4))
    player.fillColor = colors[choice]
    player.strokeColor = player.fillColor
    
  }
  
  /// when player dies the game restarts
  func dieAndRestart() {
    cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
    print("boom")
    player.physicsBody?.velocity.dy = 0
    player.removeFromParent()
    for node in (addObstacles?.obstacles)! {
      node.removeFromParent()
    }
    addObstacles?.obstacles.removeAll()
    var scene:SKScene?
    
    if( score > highScore) {
      highScore = score
      scene = highScoreScene(fileNamed: "highScoreScene")
      
    } else {
      scene = LoserScene(fileNamed: "LoserScene")
      
    }
    let transition:SKTransition = SKTransition.doorsCloseVertical(withDuration: 1)
    
    
    self.view?.showsFPS = false
    self.view?.showsNodeCount = false
    self.view?.ignoresSiblingOrder = true
    scene?.scaleMode = .aspectFill
    let s = scene?.childNode(withName: "score") as? SKLabelNode
    let myS = scene?.childNode(withName: "myscore") as? SKLabelNode
    
    s?.text = String(highScore)
    s?.fontName = "Chalkboard SE"
    myS?.text = String(score)
    myS?.fontName = "Chalkboard SE"
    
    self.view?.presentScene(scene!, transition: transition)
    
    
  }
  
}

// MARK: - COLLISION
extension GameScene: SKPhysicsContactDelegate {
  
  /// check for collisions with the diffrent shapes in the game
  ///
  /// - Parameter contact: the shape the player contacted
  func didBegin(_ contact: SKPhysicsContact) {
    
    if let nodeA = contact.bodyA.node as? SKShapeNode, let nodeB = contact.bodyB.node as? SKShapeNode {
      
      if nodeA.parent != nil && nodeA.fillColor != nodeB.fillColor {
        dieAndRestart()
      }
    }
    if let nodeA2 = contact.bodyA.node as? SKShapeNode, let nodeB2 = contact.bodyB.node {
      if nodeA2.physicsBody?.categoryBitMask == PhysicsCategory.Edge &&
        nodeB2.physicsBody?.categoryBitMask == PhysicsCategory.Obstacle {
        nodeB2.removeFromParent()
        
      }
      if nodeB2.physicsBody?.categoryBitMask == PhysicsCategory.Edge &&
        nodeA2.physicsBody?.categoryBitMask == PhysicsCategory.Obstacle {
        nodeA2.removeFromParent()
        
      }
    }
  }
}
