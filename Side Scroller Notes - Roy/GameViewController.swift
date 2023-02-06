//
//  GameViewController.swift
//  Side Scroller Notes - Roy
//
//  Created by ROY ALAMEH on 1/30/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var play : GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                play = scene as? GameScene
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .landscapeLeft
    }

    @IBAction func jumpAction(_ sender: UIButton) {
        if play.jumpNum < play.maxJumps {
            play.childNode(withName: "guy")?.physicsBody?.velocity = CGVector(dx: play.childNode(withName: "guy")?.physicsBody?.velocity.dx ?? 30, dy: 800)
            play.jumpNum += 1
        }
        if play.childNode(withName: "guy")?.physicsBody?.velocity.dx == 0.0 {
            play.childNode(withName: "guy")?.physicsBody?.velocity.dy = 500
        }
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        play.rightAccelerate = true
    }
    
    @IBAction func leftAction(_ sender: UIButton) {
        play.leftAccelerate = true
    }
    
    @IBAction func rightStop(_ sender: UIButton) {
        play.rightAccelerate = false
    }
    
    @IBAction func leftStop(_ sender: UIButton) {
        play.leftAccelerate = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
