//
//  SettingsView.swift
//  Ultimate Pong
//
//  Created by Andrew Masters on 9/15/17.
//  Copyright © 2017 Andrew Masters. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background = SKSpriteNode(imageNamed: "GameScreen")
    var ball = SKSpriteNode()
    var leftPaddle = SKSpriteNode()
    var rightPaddle = SKSpriteNode()
    var leftGoal = SKSpriteNode()
    var rightGoal = SKSpriteNode()
    var scoreLeftLbl = SKLabelNode()
    var scoreRightLbl = SKLabelNode()
    var scoreLeftNum = 0
    var scoreRightNum = 0
    
    var border: SKPhysicsBody!
    let backgroundLights = SKSpriteNode(fileNamed: "Lights.sks")
    
    override func didMove(to view: SKView) {
//        background.position = CGPoint(x: self.frame.minX, y: self.frame.minY)
//        addChild(background)
//        backgroundLights?.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        addChild(backgroundLights!)
        
        border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        rightPaddle = self.childNode(withName: "rightPaddle") as! SKSpriteNode
        leftPaddle = self.childNode(withName: "leftPaddle") as! SKSpriteNode
        leftGoal = self.childNode(withName: "leftGoal") as! SKSpriteNode
        rightGoal = self.childNode(withName: "rightGoal") as! SKSpriteNode
        scoreLeftLbl = self.childNode(withName: "scoreLeft") as! SKLabelNode
        scoreRightLbl = self.childNode(withName: "scoreRight") as! SKLabelNode
        
        ball.physicsBody?.collisionBitMask = 0b0001
        leftGoal.physicsBody?.collisionBitMask = 0b0010

        rightPaddle.physicsBody?.categoryBitMask = 0b0001
        leftPaddle.physicsBody?.categoryBitMask = 0b0001
        leftGoal.physicsBody?.categoryBitMask = 0b0001
        rightGoal.physicsBody?.categoryBitMask = 0b0001
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: 20))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            rightPaddle.run(SKAction.moveTo(y: location.y, duration: 0.05))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            rightPaddle.run(SKAction.moveTo(y: location.y, duration: 0.05))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        leftPaddle.run(SKAction.moveTo(y: ball.position.y, duration: 0.1))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var ball = contact.bodyA
        var object = contact.bodyB
        if(ball.categoryBitMask < object.categoryBitMask){
            ball = contact.bodyB
            object = contact.bodyA
        }
        if(object.collisionBitMask == 0b0010){
            let goal = object.node as? SKSpriteNode
            if goal == self.leftGoal {
                print("Adding to Right Goal")
                scoreRightNum = scoreRightNum + 1
                scoreRightLbl.text = "\(scoreRightNum)"
            } else if goal == self.rightGoal {
                print("Adding to Left Goal")
                scoreLeftNum = scoreLeftNum + 1
                scoreLeftLbl.text = "\(scoreLeftNum)"
            }
        }
        print("Adding Speed")
        ball.node?.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
    }
}
