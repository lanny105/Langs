//
//  LevelsViewController.swift
//  Langs
//
//  Created by Can on 9/28/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class LevelsViewController: UIViewController {
    
    let cameraNode = SCNNode()
    var flag = false
    var xPosition : Float = 0
    var yPosition : Float = 0
    
    let cameraPositionZ : Float = 30
    
    var lastLocation : SCNVector3 = SCNVector3(x: 0, y: 0, z: 30)
    
    
    //// animation
    
    var cameraHandleTranforms = [SCNMatrix4](count:10, repeatedValue:SCNMatrix4(m11: 0.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 0.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // create and add a camera to the scene
        //        let cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.name = "camera"
        
        //// animation
        
        //        self.cameraHandleTranforms.insert(cameraNode.transform, atIndex: 0)
        
        scene.rootNode.addChildNode(self.cameraNode)
        
        // place the camera
        self.cameraNode.position = SCNVector3(x: 0, y: 0, z: self.cameraPositionZ)
        
        
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        scene.rootNode.addChildNode(ambientLightNode)
        
        //        // retrieve the ship node
        //        let ship = scene.rootNode.childNodeWithName("ship", recursively: true)!
        //
        //        // animate the 3d object
        //        ship.runAction(SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1)))
        
        // add level info with pic
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "level1-1.png")
        
        // add level box
        let boxGeometry = SCNBox(width: 4, height: 4, length: 4, chamferRadius: 0.4)
        boxGeometry.materials = [material]
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.position = SCNVector3(0, 0, 0)
        
        scene.rootNode.addChildNode(boxNode)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        // add a pan gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        scnView.addGestureRecognizer(panGesture)
        
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        scnView.addGestureRecognizer(tapGesture)
    }
    
    
    func handlePan(gestureRecognize: UIPanGestureRecognizer) {
        print("Pan!!")
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        let point = gestureRecognize.translationInView(scnView)
        
        print("\(point.x), \(point.y)")
        
        //// animation
        
        //        SCNTransaction.begin()
        //        SCNTransaction.setAnimationDuration(0.5)
        //
        //        SCNTransaction.setCompletionBlock() {
        //            print("done")
        //        }
        
        
        
        //        self.cameraNode.position.x = lastLocation.x - Float(point.x)/10
        //        self.cameraNode.position.y = lastLocation.y + Float(point.y)/10
        
        
        self.cameraNode.eulerAngles.x = lastLocation.x + Float(point.y)/400
        self.cameraNode.eulerAngles.y = lastLocation.y + Float(point.x)/400
        
        
        //        SCNTransaction.commit()
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)
        let hitResults = scnView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.setAnimationDuration(0.5)
            
            // on completion - unhighlight
            SCNTransaction.setCompletionBlock {
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(0.5)
                
                material.emission.contents = UIColor.blackColor()
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.redColor()
            
            SCNTransaction.commit()
            
            self.performSegueWithIdentifier("levelsViewToGameViewSegue", sender: nil)
        }
        
        //                self.cameraNode.eulerAngles.x -= 0.1
        //                self.cameraNode.eulerAngles.y += 0.1
        //                self.cameraNode.eulerAngles.z += 0.1
        
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //        lastLocation = self.cameraNode.position
        lastLocation = self.cameraNode.eulerAngles
    }
}