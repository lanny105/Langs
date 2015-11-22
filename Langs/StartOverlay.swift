//
//  StartOverlay.swift
//  Langs
//
//  Created by Can on 11/21/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import SpriteKit

class StartOverlay: SKScene {
    
//    let titleLabelNode: SKLabelNode
    
    override func didMoveToView(view: SKView) {
        
//        self.backgroundColor = UIColor.clearColor()
        
        
        
        // add title
        let titleLabelNode = SKLabelNode(text: "Startrix")
        titleLabelNode.name = "Startrix"
        titleLabelNode.fontName = "AppleSDGothicNeo-Medium"
        titleLabelNode.fontColor = UIColor.whiteColor()
        titleLabelNode.fontSize = 280
        titleLabelNode.position = CGPoint(x: size.width/2, y: size.height/2+100)
        self.addChild(titleLabelNode)
        
        
        // add copyright
        let crLabelNode = SKLabelNode(text: "Copyright © Langs 2015")
        crLabelNode.fontName = "AppleSDGothicNeo-Medium"
        crLabelNode.fontColor = UIColor.whiteColor()
        crLabelNode.fontSize = 20
        crLabelNode.position = CGPoint(x: size.width/2, y: size.height/2-350)
        self.addChild(crLabelNode)
        
    }
}
