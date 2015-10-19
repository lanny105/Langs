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

//    let starImageNamed = "bdqx"
//    let hintImageNamed = "bdqx2"
//    let finalImageNamed = "finish"

    
    var eraseNode: SKSpriteNode!
    var settingNode: SKSpriteNode!
    var hintNode: SKSpriteNode!
    var nextNode: SKSpriteNode!
    
    var hintMap: SKSpriteNode!
    var finalNode: SKSpriteNode!
    var timerNode: SKLabelNode!
        
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.clearColor()
        
        //let aspectRatio = (self.view?.bounds.size.height)! / (self.view?.bounds.size.width)!
        //size.width = (self.view?.bounds.size.width)!
        
        // add the clear button
        let spriteSize = size.width/32
        self.eraseNode = SKSpriteNode(imageNamed: "Erase Button")
        self.eraseNode.size = CGSize(width: spriteSize, height: spriteSize)
        self.eraseNode.position = CGPoint(x: spriteSize + 4, y: spriteSize + 4)
        
        self.addChild(self.eraseNode)
        
        
        // add the setting button
        let spriteSize1 = size.width/32
        self.settingNode = SKSpriteNode(imageNamed: "Setting Button")
        self.settingNode.size = CGSize(width: spriteSize1, height: spriteSize1)
        self.settingNode.position = CGPoint(x: spriteSize + 4, y: size.height*12.1/13)
        
        self.addChild(self.settingNode)
        
        
        // add the hint button
        let spriteSize2 = size.width/32
        self.hintNode = SKSpriteNode(imageNamed: "Hint Button")
        self.hintNode.size = CGSize(width: spriteSize2, height: spriteSize2)
        self.hintNode.position = CGPoint(x: settingNode.position.x + size.width/20, y: size.height*12.1/13)
        
        self.addChild(self.hintNode)
        
        self.finalNode = SKSpriteNode()
        self.nextNode = SKSpriteNode()
        
        self.timerNode = SKLabelNode(text: "")
        self.timerNode.name = "time"
        self.timerNode.fontName = "Menlo"
        self.timerNode.fontColor = UIColor.whiteColor()
        self.timerNode.fontSize = 24
        self.timerNode.position = CGPoint(x: size.width/2, y: spriteSize )
        //self.addChild(self.timerNode)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        print(children.count)
        
        //for touch in touches {
        let location = touch!.locationInNode(self)
        if hintNode.containsPoint(location) {
            self.makeHintNotifi()
        }
        
        if nextNode.containsPoint(location) {
            self.changeScene()
        }
        
        if eraseNode.containsPoint(location) {
            self.eraseAllNotifi()
        }
        
    }
    
    func makeHint(hintImageNamed: String) {
        removeAllChildren()
        hintMap = SKSpriteNode(imageNamed: hintImageNamed)
        hintMap.xScale = 0.4
        hintMap.yScale = 0.5
        hintMap.position = CGPoint(x: size.width * 0.85, y: size.height * 0.15)
        addChild(hintMap)
    }
    
    func hindHint() {
        //hintMap.hidden = true
        //hintMap.removeFromParent()
        removeAllChildren()
    }

    func maketimer(){
        
        //self.addChild(self.pauseNode)
        self.addChild(self.timerNode)
    }
    
    func makeHintFinal(finalImageNamed: String){
        finalNode = SKSpriteNode(imageNamed:finalImageNamed)
        finalNode.xScale = 0.8
        finalNode.yScale = 0.6
        finalNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        finalNode.position = CGPoint(x: size.width/2, y: size.height/2)
        
        // add the next button
        let spriteSize4 = size.width/24
        nextNode = SKSpriteNode(imageNamed: "Next Button")
        nextNode.size = CGSize(width: spriteSize4, height: spriteSize4)
        nextNode.position = CGPoint(x: size.width*12/13, y: size.height/2)
        
        addChild(nextNode)
        addChild(finalNode)
        
    }
    
    
    func changeScene() {
        print("55555")
        NSNotificationCenter.defaultCenter().postNotificationName("changeSceneNotification", object: nil)
        
        print("33333")
    }
    
    
    func makeHintNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("makeHintNotification", object: nil)
    }
    
    
    func eraseAllNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("eraseAllNotification", object: nil)
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

