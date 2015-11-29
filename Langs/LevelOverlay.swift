//
//  LevelOverlay.swift
//  Langs
//
//  Created by Can on 11/21/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import SpriteKit

class LevelOverlay: SKScene {
    
    let backButtonNode = SKSpriteNode(imageNamed: "go_back")

    override func didMoveToView(view: SKView) {
        // add back button
        let iconSize = size.width/24
        self.backButtonNode.size = CGSize(width: iconSize, height: iconSize)
        self.backButtonNode.position = CGPoint(x: iconSize+6, y: size.height*12.1/13)
        
        self.addChild(self.backButtonNode)
        
        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setFloat(2001, forKey: "userScore")
        
        if let score = defaults.stringForKey("userScore") {
            print(score)
            // add score label
            let scoreLabelNode = SKLabelNode(text: "Score: \(score)")
            scoreLabelNode.fontName = "Chalkduster"
            scoreLabelNode.fontColor = UIColor.whiteColor()
            scoreLabelNode.fontSize = size.width/30
            scoreLabelNode.position = CGPoint(x: size.width/2, y: size.height*11.7/13)
            
            self.addChild(scoreLabelNode)
        }
        
        
//        print("SkNode count: \(self.children.count)")
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first as UITouch?
        
        let location = touch!.locationInNode(self)
        if self.backButtonNode.containsPoint(location) {
            NSNotificationCenter.defaultCenter().postNotificationName("backNotification", object: nil)
        }
        else {
            NSNotificationCenter.defaultCenter().postNotificationName("keepTouchNotification", object: nil)
        }
        
    }
}