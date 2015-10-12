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
    let hintImageNamed = "bdqx2"
    let finalImageNamed = "finish"
    
    var pauseNode: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.clearColor()
        
        // add the pause button
        let spriteSize = size.width/24
        self.pauseNode = SKSpriteNode(imageNamed: "Pause Button")
        self.pauseNode.size = CGSize(width: spriteSize, height: spriteSize)
        self.pauseNode.position = CGPoint(x: spriteSize + 4, y: spriteSize + 4)
        
        self.addChild(self.pauseNode)
        
        // add the hint image
        makeHint()
    }
    
    func makeHint() {
        let hintMap = SKSpriteNode(imageNamed: hintImageNamed)
        hintMap.xScale = 0.25
        hintMap.yScale = 0.3
        hintMap.position = CGPoint(x: scene!.size.width * 0.85, y: scene!.size.height * 0.15)
        self.addChild(hintMap)
    }
    
    func makeHintFinal(){
        let hintFinalSize = size.width/2
        let hintMap = SKSpriteNode(imageNamed:finalImageNamed)
        hintMap.xScale = 1.2
        hintMap.yScale = 1
        hintMap.position = CGPoint(x: 350, y: 200)
        
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

