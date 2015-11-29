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
        titleLabelNode.fontName = "Chalkduster"
        titleLabelNode.fontColor = UIColor.whiteColor()
        titleLabelNode.fontSize = size.height/3.7
        titleLabelNode.position = CGPoint(x: size.width/2, y: size.height/2+size.height/7)
        self.addChild(titleLabelNode)
        
        
        // add copyright
        let crLabelNode = SKLabelNode(text: "Copyright © Langs 2015")
        crLabelNode.fontName = "Chalkduster"
        crLabelNode.fontColor = UIColor.whiteColor()
        crLabelNode.fontSize = size.width/40
        crLabelNode.position = CGPoint(x: size.width/2, y: size.height/30)
        self.addChild(crLabelNode)
        
    }
}
