//
//  StarNode.swift
//  Langs
//
//  Created by Chuan Ren on 10/3/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation
import SceneKit

class StarNode: SCNNode {

    var data : Star? // star info from database

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

    init (star: Star) {
        super.init()

        self.data = star
    }

    // MARK: - Member functions
    
}
