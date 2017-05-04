//
//  GameScene.swift
//  Car park game
//
//  Created by Jasper on 2017-02-28.
//  Copyright © 2017 Jasper. All rights reserved.
//

import SpriteKit
import GameplayKit

struct physicsCatagory {
    static let none     :   UInt32 = 0b0000
    static  let cars    :   UInt32 = 0b0001  // 1
    static let spot     :   UInt32 = 0b0010  // 2
    static let edge     :   UInt32 = 0b0100  // 4
}

class GameScene: SKScene {
    var acceloration: CGFloat = 0.0
    var fast: CGFloat = 0.0
    var xMovement: CGFloat = 0.0
    var yMovement: CGFloat = 0.0
    let midPoint = CGPoint()
    var car = SKSpriteNode()
    var tarmacs = SKSpriteNode()
    var spot = SKSpriteNode()
    var goal = SKSpriteNode()
    var rotation: CGFloat = CGFloat(M_PI)/2//CGFloat(0)
    var currentRotate = CGFloat(M_PI)/2
    var neededRoate = CGFloat(0.000)
    var drive: Bool = true
       var forward = true
    
    
    override func didMove(to view : SKView){
        spot = SKSpriteNode(imageNamed: "rect")
        spot.name = "rect"
        spot.setScale(0.15)
        spot.position = CGPoint(x: 1850, y: 768)
        spot.zPosition = 1
        spot.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        spot.physicsBody!.categoryBitMask = physicsCatagory.spot
        spot.physicsBody!.contactTestBitMask = physicsCatagory.edge | physicsCatagory.cars
        spot.physicsBody?.isDynamic = false
        
        goal = SKSpriteNode(imageNamed: "rect")
        goal.name = "goal"
        goal.setScale(0.01)
        goal.position = CGPoint(x: 1850, y: 768)
        goal.zPosition = 0

        self.addChild(spot)
        self.addChild(goal)
        
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        addObjects()
    }
    
    func addObjects() {
        
        
        
        
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "Car"
        car.position = CGPoint(x: 200, y: 100)
        car.setScale(0.3)
        car.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        car.physicsBody!.categoryBitMask = physicsCatagory.cars
        car.physicsBody!.contactTestBitMask = physicsCatagory.edge | physicsCatagory.spot
        car.physicsBody?.isDynamic = false
        let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration: 0.2)
        self.addChild(car)
        car.run(action)
        
        spot.physicsBody!.contactTestBitMask = UInt32(physicsCatagory.cars)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    
        
        //fast = xMovement + yMovement
        if fast > 3 || fast < -3 {
            acceloration = 1
        }
        
        while fast > 5 || fast < -5 {
            yMovement = yMovement * 0.98
            xMovement = xMovement * 0.98
        }
        
 
        yMovement = yMovement * acceloration
        xMovement = xMovement * acceloration
      
        neededRoate = currentRotate - rotation * -1
        currentRotate = rotation * -1
        let action = SKAction.rotate(byAngle: neededRoate, duration: 0.2)
        let move = SKAction.moveBy(x: xMovement,y:yMovement,duration:0.001)
        
        car.run(action)
        car.run(move)
        //  print(fast)
        
        for node in self.children{
            if let nodename = node.name{
                if nodename == "goal"{
                    if node.intersects(car){
                        print("touch")
                    }
            }
        }
        
    }
    }
    
//    func didBegin(_ contact: SKPhysicsContact) {
//        
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//        print(collision)
//        if collision == physicsCatagory.spot | physicsCatagory.cars{
//            print("Collisin between \(collision)")
//            
//            
//        }
//    }
    
    
    override func keyDown(with event: NSEvent) {
        
        //left =123
        //right=124
        //down=125
        //up=126
     
        fast = xMovement + yMovement
        if event.keyCode == 126 {
            // if drive {
//            xMovement = cos(rotation)*2
//            yMovement = sin(rotation)*2
            if forward{
                acceloration = 1.2
                forward = true
            }else if fast < 0.2 && fast > -0.2{
                xMovement = cos(rotation)*2
                yMovement = sin(rotation)*2
                forward = true
                acceloration = 1.2
            }else{
                acceloration = 0.85
            }
         
            //  }
        }
        
        if event.keyCode == 125{
            //if !drive {
            if !forward{
                acceloration = 1.2
                forward = false
            }else if fast < 0.2 && fast > -0.2{
                xMovement = abs(cos(rotation)) * -2
                yMovement = abs(sin(rotation)) * -2
                forward = false
                acceloration = 1.2
            }else{
                acceloration = 0.85
            }

            //}
        }
        
        if event.keyCode == 124{
            rotation -= 0.0872665
            let currentX = xMovement
            let currentY = yMovement
            if forward {
                xMovement = cos(rotation) * 2 + currentX
                yMovement = sin(rotation) * 2 + currentY
            }else {
                xMovement = cos(rotation) * -2 + currentX
                yMovement = sin(rotation) * -2 + currentY
            }
        }
        
        if event.keyCode == 123{
            rotation += 0.0872665
            let currentX = xMovement
            let currentY = yMovement
            if  forward{
                xMovement = cos(rotation) * 2 + currentX
                yMovement = sin(rotation) * 2 + currentY
            }else{
                xMovement = cos(rotation) * -2 + currentX
                yMovement = sin(rotation) * -2 + currentY
            }
            }

        if event.keyCode == 49 {
            
    acceloration = 0.5
        }
        
        }
    
        
    }

