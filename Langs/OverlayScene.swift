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
    
    var eraseNode: SKSpriteNode!
    var settingNode: SKSpriteNode!
    var hintNode: SKSpriteNode!
    var nextNode: SKSpriteNode!
    
    var hintMap: SKSpriteNode!
    var finalNode: SKSpriteNode!
    var timerNode: SKLabelNode!
    var quitNode: SKLabelNode!
    
    var progressbar: CircularProgressNode!
    var barra: Map!
    
    var isShow: Bool = false
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.clearColor()
        //self.userInteractionEnabled = false;
        
        // add the clear button
        let spriteSize = size.width/30
        self.eraseNode = SKSpriteNode(imageNamed: "Erase Button")
        self.eraseNode.size = CGSize(width: spriteSize, height: spriteSize)
        self.eraseNode.position = CGPoint(x: spriteSize + 4, y: spriteSize + 4)
        //self.eraseNode.userInteractionEnabled = true;
        self.eraseNode.zPosition = 200.0
        self.addChild(self.eraseNode)
        
        
        // add the setting button
        let spriteSize1 = size.width/30
        self.settingNode = SKSpriteNode(imageNamed: "Setting Button")
        self.settingNode.size = CGSize(width: spriteSize1, height: spriteSize1)
        self.settingNode.position = CGPoint(x: spriteSize + 4, y: size.height*12.1/13)
        
        self.addChild(self.settingNode)
        
        
        // add the hint button
        let spriteSize2 = size.width/30
        self.hintNode = SKSpriteNode(imageNamed: "Hint Button")
        self.hintNode.size = CGSize(width: spriteSize2, height: spriteSize2)
        self.hintNode.position = CGPoint(x: settingNode.position.x + size.width/20, y: size.height*12.1/13)
        //self.hintNode.userInteractionEnabled = true;
        self.addChild(self.hintNode)
        
        self.finalNode = SKSpriteNode()
        self.nextNode = SKSpriteNode()
        
        self.timerNode = SKLabelNode(text: "")
        self.timerNode.name = "time"
        self.timerNode.fontName = "AppleSDGothicNeo-Medium"
        self.timerNode.fontColor = UIColor.whiteColor()
        self.timerNode.fontSize = 24
        self.timerNode.position = CGPoint(x: size.width/2, y: size.height*12.1/13)
        
        
        // add setting menu
        self.quitNode = SKLabelNode(text: "Quit Level")
        self.quitNode.name = "quit"
        self.quitNode.fontName = "AppleSDGothicNeo-Medium"
        self.quitNode.fontColor = UIColor.whiteColor()
        self.quitNode.fontSize = 28
        self.quitNode.position = CGPoint(x: size.width/2, y: size.height/2+10)
        
        
        // add progressbar and map
        self.progressbar = CircularProgressNode(radius: 20, color: SKColor.redColor(), width: 5, startAngle: 0.0)
        self.progressbar.position = CGPoint(x: size.width*12/13, y: size.height*12/13 )
        //self.progressbar.zPosition = 0.0
        self.addChild(self.progressbar)
        
        self.barra = Map(width: size.width*0.12, color: SKColor.whiteColor(), height: size.width*0.12)
        self.barra.position = CGPoint(x: size.width * 0.85, y: size.height * 0.48)        
        self.addChild(barra)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        let location = touch!.locationInNode(self)
        if hintNode.containsPoint(location) {
            self.makeHintNotifi()
        }
        else if nextNode.containsPoint(location) {
            self.changeScene()
        }
        
        else if eraseNode.containsPoint(location) {
            self.eraseAllNotifi()
        }
        
        else if settingNode.containsPoint(location) {
            self.showSettings()
        }
        else if (isShow && quitNode.containsPoint(location)) {
            self.changeScene()
        }
        else {
            NSNotificationCenter.defaultCenter().postNotificationName("updateTouchNotification", object: nil)
        }
        
    }
    
    func makeHint(hintImageNamed: String, showHint: Int) {
        if (showHint == 1) {
            hintMap = SKSpriteNode(imageNamed: hintImageNamed)
            hintMap.xScale = 0.4
            hintMap.yScale = 0.5
            hintMap.position = CGPoint(x: size.width * 0.85, y: size.height * 0.15)
            addChild(hintMap)
        }
        else {
            removeAllChildren()
            hintMap = SKSpriteNode(imageNamed: hintImageNamed)
            hintMap.xScale = 0.4
            hintMap.yScale = 0.5
            hintMap.position = CGPoint(x: size.width * 0.85, y: size.height * 0.15)
            addChild(hintMap)
        }
    }
    
    
    func hindHint() {
        removeAllChildren()
    }
    

    func maketimer(){
        self.addChild(self.timerNode)
    }
    
    
    func updateProgressbar(percentageCompleted: Double) {
        self.progressbar.updateProgress(CGFloat(percentageCompleted))
    }
    
    func updateMaplocation(x: Double, y: Double) {
        
        self.barra.updatelocation(CGFloat(x), y: CGFloat(y))
        
        
        //        let progress = percentageCompleted <= 0.0 ? 1.0 : (percentageCompleted >= 1.0 ? 0.0 : 1.0 - percentageCompleted)
        //        let endAngle = self.startAngle + progress * CGFloat(2.0 * M_PI)
        //
        //        self.path = UIBezierPath(arcCenter: CGPointZero, radius: self.radius, startAngle: self.startAngle, endAngle: endAngle, clockwise: true).CGPath
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
        NSNotificationCenter.defaultCenter().postNotificationName("changeSceneNotification", object: nil)
    }
    
    
    func makeHintNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("makeHintNotification", object: nil)
    }
    
    
    func eraseAllNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("eraseAllNotification", object: nil)
    }
    
    
    func showSettings() {
        if (!isShow) {
            addChild(quitNode)
        }
        else {
            quitNode.removeFromParent()
        }
        isShow = !isShow
        //NSNotificationCenter.defaultCenter().postNotificationName("pause3DNotification", object: nil)
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

