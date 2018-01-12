//
//  File.swift
//  Magnet Juggle
//
//  Created by jevon shaw on 1/10/18.
//  Copyright © 2018 Ellis Ent. All rights reserved.
//

import Foundation
import SpriteKit

class OtherOrb: SKSpriteNode {
        
    //initialize other magnets
    init() {
        
        let texture = SKTexture(imageNamed: "Orb")
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.physicsBody?.categoryBitMask = otherMagCategory
        self.physicsBody?.collisionBitMask = myMagCategory | frameCategory
        self.position = CGPoint(x: 0.0, y: 500.0)
        self.physicsBody = SKPhysicsBody(circleOfRadius: 20) // 80 is the size of the orb
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.mass = 1.0
        self.anchorPoint = CGPoint(x: 0.54, y: 0.557)
        self.physicsBody?.restitution = 1.5
        self.physicsBody?.linearDamping = 0.2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

