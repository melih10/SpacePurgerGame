//
//  GameScene.swift
//  SpacePurgerGame
//
//  Created by Melih on 1.12.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player1 = SKSpriteNode()
    var bg = SKSpriteNode()
    var enemy1 = SKSpriteNode()
    var bullet = SKSpriteNode()
    
    enum ColliderType : UInt32{
        case Player = 1
        case Bullet = 2
        case Enemy = 4
    }
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameStarted = false
    var buttonLabel = SKLabelNode()
    var isEnemyAlive = true
    
    override func didMove(to view: SKView) {
        
        //Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        //Player's Spaceship
        let texture = SKTexture(imageNamed: "player1")
        player1 = SKSpriteNode(texture: texture)
        player1.position = CGPoint(x: -self.frame.width / 2.5, y: self.frame.height / (-3))
        player1.size = CGSize(width: self.frame.width / 15, height: self.frame.height / 8)
        player1.zPosition = 1
        self.addChild(player1)
        
        //Backgroung Image
        let textureBg = SKTexture(imageNamed: "bg-back.png")
        bg = SKSpriteNode(texture: textureBg)
        bg.position = CGPoint(x: 0, y: 0)
        bg.size = CGSize(width: self.frame.width * 1.05, height: self.frame.height * 1.05)
        bg.zPosition = -3
        self.addChild(bg)
        
        //Label
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 70
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: self.frame.width / 2.5, y: self.frame.height / 3)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        // Button
        buttonLabel.fontSize = 70
        buttonLabel.fontColor = .white
        buttonLabel.fontName = "Helvetica"
        buttonLabel.text = ""
        buttonLabel.position = CGPoint(x: 0, y: 0)
        buttonLabel.zPosition = 2
        self.addChild(buttonLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    //  if contact.bodyA.collisionBitMask == ColliderType.Bullet.rawValue || contact.bodyB.collisionBitMask == ColliderType.Enemy.rawValue {
        
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}

        let sortedNodes = [nodeA, nodeB].sorted { $0.name ?? "" < $1.name ?? ""  }
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]

            print("contact")

            firstNode.isHidden = true
            secondNode.isHidden = true

            firstNode.removeFromParent()
            secondNode.removeFromParent()
            score += 1
            scoreLabel.text = String(score)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameStarted == false {
            
            let wait1 = SKAction.wait(forDuration: 1)
            let personTimer = SKAction.repeatForever(SKAction.sequence([wait1, SKAction.run {
                self.SpinningEnemy()
            }]))
            self.run(personTimer, withKey: "SpinningEnemy")
            
            let wait2 = SKAction.wait(forDuration: 0.5)
            let bulletTimer = SKAction.repeatForever(SKAction.sequence([wait2, SKAction.run {

                self.spawnBullets()
            }]))
            self.run(bulletTimer, withKey: "spawnBullets")
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            player1.position.y = location.y
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let wait1 = SKAction.wait(forDuration: 0.5)
        let personTimer = SKAction.repeatForever(SKAction.sequence([wait1, SKAction.run {
            self.SpinningEnemy() // spawnBike() etc. for each different timer
           // self.spawnBullets()
        }]))
        self.run(personTimer, withKey: "SpinningEnemy")
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if score >= 10 {
            
            buttonLabel.text = "Well Done!Go to Next Level"
            enemy1.isHidden = true
            player1.isHidden = true
            bullet.isHidden = true

            let wait1 = SKAction.wait(forDuration: 0)
            let personTimer = SKAction.repeatForever(SKAction.sequence([wait1, SKAction.run {
                self.SpinningEnemy()
            }]))
            self.run(personTimer, withKey: "SpinningEnemy")
            
            let wait2 = SKAction.wait(forDuration: 0)
            let bulletTimer = SKAction.repeatForever(SKAction.sequence([wait2, SKAction.run {

                self.spawnBullets()
            }]))
            self.run(bulletTimer, withKey: "spawnBullets")
            
            gameStarted = true
        }}
    
    func SpinningEnemy(){
        let numbers = [2.80, 3.00, 3.50, 6.00, 10.00, 30.00, 40.00, -2.80, -3.00, -3.50, -6.00, -10.00, -30.00, -40.00]
        let shuffledNumbers = numbers.randomElement()
        print(shuffledNumbers!)
        
        let enemyTexture = SKTexture(imageNamed: "enemy1")
        enemy1 = SKSpriteNode(texture: enemyTexture)
        enemy1.size = CGSize(width: self.frame.width / 11, height: self.frame.height / 8)
        let sizeEnemy = enemy1.size
        enemy1.zPosition = 1
        addChild(enemy1)
        
        let enemyFrame2 = SKTexture(imageNamed: "enemy2")
        let enemyFrame3 = SKTexture(imageNamed: "enemy3")
        let enemyFrame4 = SKTexture(imageNamed: "enemy4")
        let animation = SKAction.animate(with: [enemyTexture, enemyFrame3, enemyFrame4, enemyFrame2], timePerFrame: 0.075)
        enemy1.run(SKAction.repeatForever(animation))
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width / 3, y: self.frame.height / shuffledNumbers!))
        path.addLine(to: CGPoint(x: -self.frame.width / 0.1, y: self.frame.height / shuffledNumbers!))
      
        let moveEnemy = SKAction.follow(path.cgPath, asOffset: false, orientToPath: false, speed: 400)
        enemy1.run(moveEnemy)
      //  if enemy1.position == CGPoint(x: -self.frame.width / 2.2, y: self.frame.height / shuffledNumbers!) {
      //      self.enemy1.isHidden = true
      //  }
        
        enemy1.physicsBody = SKPhysicsBody(texture: enemyTexture, size: sizeEnemy)
        enemy1.physicsBody?.affectedByGravity = false
       
        enemy1.physicsBody?.collisionBitMask = ColliderType.Bullet.rawValue
    }
    
    func spawnBullets(){
        let bulletTexture = SKTexture(imageNamed: "shoot2")
        bullet = SKSpriteNode(texture: bulletTexture)
        bullet.size = CGSize(width: self.frame.width / 11, height: self.frame.height / 25)
        let sizeB = bullet.size
        bullet.zPosition = 1
        bullet.position = CGPointMake(player1.position.x, player1.position.y)
        let action = SKAction.moveTo(x: self.size.width + 30, duration: 1.0)
        bullet.run(SKAction.repeatForever(action))
        bullet.physicsBody = SKPhysicsBody(rectangleOf: sizeB)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.isDynamic = false
        addChild(bullet)
        
        bullet.physicsBody?.contactTestBitMask = ColliderType.Bullet.rawValue
        bullet.physicsBody?.categoryBitMask = ColliderType.Bullet.rawValue
        bullet.physicsBody?.collisionBitMask = ColliderType.Enemy.rawValue
    }
}
