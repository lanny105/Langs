//
//  Progressbar.swift
//  Langs
//
//  Created by apple on 11/18/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation

import SpriteKit

class CircularProgressNode : SKShapeNode
{
    private var radius: CGFloat!
    private var startAngle: CGFloat!
    
    
    private var width: CGFloat!
    private var height: CGFloat!
    private var start: CGFloat!
    
    init(color: SKColor, width: CGFloat, height: CGFloat, start: Int ) {
        super.init()
        self.fillColor = color
        self.start = 0
        self.width = width
        self.height = height
        
        
    }
    
    
//    func updateProgress(percentageCompleted: CGFloat) {
////        let progress = percentageCompleted <= 0.0 ? 1.0 : (percentageCompleted >= 1.0 ? 0.0 : 1.0 - percentageCompleted)
////        let endAngle = self.startAngle + progress * CGFloat(2.0 * M_PI)
//        
//        self.path = UIBezierPath(arcCenter: CGPointZero, radius: self.radius, startAngle: self.startAngle, endAngle: endAngle, clockwise: true).CGPath
//        
//        self.path = UIBezierPath(
//    }
    
    
    
    init(radius: CGFloat, color: SKColor, width: CGFloat, startAngle: CGFloat = CGFloat(M_PI_2)) {
        super.init()
        
        self.radius = radius
        self.strokeColor = color
<<<<<<< HEAD

        
=======
        self.fillColor = SKColor.blueColor()
>>>>>>> origin/master
        self.lineWidth = width
        self.startAngle = startAngle
        
        self.updateProgress(1.0)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgress(percentageCompleted: CGFloat) {
        let progress = percentageCompleted <= 0.0 ? 1.0 : (percentageCompleted >= 1.0 ? 0.0 : 1.0 - percentageCompleted)
        let endAngle = self.startAngle + progress * CGFloat(2.0 * M_PI)
        
        self.path = UIBezierPath(arcCenter: CGPointZero, radius: self.radius, startAngle: self.startAngle, endAngle: endAngle, clockwise: true).CGPath
    }
}