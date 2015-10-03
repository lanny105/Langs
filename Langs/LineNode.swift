//
//  LineNode.swift
//  Langs
//
//  Created by Chuan Ren on 10/3/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation
import SceneKit

class LineNode: SCNNode {

    var starA : StarNode!
    var starB : StarNode!

    // MARK: - Constructors

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

    init (starFrom: StarNode, starTo: StarNode) {
        super.init()

        self.starA = starFrom
        self.starB = starTo
    }

    // MARK: - Member functions
    
}
