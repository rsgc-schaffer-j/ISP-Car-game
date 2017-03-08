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
    let midPoint = CGPoint()
    var car = SKSpriteNode()
    
    
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
    
    if fast > 10 || fast < -10 {
        acceloration = 1
    }
    
    if acceloration == 2 || acceloration == 0.5{
    fast = fast * acceloration
    }else if fast < -0.4 || fast > 0.6{
        fast = fast * 0.9
    }else{
        fast = 0
    }
    let move = SKAction.moveBy(x: 0,y:fast,duration:0.1)

    car.run(move)
    print(fast)
 }
    
    override func keyDown(with event: NSEvent) {
      
        //left =123
        //right=124
        //down=125
        //up=126
        if event.keyCode == 126 {
        if fast>0.6 && fast<60 {
            acceloration = 2
        }else if fast < 0.6 && fast > -0.4 && fast != 0{
            fast=0
        }else if fast < -0.4 {
            acceloration = 0.5
        }else{
            fast += 1
                acceloration = 2
        }
        }
        
        if event.keyCode == 125{
        if fast>0.6 && fast<60 {
            acceloration = 0.5
        }else if fast < 0.6 && fast > -0.4 && fast != 0{
            fast=0
        }else if fast < -0.4 && fast > -60 {
            acceloration = 2
        }else{
            fast -= 1
            acceloration = 2
        }
    }
    
       
        
    }
    
}
