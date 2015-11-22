//
//  Map.swift
//  Langs
//
//  Created by apple on 11/18/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation


import SpriteKit

class Map : SKShapeNode
{
    private var width: CGFloat!
    private var height: CGFloat!
//    private var startAngle: CGFloat!
    
    
    
    private var location: SKShapeNode!
    
    
    init(width: CGFloat, color: SKColor, height: CGFloat) {
        super.init()
        
        self.width = width
        self.height = height
        
        let rect = CGRect(origin: CGPoint(x: 0.5, y: 0.5), size: CGSize(width: width, height: height))
        
        self.path = CGPathCreateWithRoundedRect(rect, 2.0, 2.0, nil)

        self.location = SKShapeNode(circleOfRadius: 5 ) // Size of Circle
        location.position = CGPointMake(width/2, height/2)  //Middle of Screen
        location.strokeColor = SKColor.blackColor()
        location.glowWidth = 1.0
        location.fillColor = SKColor.orangeColor()
        self.addChild(location)

        
//        self.strokeColor = color
//        self.lineWidth = width
        //self.startAngle = startAngle
        
        //self.updateProgress(1.0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updatelocation(x: CGFloat, y: CGFloat) {
        
        
        //print(width)
        
        //print(x,"---",y)

        var re_x: CGFloat!
        
        if(x<CGFloat(M_PI)) {
            re_x = -width*x/CGFloat(2*M_PI)+width/2
        }
        
        else{
            re_x = width*(CGFloat(2*M_PI)-x)/CGFloat(2*M_PI)+width/2
        }
        
        
        var re_y: CGFloat!
        
//        re_y = log(tan(y)+1/cos(y))
        
        re_y = y*CGFloat(height)/CGFloat(M_PI) + height/2
        
        //print(re_y)
        
        location.position = CGPointMake(re_x, re_y)
        //print(x,"--",y)
        
        
//        let progress = percentageCompleted <= 0.0 ? 1.0 : (percentageCompleted >= 1.0 ? 0.0 : 1.0 - percentageCompleted)
//        let endAngle = self.startAngle + progress * CGFloat(2.0 * M_PI)
//        
//        self.path = UIBezierPath(arcCenter: CGPointZero, radius: self.radius, startAngle: self.startAngle, endAngle: endAngle, clockwise: true).CGPath
    }
}