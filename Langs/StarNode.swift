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
    var R: Float = 100
    var px: Float = 0
    var py: Float = 0
    var pz: Float = 0

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
        
        self.categoryBitMask = 1

        px = Float((data?.x)!)
        py = Float((data?.y)!)
        pz = Float((data?.z)!)
        let l = pow(px*px + py*py + pz*pz, 0.5)
        px = px * R/l
        py = py * R/l
        pz = pz * R/l

        self.geometry = SCNSphere(radius: 0.8)
        self.position = SCNVector3(x: px, y: py, z: pz)
    }

    // MARK: - Member functions

    func highlight(b: Bool) {
        let material = self.geometry!.firstMaterial!
        if (b) {
            material.diffuse.contents = UIColor.yellowColor()
        }
        else {
            material.diffuse.contents = UIColor.whiteColor()
        }
        self.geometry?.materials = [material]
    }
    
}
