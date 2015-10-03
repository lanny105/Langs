//
//  StartViewController.swift
//  Langs
//
//  Created by Can on 9/28/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        
        
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
        
        // add game name
        let gameNameText = SCNText(string: "Startrix", extrusionDepth: 5)
        gameNameText.font = UIFont(name: "Optima", size: 4)
        let gameNameTextNode = SCNNode(geometry: gameNameText)
        gameNameTextNode.position = SCNVector3(x: -6, y: 1, z: 0)
        
        scene.rootNode.addChildNode(gameNameTextNode)
        
        // add start info with pic
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "start.png")
        
        // add start box
        let boxGeometry = SCNBox(width: 4, height: 2, length: 2, chamferRadius: 0.4)
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
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.blackColor()
        
        
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        scnView.addGestureRecognizer(tapGesture)
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
            
            self.performSegueWithIdentifier("startViewToLevelsViewSegue", sender: nil)
        }
        
        
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