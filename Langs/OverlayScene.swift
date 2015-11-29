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
    var storyNode: SKLabelNode!
    
    var progressbar: CircularProgressNode!
    var barra: Map!
    
    var isShow: Bool = false
    
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.clearColor()
        //self.userInteractionEnabled = false;
        
        // add the clear button
        let spriteSize = size.width/24
        self.eraseNode = SKSpriteNode(imageNamed: "Erase Button")
        self.eraseNode.size = CGSize(width: spriteSize, height: spriteSize)
        self.eraseNode.position = CGPoint(x: spriteSize + 4, y: spriteSize + 4)
        //self.eraseNode.userInteractionEnabled = true;
        self.eraseNode.zPosition = 200.0
        self.addChild(self.eraseNode)
        
        
        // add the setting button
        let spriteSize1 = size.width/24
        self.settingNode = SKSpriteNode(imageNamed: "Setting Button")
        self.settingNode.size = CGSize(width: spriteSize1, height: spriteSize1)
        self.settingNode.position = CGPoint(x: spriteSize + 4, y: size.height*12.1/13)
        
        self.addChild(self.settingNode)
        
        
        // add the hint button
        let spriteSize2 = size.width/24
        self.hintNode = SKSpriteNode(imageNamed: "Hint Button")
        self.hintNode.size = CGSize(width: spriteSize2, height: spriteSize2)
        self.hintNode.position = CGPoint(x: settingNode.position.x + size.width/14, y: size.height*12.1/13)
        //self.hintNode.userInteractionEnabled = true;
        self.addChild(self.hintNode)
        
        self.finalNode = SKSpriteNode()
        self.nextNode = SKSpriteNode()
        
        self.timerNode = SKLabelNode(text: "Time: 05:00")
        self.timerNode.name = "time"
        self.timerNode.fontName = "Chalkduster"
        self.timerNode.fontColor = UIColor(red: 255.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1.0)
        self.timerNode.fontSize = 24
        self.timerNode.position = CGPoint(x: size.width/2, y: size.height*11.7/13)
        self.addChild(self.timerNode)
        
        
        // add setting menu
        self.quitNode = SKLabelNode(text: "Quit Level")
        self.quitNode.name = "quit"
        self.quitNode.fontName = "Chalkduster"
        self.quitNode.fontColor = UIColor.redColor()
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
            self.clickSetNotifi()
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
            //addChild(progressbar)
        }
        else {
            removeAllChildren()
            hintMap = SKSpriteNode(imageNamed: hintImageNamed)
            hintMap.xScale = 0.4
            hintMap.yScale = 0.5
            hintMap.position = CGPoint(x: size.width * 0.85, y: size.height * 0.15)
            addChild(hintMap)
            addChild(progressbar)
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
    
    
    func makeHintFinal(finalImageNamed: String, storyText: String){
        finalNode = SKSpriteNode(imageNamed:finalImageNamed)
        finalNode.xScale = 1.0
        finalNode.yScale = 1.0
        finalNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        finalNode.position = CGPoint(x: size.width*10/13, y: size.height/2)
        
        // add the next button
        let spriteSize4 = size.width/18
        nextNode = SKSpriteNode(imageNamed: "ok")
        nextNode.size = CGSize(width: spriteSize4, height: spriteSize4)
        nextNode.position = CGPoint(x: size.width/2, y: size.height/20+12)

        //var temp: String = (storyText as NSString).substringToIndex(10)
        let storyArray: [String] = storyText.componentsSeparatedByString(" ")
        var storyArrayToString = ""
        var i = 0
        for storyElem in storyArray{
            if i%5 == 0 && i != 0{
                storyArrayToString += storyElem+"\n"
            }else{
                storyArrayToString += storyElem+" "
            }
            i = i+1
        }
        
        let textBlock = SKNode()
        
        //create array to hold each line
        let textArr = storyArrayToString.componentsSeparatedByString("\n")
        
        // loop through each line and place it in an SKNode
        var lineNode: SKLabelNode
        for line: String in textArr {
            lineNode = SKLabelNode()
            lineNode.text = line
            lineNode.fontSize = 15
            lineNode.fontColor = UIColor.orangeColor()
            lineNode.fontName = "Chalkduster"
            lineNode.position = CGPointMake(size.width/4+4,size.height-70 - CGFloat(textBlock.children.count ) * 20)
            textBlock.addChild(lineNode)
        }

        
        /*
        self.storyNode = SKLabelNode()
        self.storyNode.text = storyArrayToString
        self.storyNode.name = "story"
        self.storyNode.fontName = "AppleSDGothicNeo-Medium"
        self.storyNode.fontColor = UIColor.whiteColor()
        self.storyNode.fontSize = 20
        self.storyNode.position = CGPoint(x: size.width/2, y: size.height/2-50)
        */
        self.removeAllChildren()
        addChild(textBlock)
        addChild(nextNode)
        addChild(finalNode)
    }
    
    
    func changeScene() {
        NSNotificationCenter.defaultCenter().postNotificationName("changeSceneNotification", object: nil)
    }
    
    
    func makeHintNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("makeHintNotification", object: nil)
    }
    
    func clickSetNotifi() {
        NSNotificationCenter.defaultCenter().postNotificationName("clickSetNotification", object: nil)
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

