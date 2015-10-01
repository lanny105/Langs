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
//    var ground: SCNNode!
    var light: SCNNode!
    
    var sphere1: SCNNode!
    var sphere2: SCNNode!
    var sphere3: SCNNode!
    var sphere4: SCNNode!
    var sphere5: SCNNode!
    
    var line: SCNNode!
    var starLines = [SCNNode]()
    var starHighLights = [SCNNode]()
    var highLightedStars = [SCNNode]()
    var stars = [SCNNode]()
    
    var touchsphere: SCNNode!
    var starTouchAreas = [SCNNode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = SCNView(frame: self.view.frame)
        sceneView.scene = SCNScene()
        self.view.addSubview(sceneView)
        
//        let groundGeometry = SCNFloor()
//        groundGeometry.reflectivity = 0
//        let groundMaterial = SCNMaterial()
//        groundMaterial.diffuse.contents = UIColor.blueColor()
//        groundGeometry.materials = [groundMaterial]
//        ground = SCNNode(geometry: groundGeometry)
//        ground.position = SCNVector3(x: 0, y: -30, z: -20)
//        ground.hidden = false
        
//                let earthGeometry = SCNSphere(radius: 150)
//                let earthMaterial = SCNMaterial()
//                earthMaterial.diffuse.contents = UIColor.blueColor()
//                earthGeometry.materials = [earthMaterial]
//                sphere3 = SCNNode(geometry: earthGeometry)
//                sphere3.position = SCNVector3(x: 0, y: -20, z: 0)
        
        let camera = SCNCamera()
        camera.zFar = 10000
        self.camera = SCNNode()
        self.camera.camera = camera
        self.camera.position = SCNVector3(x: -20, y: 15, z: 20)
//        let constraint = SCNLookAtConstraint(target: ground)
//        constraint.gimbalLockEnabled = true
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
        
        let sphereGeometry = SCNSphere(radius: 0.3)
        let sphereMaterial = SCNMaterial()
        sphereMaterial.diffuse.contents = UIColor.whiteColor()
        sphereGeometry.materials = [sphereMaterial]
        sphere1 = SCNNode(geometry: sphereGeometry)
        sphere1.position = SCNVector3(x: -20, y: 25, z: -3)
        sphere2 = SCNNode(geometry: sphereGeometry)
        sphere2.position = SCNVector3(x: -30, y: 20, z: 0)
        sphere3 = SCNNode(geometry: sphereGeometry)
        sphere3.position = SCNVector3(x: -10, y: 18, z: -1)
        sphere4 = SCNNode(geometry: sphereGeometry)
        sphere4.position = SCNVector3(x: -15, y: 10, z: -1)
        sphere5 = SCNNode(geometry: sphereGeometry)
        sphere5.position = SCNVector3(x: -27, y: 12, z: 2)
        stars.append(sphere1)
        stars.append(sphere2)
        stars.append(sphere3)
        stars.append(sphere4)
        stars.append(sphere5)
        
        sceneView.scene?.rootNode.addChildNode(self.camera)
//        sceneView.scene?.rootNode.addChildNode(ground)
        sceneView.scene?.rootNode.addChildNode(light)
        sceneView.scene?.rootNode.addChildNode(sphere1)
        sceneView.scene?.rootNode.addChildNode(sphere2)
        sceneView.scene?.rootNode.addChildNode(sphere3)
        sceneView.scene?.rootNode.addChildNode(sphere4)
        sceneView.scene?.rootNode.addChildNode(sphere5)
        
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
        sceneView.addGestureRecognizer(tapRecognizer)
//        sceneView.gestureRecognizers = [tapRecognizer]
        
        
//        makeTouchArea()
        makeHighLights()
        
    }
    
    func makeHighLights() {
        for star in self.stars {
            let sphereGeometry1 = SCNSphere(radius: 0.3)
            let sphereMaterial1 = SCNMaterial()
            sphereMaterial1.diffuse.contents = UIColor.yellowColor()
            sphereGeometry1.materials = [sphereMaterial1]
            
            let starHighLight = SCNNode(geometry: sphereGeometry1)
            starHighLight.position = star.position
            starHighLight.hidden = true
            
            sceneView.scene?.rootNode.addChildNode(starHighLight)
            self.starHighLights.append(starHighLight)
        }
    }
    
//    func makeTouchArea(){
//        for star in self.stars{
//            let sphereGeometry1 = SCNSphere(radius: 2)
//            let sphereMaterial1 = SCNMaterial()
//            sphereMaterial1.diffuse.contents = UIColor.greenColor()
//            sphereGeometry1.materials = [sphereMaterial1]
//            let touchsphere = SCNNode(geometry: sphereGeometry1)
//            //tochsphere.position = SCNVector3(x: star.position.x, y: star.position.y, z: star.position.z)
//            touchsphere.position = star.position
//            touchsphere.hidden = true
//            star.addChildNode(touchsphere)
//            self.starTouchAreas.append(touchsphere)
//            
//            //sceneView.backgroundColor=UIColor.blueColor()
//        }
//    }
    
    func sceneTapped(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(sceneView)
        let hitResults = sceneView.hitTest(location, options: nil)
        
        if hitResults.count > 0 {
            let result = hitResults[0] as! SCNHitTestResult
            let node = result.node
            var i = 0
            if stars.contains(node) {
                for star in self.stars {
                    if node == star {
                        //                      self.starTouchAreas[i].hidden = true //delete line will appear again!!!
                        self.starHighLights[i].hidden = false
                        self.highLightedStars.append(stars[i])
                        if highLightedStars.count == 2 {
                            line = lineBetweenNode(highLightedStars[0], nodeB: highLightedStars[1])
                            sceneView.scene?.rootNode.addChildNode(line)
                            self.starLines.append(line)
                            highLightedStars.removeAll()
                        }
                    }
                    
                    i++
                }
                print(starLines)

            }
            else if starLines.contains(node) {
                node.removeFromParentNode()
            }
            
        }
    }
    
//    func lineBetweenNode(nodeA: SCNNode, nodeB: SCNNode) -> SCNNode {
////        let root = view.scene!.rootNode
//        
//        var cylinder: SCNNode!
//        
//        // visualize a sphere
//        let sphere = SCNSphere(radius: 1)
//        sphere.firstMaterial?.transparency = 0.5
//        let sphereNode = SCNNode(geometry: sphere)
//        sceneView.scene?.rootNode.addChildNode(sphereNode)
//        
//        // some dummy points opposite each other on the sphere
//        let rootOneThird = Float(sqrt(1/3.0))
//        let p1 = SCNVector3(x: rootOneThird, y: rootOneThird, z: rootOneThird)
//        let p2 = SCNVector3(x: -rootOneThird, y: -rootOneThird, z: -rootOneThird)
//        
//        // height of the cylinder should be the distance between points
//        let height = CGFloat(GLKVector3Distance(SCNVector3ToGLKVector3(p1), SCNVector3ToGLKVector3(p2)))
//        
//        // add a container node for the cylinder to make its height run along the z axis
//        let zAlignNode = SCNNode()
//        zAlignNode.eulerAngles.x = Float(M_PI_2)
//        // and position the zylinder so that one end is at the local origin
//        let cylinderGeometry = SCNCylinder(radius: 0.1, height: height)
//        cylinder = SCNNode(geometry: cylinderGeometry)
//        cylinder.position.y = Float(-height * 0.5)
//        zAlignNode.addChildNode(cylinder)
//        
//        // put the container node in a positioning node at one of the points
//        nodeB.addChildNode(zAlignNode)
//        // and constrain the positioning node to face toward the other point
//        nodeB.constraints = [ SCNLookAtConstraint(target: nodeA) ]
////        return SCNNode(geometry: c)
//    }
    
    
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
//
//    func renderer(aRenderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: NSTimeInterval) {
//        //Makes the lines thicker
//        glLineWidth(100)
//    }
    
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
