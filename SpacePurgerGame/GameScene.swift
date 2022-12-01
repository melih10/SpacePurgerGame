//
//  GameScene.swift
//  SpacePurgerGame
//
//  Created by Melih on 1.12.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var player1 = SKSpriteNode()
    var bg = SKSpriteNode()
    var enemy1 = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        
        let texture = SKTexture(imageNamed: "player1")
        player1 = SKSpriteNode(texture: texture)
        player1.position = CGPoint(x: -self.frame.width / 2.5, y: self.frame.height / (-3))
        player1.size = CGSize(width: self.frame.width / 15, height: self.frame.height / 8)
        player1.zPosition = -1
        self.addChild(player1)
        
        
        let textureBg = SKTexture(imageNamed: "bg-back.png")
        bg = SKSpriteNode(texture: textureBg)
        bg.position = CGPoint(x: 0, y: 0)
        bg.size = CGSize(width: self.frame.width * 1.05, height: self.frame.height * 1.05)
        bg.zPosition = -3
        self.addChild(bg)
        
        self.spinningEnemy()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func spinningEnemy(){
       // let randomFloat = Float.random(in: 3...50)
       // print(randomFloat)
       
        let numbers = [2.80, 3.00, 3.50, 6.00, 30.00, 40.00, -2.80, -3.00, -3.50, -6.00, -30.00, -40.00,]
        let shuffledNumbers = numbers.randomElement()
        print(shuffledNumbers!)
        
        let enemyTexture = SKTexture(imageNamed: "enemy1")
        enemy1 = SKSpriteNode(texture: enemyTexture)
        enemy1.position = CGPoint(x: self.frame.width / 10, y: self.frame.height / shuffledNumbers!)
        enemy1.size = CGSize(width: self.frame.width / 11, height: self.frame.height / 8)

        self.addChild(enemy1)
        
        let enemyFrame2 = SKTexture(imageNamed: "enemy2")
        let enemyFrame3 = SKTexture(imageNamed: "enemy3")
        let enemyFrame4 = SKTexture(imageNamed: "enemy4")
        let animation = SKAction.animate(with: [enemyTexture, enemyFrame3, enemyFrame4, enemyFrame2], timePerFrame: 0.07)
        
        enemy1.run(SKAction.repeatForever(animation))
    }
}
