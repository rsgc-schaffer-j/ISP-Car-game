//
//  GameScene.swift
//  Car park game
//
//  Created by Jasper on 2017-02-28.
//  Copyright © 2017 Jasper. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var acceloration: CGFloat = 0.0
    var fast: CGFloat = 0.0
    var xMovement: CGFloat = 0.0
     var yMovement: CGFloat = 0.0
    let midPoint = CGPoint()
    var car = SKSpriteNode()
    var rotation: CGFloat = CGFloat(M_PI)/2
    
    override func didMove(to view : SKView){
        
        backgroundColor = SKColor.white
        
        addObjects()
    }
    
    func addObjects() {
        
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "Car"
        car.position = CGPoint(x: 200, y: 250)
        car.setScale(0.3)
        self.addChild(car)
    }
    
    override func update(_ currentTime: TimeInterval) {
        fast = xMovement + yMovement
        if fast > 10 || fast < -10 {
            acceloration = 1
        }
        
        if acceloration == 2 || acceloration == 0.5{
            yMovement = yMovement * acceloration
            xMovement = xMovement * acceloration
        }else if fast < -0.3 || fast > 0.3{
           // yMovement = yMovement * 0.9
          //  xMovement = xMovement * 0.9
        }else{
            xMovement = 0
            yMovement = 0
        }
        
        let move = SKAction.moveBy(x: xMovement,y:yMovement,duration:0.001)
        
        car.run(move)
        print(fast)
    }
    
    override func keyDown(with event: NSEvent) {
        
        //left =123
        //right=124
        //down=125
        //up=126
        
        xMovement = cos(rotation)
        yMovement = sin(rotation)
        
        fast = xMovement + yMovement
        if event.keyCode == 126 {
            if fast>0.3 && fast<60 {
                acceloration = 2
            }else if fast < 0.3 && fast > -0.3 && fast != 0{
                fast=0
            }else if fast < -0.4 {
                acceloration = 0.5
            }else{
                acceloration = 2
            }
        }
        
        if event.keyCode == 125{
            if fast>0.3 && fast<60 {
                acceloration = 0.5
            }else if fast < 0.3 && fast > -0.3 && fast != 0{
                fast=0
            }else if fast < -0.3 && fast > -60 {
                acceloration = 2
            }else{
                xMovement = xMovement * -1
                yMovement = yMovement * -1
                acceloration = 2
            }
        }
        if event.keyCode == 124{
                 rotation -= 0.0872665
        }
        
        if event.keyCode == 123{
            rotation += 0.0872665
        }
        
        
    }
    
}
