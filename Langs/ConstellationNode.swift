//
//  ConstellationNode.swift
//  Langs
//
//  Created by Chuan Ren on 10/4/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation
import SceneKit

class ConstellationNode: SCNNode {

    var data: Constellation?
    var stars: NSArray!
    var lines: NSArray!
    
    // MARK: - constructors
    override init () {
        super.init()
    }
    
    init(geometry: SCNGeometry?) {
        super.init()
        
        self.geometry = geometry
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(lineArray: NSArray) {
        super.init()
        
//        self.stars = starArray
        self.lines = lineArray
        
    }

}
