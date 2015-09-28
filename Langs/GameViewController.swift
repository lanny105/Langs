//
//  GameViewController.swift
//  StarII
//
//  Created by Vera Wu on 9/26/15.
//  Copyright (c) 2015 YunruWu. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var sceneView: SCNView!
    var camera: SCNNode!
    var ground: SCNNode!
    var light: SCNNode!
    var sphere1: SCNNode!
    var sphere2: SCNNode!
    var sphere3: SCNNode!
    var stars = [SCNNode]();
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        sceneView = SCNView(frame: self.view.frame)
        sceneView.scene = SCNScene()
        self.view.addSubview(sceneView)
        
        let groundGeometry = SCNFloor()
        groundGeometry.reflectivity = 0
        let groundMaterial = SCNMaterial()
        groundMaterial.diffuse.contents = UIColor.blueColor()
        groundGeometry.materials = [groundMaterial]
        ground = SCNNode(geometry: groundGeometry)
        ground.position = SCNVector3(x: 0, y: -30, z: -20)
        ground.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.Static, shape: nil)
        
        //        let earthGeometry = SCNSphere(radius: 150)
        //        let earthMaterial = SCNMaterial()
        //        earthMaterial.diffuse.contents = UIColor.blueColor()
        //        earthGeometry.materials = [earthMaterial]
        //        sphere3 = SCNNode(geometry: earthGeometry)
        //        sphere3.position = SCNVector3(x: 0, y: -20, z: 0)
        
        let camera = SCNCamera()
        camera.zFar = 10000
        self.camera = SCNNode()
        self.camera.camera = camera
        self.camera.position = SCNVector3(x: -20, y: 15, z: 20)
        let constraint = SCNLookAtConstraint(target: ground)
        constraint.gimbalLockEnabled = true
        //        self.camera.constraints = [constraint]
        
        let ambientLight = SCNLight()
        ambientLight.color = UIColor.darkGrayColor()
        ambientLight.type = SCNLightTypeAmbient
        self.camera.light = ambientLight
        
        let spotLight = SCNLight()
        spotLight.type = SCNLightTypeSpot
        spotLight.castsShadow = true
        spotLight.spotInnerAngle = 70.0
        spotLight.spotOuterAngle = 90.0
        spotLight.zFar = 1000
        light = SCNNode()
        light.light = spotLight
        light.position = SCNVector3(x: -20, y: 15, z: 25)
        //        light.constraints = [constraint]
        
        let sphereGeometry = SCNSphere(radius: 0.5)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.whiteColor()
        sphereGeometry.materials = [sphereMaterial]
        sphere1 = SCNNode(geometry: sphereGeometry)
        sphere1.position = SCNVector3(x: -20, y: 25, z: -3)
        sphere2 = SCNNode(geometry: sphereGeometry)
        sphere2.position = SCNVector3(x: -30, y: 20, z: 0)
        sphere3 = SCNNode(geometry: sphereGeometry)
        sphere3.position = SCNVector3(x: -10, y: 18, z: -1)
        stars.append(sphere1)
        stars.append(sphere2)
        stars.append(sphere3)
        
        sceneView.scene?.rootNode.addChildNode(self.camera)
        sceneView.scene?.rootNode.addChildNode(ground)
        sceneView.scene?.rootNode.addChildNode(light)
        sceneView.scene?.rootNode.addChildNode(sphere1)
        sceneView.scene?.rootNode.addChildNode(sphere2)
        sceneView.scene?.rootNode.addChildNode(sphere3)
        
        // allows the user to manipulate the camera
        sceneView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // configure the view
        sceneView.backgroundColor = UIColor.blackColor()
        
        // add a tap gesture recognizer
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: "sceneTapped:")
        sceneView.gestureRecognizers = [tapRecognizer]
    }
    
    func sceneTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(sceneView)
        
        let hitResults = sceneView.hitTest(location, options: nil)
        if hitResults.count > 0 {
            let result = hitResults[0] as! SCNHitTestResult
            let node = result.node
            
            for node in stars {
                SCNTransaction.begin()
                //SCNTransaction.setAnimationDuration(0.5)
                let materials = node.geometry!.materials as! [SCNMaterial]
                let material = materials[0]
                material.diffuse.contents = UIColor.yellowColor()
                SCNTransaction.commit()
                
                //let action = SCNAction.moveByX(0, y: -0.8, z: 0, duration: 0.5)
                //node.runAction(action)
            }
        }
    }
    
    func lineBetweenNode(nodeA: SCNNode, nodeB: SCNNode) -> SCNNode {
        let positions: [Float32] = [nodeA.position.x, nodeA.position.y, nodeA.position.z, nodeB.position.x, nodeB.position.y, nodeB.position.z]
        let positionData = NSData(bytes: positions, length: sizeof(Float32)*positions.count)
        let indices: [Int32] = [0, 1]
        let indexData = NSData(bytes: indices, length: sizeof(Int32) * indices.count)
        
        let source = SCNGeometrySource(data: positionData, semantic: SCNGeometrySourceSemanticVertex, vectorCount: indices.count, floatComponents: true, componentsPerVector: 3, bytesPerComponent: sizeof(Float32), dataOffset: 0, dataStride: sizeof(Float32) * 3)
        let element = SCNGeometryElement(data: indexData, primitiveType: SCNGeometryPrimitiveType.Line, primitiveCount: indices.count, bytesPerIndex: sizeof(Int32))
        
        let line = SCNGeometry(sources: [source], elements: [element])
        return SCNNode(geometry: line)
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
