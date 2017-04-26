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
    var rotation: CGFloat = CGFloat(M_PI)/2//CGFloat(0)
    var currentRotate = CGFloat(M_PI)/2
    var neededRoate = CGFloat(0.000)
    var drive: Bool = true
    
    
    
    override func didMove(to view : SKView){
        
        tarmacs = SKSpriteNode(imageNamed: "tarmac")
        tarmacs.name = "tarmac"
        tarmacs.position = CGPoint(x: 0, y: 0)
        tarmacs.setScale(2)
        tarmacs.zPosition = 0
        self.addChild(tarmacs)
        
        spot = SKSpriteNode(imageNamed: "rect")
        spot.name = "rect"
        spot.setScale(0.15)
        spot.position = CGPoint(x: 1850, y: 768)
        spot.zPosition = 1
        spot.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        self.addChild(spot)
     
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
       
        addObjects()
    }
    
    func addObjects() {
        
        

        
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "Car"
        car.position = CGPoint(x: 200, y: 100)
        car.setScale(0.3)
        car.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        
        car.physicsBody!.categoryBitMask = UInt32(physicsCatagory.cars)
        car.physicsBody!.contactTestBitMask = UInt32(physicsCatagory.edge) | UInt32(physicsCatagory.spot)

        let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration: 0.2)
        self.addChild(car)
         car.run(action)
        
             spot.physicsBody!.contactTestBitMask = UInt32(physicsCatagory.cars)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       
        if fast > 0{
            drive = true
        }else{
            drive = false
        }
        
        fast = xMovement + yMovement
        if fast > 10 || fast < -10 {
            acceloration = 1
        }
        
    //    if acceloration == 2 || acceloration == 0.5{
            yMovement = yMovement * acceloration
            xMovement = xMovement * acceloration
//        }else if fast < -0.3 || fast > 0.3{
//           yMovement = yMovement * 0.9
//        xMovement = xMovement * 0.9
//        }else{
//            xMovement = 0
//            yMovement = 0
//        }
        neededRoate = currentRotate - rotation * -1
        currentRotate = rotation * -1
        let action = SKAction.rotate(byAngle: neededRoate, duration: 0.2)
        let move = SKAction.moveBy(x: xMovement,y:yMovement,duration:0.001)
        
        car.run(action)
        car.run(move)
        print(fast)
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //DEBUG
        print("Collisin between \(collision)")
        
        if collision == physicsCatagory.spot | physicsCatagory.cars{
            
        }
    }

    override func keyDown(with event: NSEvent) {
        
        //left =123
        //right=124
        //down=125
        //up=126
        
        fast = xMovement + yMovement
        if event.keyCode == 126 {
           // if drive {
                xMovement = cos(rotation)*2
                yMovement = sin(rotation)*2
             acceloration = 1
          //  }
                    }
        
        if event.keyCode == 125{
           //if !drive {
                xMovement = abs(cos(rotation)) * -2
                yMovement = abs(sin(rotation)) * -2
                acceloration = 1
            //}
                   }
        
        if event.keyCode == 124{
                 rotation -= 0.523599
            if fast > 0{
                xMovement = cos(rotation)*2
                yMovement = sin(rotation)*2
            }else if fast < 0{
                xMovement = abs(cos(rotation)) * -2
                yMovement = abs(sin(rotation)) * -2
            }
        }
        
        if event.keyCode == 123{
            rotation += 0.523599
            if fast > 0 && rotation < CGFloat(M_PI) || fast < 0 && rotation > CGFloat(M_PI) {
                xMovement = abs(cos(rotation))*2
                yMovement = abs(sin(rotation))*2
            }else if fast < 0 && rotation < CGFloat(M_PI) || fast > 0 && rotation > CGFloat(M_PI){
                xMovement = abs(cos(rotation)) * -2
                yMovement = abs(sin(rotation)) * -2
            }

        }
    //print(event.keyCode)
        
    }
    
    
    
}



//if event.keyCode == 126 {
//    if fast>0.3 && fast<60 {
//        acceloration = 2
//    }else if fast < 0.3 && fast > -0.3 && fast != 0{
//        fast=0
//    }else if fast < -0.4 {
//        acceloration = 0.5
//    }else{
//        acceloration = 2
//    }
//    xMovement = cos(rotation)*2
//    yMovement = sin(rotation)*2
//}
//
//if event.keyCode == 125{
//    if fast>0.3 && fast<60 {
//        acceloration = 0.5
//    }else if fast < 0.3 && fast > -0.3 && fast != 0{
//        fast=0
//    }else if fast < -0.3 && fast > -60 {
//        acceloration = 2
//    }else{
//        xMovement = xMovement * -1
//        yMovement = yMovement * -1
//        acceloration = 2
//    }
//    xMovement = cos(rotation)*2
//    yMovement = sin(rotation)*2
//}

