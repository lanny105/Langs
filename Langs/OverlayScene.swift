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
    var settingNode: SKSpriteNode!
    var hintNode: SKSpriteNode!
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.clearColor()
        
        // add the clear button
        let spriteSize = size.width/28
        self.pauseNode = SKSpriteNode(imageNamed: "Erase Button")
        self.pauseNode.size = CGSize(width: spriteSize, height: spriteSize)
        self.pauseNode.position = CGPoint(x: spriteSize + 4, y: spriteSize + 4)
        
        self.addChild(self.pauseNode)
        
        
        // add the setting button
        let spriteSize1 = size.width/30
        self.settingNode = SKSpriteNode(imageNamed: "Setting Button")
        self.settingNode.size = CGSize(width: spriteSize1, height: spriteSize1)
        self.settingNode.position = CGPoint(x: spriteSize1 + 4, y: spriteSize1 + 360)
        
        self.addChild(self.settingNode)
        
        
        // add the hint button
        let spriteSize2 = size.width/32
        self.hintNode = SKSpriteNode(imageNamed: "Hint Button")
        self.hintNode.size = CGSize(width: spriteSize2, height: spriteSize2)
        self.hintNode.position = CGPoint(x: spriteSize2 + 40, y: spriteSize2 + 360)
        
        self.addChild(self.hintNode)
        
        // add the hint image
        //makeHint()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
        
            if hintNode.containsPoint(location) {
                print("1")
                self.makeHint()
            }
        }
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
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

