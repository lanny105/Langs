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
    //let hintImageNamed = "hint"
    let hintImageNamed = "bdqx2"
    let finalImageNamed = "finish"
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor.blackColor()
        
        makeHint()
//        if(indicatefinal == 0){
//            makeHint()
//        }else{
//            makeHintFinal()
//        }
    }
    
    func makeHint() {
        let hintMap = SKSpriteNode(imageNamed:hintImageNamed)
        hintMap.xScale = 0.3
        hintMap.yScale = 0.3
        hintMap.position = CGPoint(x: 500, y: 60)
        
        self.addChild(hintMap)
    }
    
    func makeHintFinal(){
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

