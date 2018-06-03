//
//  Obstacles.swift
//  Shapes
//
//  Created by shani herskowitz on 5/23/18.
//  Copyright © 2018 shani herskowitz. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacles {
  
  var colors = [#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),  #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),  #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),  #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
  var obstacles: [SKNode] = []
  let obstacleSpacing: CGFloat
  var width: CGFloat = 0
  var s = 0.0
  enum Speed: Float {
    case snail = -354.211
    case rabbit = -2.276
    case cheetta =  336.743
  }
  
  init(colors: [UIColor], width: CGFloat, space: CGFloat) {
    self.colors = colors
    self.width = width
    self.obstacleSpacing = space
    
    setSpeed()
  }
  
  func setSpeed() {
    switch circlePlace {
    case Speed.snail.rawValue: s = 5
    case Speed.rabbit.rawValue: s = 4
    case Speed.cheetta.rawValue: s = 3
    default: s = 4
    }
  }
  
  
  /// randomly adds a shape tp the game
  ///
  /// - Returns: the shape so it could be added as a child to the main scene
  func addObstacle() -> SKNode {
    let choice = Int(arc4random_uniform(5))
    var obstacle : SKNode = SKNode()
    switch choice {
    case 0:
      obstacle = addCircleObstacle()
    case 1:
      obstacle = addSquareObstacle()
    case 2:
      obstacle = addPlusObstacle()
    case 3:
      obstacle = addTriangleObstacle()
    case 4:
      obstacle = addDoubleCircle()
      
    //addLineObstacle()
    default:
      print("something went wrong")
    }
    return obstacle
  }
  func addDoubleCircle() -> SKNode {

    let obs = SKNode()
    let shapeSize = Int(arc4random_uniform(100))
    let radius = Int(arc4random_uniform(30)) + 160
    let path = addCircle(shapeSize: shapeSize, r: radius)
    let path2 = addCircle(shapeSize: shapeSize, r: radius + 40)
    
    let obstacle = obstacleByDuplicatingPath(path, clockwise: false)
    let obstacle2 = obstacleByDuplicatingPath(path2, clockwise: true)
    obs.addChild(obstacle)
    obs.addChild(obstacle2)
    obstacles.append(obs)
    obs.position = CGPoint(x: width/2, y: (obstacleSpacing) * CGFloat(obstacles.count))
    let rotate = SKAction.rotate(byAngle:1.0 * CGFloat(Double.pi / 4), duration: 0.0)
    obs.run(rotate)

    let rotateAction = SKAction.rotate(byAngle: 2.0 * CGFloat(Double.pi), duration: Double(s))
    obs.children[0].run(SKAction.repeatForever(rotateAction))
    let rotateAction2 = SKAction.rotate(byAngle: 2.0 * -CGFloat(Double.pi), duration:  Double(s))
    obs.children[1].run(SKAction.repeatForever(rotateAction2))
    
    return obs
  }
  func addCircle(shapeSize: Int, r: Int) -> UIBezierPath {
    let path = UIBezierPath()
    
   // path.move(to: CGPoint(x: 0, y: -200 - shapeSize))
    
   // path.addLine(to: CGPoint(x: 0, y: -160 - shapeSize))
    
    path.addArc(withCenter: CGPoint.zero,
                radius: CGFloat( r + shapeSize),
                startAngle: CGFloat(3.0 * Double.pi / 2),endAngle: CGFloat(0),clockwise: true)
    
    //path.addLine(to: CGPoint(x: 200 + CGFloat(shapeSize), y: 0))
    path.addArc(withCenter: CGPoint.zero,
                radius: CGFloat(r + 40 + shapeSize),
                startAngle: CGFloat(0.0),endAngle: CGFloat(3.0 * Double.pi / 2),clockwise: false)
    return path
  }
  
  /// adds a circle obj to the game
  ///
  /// - Returns: a container with the obj
  func addCircleObstacle() -> SKNode {
    // 1
    let shapeSize = Int(arc4random_uniform(100))
    let path = UIBezierPath()
    // 2
    path.move(to: CGPoint(x: 0, y: -200 - shapeSize))
    // 3
    path.addLine(to: CGPoint(x: 0, y: -160 - shapeSize))
    // 4
    path.addArc(withCenter: CGPoint.zero,
                radius: 160 + CGFloat(shapeSize),
                startAngle: CGFloat(3.0 * Double.pi / 2),endAngle: CGFloat(0),clockwise: true)
    // 5
    path.addLine(to: CGPoint(x: 200 + CGFloat(shapeSize), y: 0))
    path.addArc(withCenter: CGPoint.zero,
                radius: 200 + CGFloat(shapeSize),
                startAngle: CGFloat(0.0),endAngle: CGFloat(3.0 * Double.pi / 2),clockwise: false)
    
    let obstacle = obstacleByDuplicatingPath(path, clockwise: false)
    obstacles.append(obstacle)
    obstacle.position = CGPoint(x: width/2, y: (obstacleSpacing) * CGFloat(obstacles.count))
    
    let choice = Int(arc4random_uniform(2))
    let rotateAction = SKAction.rotate(byAngle: 2.0 * CGFloat(Double.pi), duration: s - Double(choice))
    obstacle.run(SKAction.repeatForever(rotateAction))
    
    return obstacle
    
  }
  
  /// adds a square shape to the game
  ///
  /// - Returns: a container with the shape
  func addSquareObstacle() -> SKNode {
    let path = UIBezierPath(roundedRect: CGRect(x: -250, y: -250,
                                                width: 500, height: 40),cornerRadius: CGFloat(20))
    
    let obstacle = obstacleByDuplicatingPath(path, clockwise: false)
    obstacles.append(obstacle)
    obstacle.position = CGPoint(x: width/2, y: obstacleSpacing * CGFloat(obstacles.count))
    
    let choice = Int(arc4random_uniform(1))
    let rotateAction = SKAction.rotate(byAngle: -2.0 * CGFloat(Double.pi), duration: s - Double(choice))
    obstacle.run(SKAction.repeatForever(rotateAction))
    
    return obstacle
  }
  
  /// adds a windmill shapes item to the game in random sides
  ///
  /// - Returns: a container with the shape
  func addTriangleObstacle() -> SKNode{
    let path = UIBezierPath()
    var k = 1
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 0, y: 250 ))
    path.addLine(to: CGPoint(x: 100, y: 230))
    
    let obstacle = obstacleByDuplicatingPath(path, clockwise: false)
    obstacles.append(obstacle)
    let side = Int(arc4random_uniform(2))
    if side == 1 {k = -1}
    obstacle.position = CGPoint(x: width/2 + 200 * CGFloat(k), y: obstacleSpacing * CGFloat(obstacles.count))
    
    let choice = Int(arc4random_uniform(1))
    let rotateAction = SKAction.rotate(byAngle: -2.0 * CGFloat(Double(k) * Double.pi), duration: s - Double(choice))
    obstacle.run(SKAction.repeatForever(rotateAction))
    
    return obstacle
  }
  
  /// adds two plus shapes rotating in diffrent directions
  ///
  /// - Returns: a container with both plus shapes
  func addPlusObstacle() -> SKNode {
    let path = UIBezierPath(roundedRect: CGRect(x: -21, y: -21,
                                                width: 300, height: 40),cornerRadius: 20)
    let container = SKNode()
    
    let obstacle = obstacleByDuplicatingPath(path, clockwise: true)
    let obstacle2 = obstacleByDuplicatingPath(path, clockwise: false)
    container.addChild(obstacle)
    container.addChild(obstacle2)
    obstacles.append(container)
    
    obstacle.position = CGPoint(x: width/2 - 250, y: obstacleSpacing * CGFloat(obstacles.count))
    obstacle2.position = CGPoint(x: width/2 + 250, y: obstacleSpacing * CGFloat(obstacles.count))
    
    let choice = Int(arc4random_uniform(1))
    let rotateAction = SKAction.rotate(byAngle: 2.0 * CGFloat(-Double.pi), duration: s + Double(choice))
    obstacle.run(SKAction.repeatForever(rotateAction))
    let rotateAction2 = SKAction.rotate(byAngle: 2.0 * CGFloat(Double.pi), duration: rotateAction.duration)
    obstacle2.run(SKAction.repeatForever(rotateAction2))
    
    return container
  }
  
  func addLineObstacle() -> SKNode {
    let path = UIBezierPath(roundedRect: CGRect(x: 100, y: 100,
                                                width: 400, height: 50),cornerRadius: CGFloat(30))
    let pos = CGPoint(x: width/2, y: obstacleSpacing * CGFloat(obstacles.count) + 1)
    let obstacle = lineObstacleByDuplicatingPath(path, clockwise: false, pos: pos)
    obstacles.append(obstacle)
    obstacle.position = pos
    
    let moveLeft = SKAction.move(to: CGPoint(x: width/2, y:  obstacleSpacing * CGFloat(obstacles.count)), duration: 5)
    let moveRight = SKAction.move(to: CGPoint(x: -width/2, y:  obstacleSpacing * CGFloat(obstacles.count)), duration: 5)
    
    obstacle.run(SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight])))
    
    return obstacle
  }
  
  func lineObstacleByDuplicatingPath(_ path: UIBezierPath, clockwise: Bool, pos: CGPoint) -> SKNode {
    let container = SKNode()
    for i in 0...3 {
      let sec = SKShapeNode()
      for _ in 0...5 {
        let section = SKShapeNode(path: path.cgPath)
        
        section.fillColor = colors[i]
        section.strokeColor = colors[i]
        section.position = CGPoint(x: CGFloat(i*350) - 500.0, y: obstacleSpacing * CGFloat(obstacles.count))
        
        
        let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
        sectionBody.categoryBitMask = PhysicsCategory.Obstacle
        sectionBody.collisionBitMask = 0
        sectionBody.contactTestBitMask = PhysicsCategory.Player
        sectionBody.affectedByGravity = false
        section.physicsBody = sectionBody
        
        sec.addChild(section)
      }
      container.addChild(sec)
    }
    
    return container
  }
  
  /// makes four oblects in diffrent colors in a circle
  ///
  /// - Parameters:
  ///   - path: the shape you want duplicate
  ///   - clockwise: the dirrection the shape should move
  /// - Returns: a container with all the shapes inside
  func obstacleByDuplicatingPath(_ path: UIBezierPath, clockwise: Bool) -> SKNode {
    let container = SKNode()
    
    var rotationFactor = CGFloat(Double.pi / 2)
    if !clockwise {
      rotationFactor *= -1
    }
    
    for i in 0...3 {
      let section = SKShapeNode(path: path.cgPath)
      section.fillColor = colors[i]
      section.strokeColor = colors[i]
      if clockwise { invertColors(i: i, section: section) }
      
      section.zRotation = rotationFactor * CGFloat(i);
      
      let sectionBody = SKPhysicsBody(polygonFrom: path.cgPath)
      sectionBody.categoryBitMask = PhysicsCategory.Obstacle
      sectionBody.collisionBitMask = 0
      sectionBody.contactTestBitMask = PhysicsCategory.Player
      sectionBody.affectedByGravity = false
      section.physicsBody = sectionBody
      
      container.addChild(section)
    }
    return container
  }
  
  /// inverts the colors of two shapes going in diffrent directions
  ///
  /// - Parameters:
  ///   - i: the numbers you want to switch
  ///   - section: the shape to invert colors on
  func invertColors(i: Int, section: SKShapeNode) {
    if ((i == 1 || i == 3)) {
      section.fillColor = colors[4 - i]
      section.strokeColor = colors[4 - i]
    } else {
      section.fillColor = colors[2 - i]
      section.strokeColor = colors[2 - i]
    }
  }
  
}
