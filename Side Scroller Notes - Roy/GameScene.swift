//
//  GameScene.swift
//  Side Scroller Notes - Roy
//
//  Created by ROY ALAMEH on 1/30/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    private var character : SKSpriteNode!
    private var ground : SKSpriteNode!
    private var score : SKLabelNode!
    let cam = SKCameraNode()
    let speedFactorY = 2.0
    let speedFactorX = 1.05
    var jumpNum = 0
    let maxJumps = 2
    let horizontalAcceleration = 2000.0
    let maxSpeedHorizontal = 425.0
    let wallJump = 500.0
    var rightAccelerate = false
    var leftAccelerate = false
    var originalXCoord : Double!
    var originalYCoord : Double!
    var scoreNum = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        //sets orientation of info-p list
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        character = self.childNode(withName: "guy") as? SKSpriteNode
        originalXCoord = character.position.x
        originalYCoord = character.position.y
        
        score = self.childNode(withName: "score") as? SKLabelNode
        
        self.camera = cam
        ground = self.childNode(withName: "ground") as? SKSpriteNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position = character.position
        score.position.x = character.position.x - 300.0
        score.position.y = character.position.y + 200.0
        
        if rightAccelerate {
            if Double(character.physicsBody?.velocity.dx ?? 1) <= maxSpeedHorizontal {
                character.physicsBody?.applyForce(CGVector(dx: horizontalAcceleration * (character.physicsBody?.mass ?? 1), dy: 0))
            }
            else {
                character.physicsBody?.velocity.dx = maxSpeedHorizontal
            }
        }
        if leftAccelerate {
            if Double(character.physicsBody?.velocity.dx ?? 1) >= -maxSpeedHorizontal {
                character.physicsBody?.applyForce(CGVector(dx: -horizontalAcceleration * (character.physicsBody?.mass ?? 1), dy: 0))
            }
            else {
                character.physicsBody?.velocity.dx = -maxSpeedHorizontal
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*var speed = 0.0
        for touch in touches {
            speed = (touch.location(in: self).x - self.childNode(withName: "guy")!.position.x) as! CGFloat
        }
        var yCurrentVector = self.childNode(withName: "guy")?.physicsBody?.velocity.dy
        self.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: speed, dy: yCurrentVector!)) */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: self.childNode(withName: "guy")?.physicsBody?.velocity.dx ?? 30, dy: 500)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var guy : SKSpriteNode!
        var coin : SKSpriteNode!
        var block : SKSpriteNode!
        var wall : SKSpriteNode!
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            guy = contact.bodyA.node as? SKSpriteNode
            coin = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1 {
            coin = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1 {
            block = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3 {
            guy = contact.bodyA.node as? SKSpriteNode
            block = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 1 {
            jumpNum = 0
        }
        else if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 4 {
            jumpNum = 0
        }
        else if contact.bodyA.categoryBitMask == 5 && contact.bodyB.categoryBitMask == 1 {
            wall = contact.bodyA.node as? SKSpriteNode
            guy = contact.bodyB.node as? SKSpriteNode
        }
        else if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 5 {
            wall = contact.bodyB.node as? SKSpriteNode
            guy = contact.bodyA.node as? SKSpriteNode
        }
        
        if coin != nil {
            coin.removeFromParent()
            scoreNum += 1
            score.text = "Score: \(scoreNum)"
        }
        if wall != nil {
            
        }
        if block != nil {
            print("died")
            print(originalXCoord!)
            print(originalYCoord!)
            let physicsBody = guy.physicsBody
            guy.physicsBody = nil
            guy.position.x = originalXCoord
            guy.position.y = originalYCoord
            guy.physicsBody = physicsBody
            guy.physicsBody?.velocity.dx = 0
            guy.physicsBody?.velocity.dy = 0
        }
    }
    
    
}
