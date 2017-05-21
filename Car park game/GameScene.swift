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
    var wall1 = SKSpriteNode()
    var wall2 = SKSpriteNode()
    var wall3 = SKSpriteNode()
    var goal = SKSpriteNode()
    var flag = SKSpriteNode()
    var rotation: CGFloat = CGFloat(Double.pi)/2
    var currentRotate = CGFloat(Double.pi)/2
    var neededRoate = CGFloat(0.000)
    var drive: Bool = true
       var forward = true
    var finish = false
    
    
    override func didMove(to view : SKView){
        
        wall1 = SKSpriteNode(imageNamed: "red rect")
        wall1.name = "wall"
        wall1.xScale = 1.75
        wall1.yScale = 0.3
        wall1.position = CGPoint(x: 0, y: 1200)
        wall1.zPosition = 1
        
        wall2 = SKSpriteNode(imageNamed: "red rect")
        wall2.name = "wall"
        wall2.xScale = 1.5
        wall2.yScale = 0.3
        wall2.position = CGPoint(x: 1850, y: 800)
        wall2.zPosition = 1
        
        wall3 = SKSpriteNode(imageNamed: "red rect")
        wall3.name = "wall"
        wall3.xScale = 1.75
        wall3.yScale = 0.3
        wall3.position = CGPoint(x: 0, y: 400)
        wall3.zPosition = 1
        
        spot = SKSpriteNode(imageNamed: "rect")
        spot.name = "rect"
        spot.setScale(0.15)
        spot.position = CGPoint(x: 200, y: 1400)
        spot.zPosition = 1
   
        
        goal = SKSpriteNode(imageNamed: "rect")
        goal.name = "goal"
        goal.setScale(0.01)
        goal.position = CGPoint(x: 200, y: 1400)
        goal.zPosition = 0
        
        flag = SKSpriteNode(imageNamed: "flags")
        flag.setScale(3)
        flag.position = CGPoint(x: -111100, y: 100)
        flag.zPosition = 2

        self.addChild(spot)
        self.addChild(wall1)
        self.addChild(wall2)
        self.addChild(wall3)
        self.addChild(goal)
        self.addChild(flag)
        
        
        addObjects()
    }
    
    func addObjects() {
        
        
        
        
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "Car"
        car.position = CGPoint(x: 200, y: 100)
        car.setScale(0.3)
 
        let action = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.2)
        self.addChild(car)
        car.run(action)
        

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    
        
        fast = xMovement + yMovement
        if fast > 6 && acceloration > 1 || fast < -6 && acceloration > 1{
            acceloration = 0.9
}//else{
//            acceloration = 1
//        }
        
//        while fast > 5 || fast < -5 {
//            yMovement = yMovement * 0.98
//            xMovement = xMovement * 0.98
//        }
        
 
        yMovement = yMovement * acceloration
        xMovement = xMovement * acceloration
      
        neededRoate = currentRotate - rotation * -1
        currentRotate = rotation * -1
        
        let action = SKAction.rotate(byAngle: neededRoate, duration: 0.2)
        let move = SKAction.moveBy(x: xMovement,y:yMovement,duration:0.001)
        if finish == false{
        car.run(action)
        car.run(move)
        }
        
        print(acceloration)
        
        for node in self.children{
            if let nodename = node.name{
                if nodename == "goal"{
                    if node.intersects(car) && fast < 0.2{
                     flag.position = CGPoint(x: 925, y: 750)
                        finish = true
                    }
                }
                
                if nodename == "wall"{
                    if node.intersects(car){
                       car.position = CGPoint(x: 200, y: 100)
                        rotation = CGFloat(Double.pi)/2
                        xMovement = 0.0
                        yMovement = 0.0
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
                acceloration = 1.4
                xMovement = cos(rotation)
                yMovement = sin(rotation)
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
            if !forward{
                acceloration = 1.2
                forward = false
            }else if fast < 0.2 && fast > -0.2{
                xMovement = cos(rotation) * -2
                yMovement = sin(rotation) * -2
                forward = false
                acceloration = 1.2
            }else{
                acceloration = 0.8
            }

            //}
        }
        
        if event.keyCode == 124{
            rotation -= 0.0872665
            let currentX = xMovement
            let currentY = yMovement
            if forward {
                xMovement = cos(rotation) * 2  + currentX
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

