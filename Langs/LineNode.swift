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
        
        self.categoryBitMask = 2

        self.starA = starFrom
        self.starB = starTo

        let nodeA = starA;
        let nodeB = starB;

        let positions: [Float32] = [nodeA.position.x, nodeA.position.y, nodeA.position.z, nodeB.position.x, nodeB.position.y, nodeB.position.z]
        let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
        let indices: [Int32] = [0, 1]
        let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
        let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
        let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
        let line = SCNGeometry(sources: [source], elements: [element])
        line.firstMaterial?.lightingModelName = SCNLightingModelConstant
        line.firstMaterial?.emission.contents = UIColor.orangeColor()

        self.geometry = line
    }

    // MARK: - Member functions
    
//    func deleteLine (b: Bool) {
//        if (
//    }
    
}
