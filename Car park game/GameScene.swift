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
        car.setScale(0.6)
        self.addChild(car)
    }
    
    override func keyDown(with event: NSEvent) {
        //left =123
        //right=124
        //down=125
        //up=126
        if event.keyCode == 126 {
            let move = SKAction.moveBy(x: 0,y: 40,duration:0.2)
            car.run(move)
        }
        
        if event.keyCode == 125 {
            let move = SKAction.moveBy(x: 0,y: -40,duration:0.2)
            car.run(move)
            
        }
        
    }
    
}
