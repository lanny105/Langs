//
//  OverlayScene.swift
//  Langs
//
//  Created by Vera Wu on 10/10/15.
//  Copyright © 2015 mg526. All rights reserved.
//


import SpriteKit

class OverlayScene: SKScene {
    
    let starXScale: CGFloat = 0.1
    let starYScale: CGFloat = 0.1
    let starImageNamed = "bdqx"
    let hintImageNamed = "hint"
    
    let starPositions: [CGPoint] = [CGPoint(x: 180, y: 340), CGPoint(x: 300, y: 400), CGPoint(x: 370, y: 395), CGPoint(x: 460, y: 392), CGPoint(x: 620, y: 460), CGPoint(x: 630, y: 370),CGPoint(x: 520, y: 330)]
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.blackColor()
        
        makeHint()
        makeHintFinal()
       
    }
    
    func makeHint() {
        let hintMap = SKSpriteNode(imageNamed:hintImageNamed)
        hintMap.xScale = 0.5
        hintMap.yScale = 0.5
        hintMap.position = CGPoint(x: 880, y: 200)
        
        self.addChild(hintMap)
    }
    
    func makeHintFinal(){
        let hintMap = SKSpriteNode(imageNamed:hintImageNamed)
        hintMap.xScale = 2.8
        hintMap.yScale = 2
        hintMap.position = CGPoint(x: 500, y: 380)
        
        self.addChild(hintMap)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            print(location)
            
                        
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

