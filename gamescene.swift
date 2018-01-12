//
//  GameScene.swift
//  Magnet Juggle
//
//  Created by jevon shaw on 1/3/18.
//  Copyright © 2018 Ellis Ent. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

public let myMagCategory:UInt32 = 0x1
public let otherMagCategory:UInt32 = 0x1 << 2
public let frameCategory:UInt32 = 0x1 << 3


class GameScene: SKScene {
    
    let myMagnet = SKSpriteNode(imageNamed: "Orb")
    var orbArr = [OtherOrb]()
    var orbIndex = 0
    
    let timerLabel = SKLabelNode()
    var timer = Timer()
    var counterStart = 15
    var counter = 5
    
    public var highScore = 0
    var score = 0
    let currScore = SKLabelNode()

    override func didMove(to view: SKView) {
        
        //high score
        let highScoreDef = UserDefaults.standard
        if highScoreDef.value(forKey: "highScore") != nil {
            highScore = highScoreDef.value(forKey: "highScore") as! NSInteger
        }
        
        //lower the gravitational field
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.1)
        
        addMyOrb()
        self.setScore()

        let borderBody = SKPhysicsBody(edgeLoopFrom: CGRect(origin: CGPoint(x: -self.frame.width/2, y: -self.frame.height/2 - 30), size: CGSize(width: self.frame.width, height: self.frame.height + 60)))
        self.physicsBody = borderBody
        self.physicsBody?.restitution = 0.2 
        
        //initialize collision properties
        borderBody.categoryBitMask = frameCategory
        myMagnet.physicsBody?.categoryBitMask = myMagCategory
        myMagnet.physicsBody?.collisionBitMask = otherMagCategory
        
        //timer actions
        let waitAction = SKAction.wait(forDuration: 1)
        let fireAction = SKAction.run {
            self.counter -= 1
            self.timerLabel.position = CGPoint(x: 310, y: 610)
            self.timerLabel.fontColor = SKColor.white
            self.timerLabel.fontSize = 65
            self.timerLabel.zPosition = 10
            self.timerLabel.text = "\(self.counter)"
            if self.counter < 1 {
                self.counter = self.counterStart
                self.score = self.score + 100
                self.addMoreOrbs()
            }
            self.checkSpeedsAndGameOver()
        }
        
        //timer execution
        self.addChild(self.timerLabel)
        let actionSequence = SKAction.sequence([waitAction, fireAction])
        let repeatAction = SKAction.repeatForever(actionSequence)
        self.run(repeatAction, withKey: "timer")
    }
    
    func setScore() {
        self.currScore.position = CGPoint(x: 0, y: 610)
        self.currScore.fontColor = SKColor.white
        self.currScore.fontSize = 65
        self.currScore.zPosition = 10
        self.addChild(self.currScore)
    }
    
    func addMyOrb() {
        //initialize player orb
        myMagnet.position = CGPoint(x: 150, y: -500)
        myMagnet.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        myMagnet.physicsBody?.affectedByGravity = false
        myMagnet.physicsBody?.allowsRotation = false
        myMagnet.physicsBody?.isDynamic = false
        myMagnet.anchorPoint = CGPoint(x: 0.54, y: 0.557)
        myMagnet.physicsBody?.restitution = 1.1
        myMagnet.physicsBody?.linearDamping = 0
        self.addChild(myMagnet)
    }
    
    func addMoreOrbs(){
        let obb = OtherOrb()
        orbArr.append(obb)
        self.addChild(orbArr[orbIndex])
        orbIndex += 1

    }
    
    func checkSpeedsAndGameOver(){
        for o in orbArr {
            //enforce orb speed limit
            if abs(Float((o.physicsBody?.velocity.dx)!)) > Float(600) {
                o.physicsBody?.linearDamping = 5
            } /* else {
                o.physicsBody?.linearDamping = 2
            }
            
            //see if it's game over
            if o.position.y < -1 * self.frame.height / 2 {
                //remove all nodes?
                //transition to game over scene
            }*/
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
 
    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            myMagnet.run(SKAction.move(to: location, duration: 0.05))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
