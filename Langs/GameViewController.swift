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
    
    // var level: Level!;
    var light: SCNNode!
    
    var line: SCNNode!
    var starLines = [LineNode]()
    var maybedelete = [StarNode]()
    var highLightedStars = [StarNode]()
    var activeStar: StarNode?
    var lineNum = 0
    
    // get star statistics
    let starList = YQDataMediator.instance.getStarByAttr()
    
    // get constellation
    let constellation = YQDataMediator.instance.getConstellationByLevel(1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        let camera = SCNCamera()
        //        camera.focalDistance = 0.0
        camera.zFar = 10000
        camera.zNear = 0.1
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 1)
        //        let constraint = SCNLookAtConstraint(target: StarNode)
        //        constraint.gimbalLockEnabled = true
        //        cameraNode.constraints = [constraint]
        scene.rootNode.addChildNode(cameraNode)
        
        let ambientLight = SCNLight()
        ambientLight.color = UIColor.whiteColor()
        ambientLight.type = SCNLightTypeAmbient
        cameraNode.light = ambientLight
        
        let spotLight = SCNLight()
        spotLight.type = SCNLightTypeSpot
        spotLight.castsShadow = true
        spotLight.spotInnerAngle = 70.0
        spotLight.spotOuterAngle = 90.0
        spotLight.zFar = 1000
        light = SCNNode()
        light.light = spotLight
        light.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(light)
        
        // add all stars
        for star in starList {
            let starNode: StarNode = StarNode(star: star as! Star)
            scene.rootNode.addChildNode(starNode)
        }
        
        let sceneView = self.view as! SCNView
        sceneView.scene = scene
        
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
        tapRecognizer.addTarget(self, action: "handleTap:")
        sceneView.addGestureRecognizer(tapRecognizer)
        
        //setScene()
        
        
    }
    
    //    func setScene() {
    //        let sceneView = self.view as! SCNView
    //
    //        let sphere = SCNNode()
    //        sphere.geometry = SCNSphere(radius: 0.5)
    //        let materialsphere = SCNMaterial()
    //        //        materialsphere.diffuse.contents = UIColor.whiteColor()
    //        materialsphere.transparency = 0.5
    //        sphere.geometry?.materials = [materialsphere]
    //        sphere.position = SCNVector3(0, 0, 0)
    //        //        sphere.camera = camera
    //        sceneView.scene?.rootNode.addChildNode(sphere)
    //
    //        let zCoor = SCNNode()
    //        zCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
    //        let material1 = SCNMaterial()
    //        material1.diffuse.contents = UIColor.yellowColor()
    //        material1.transparency = 0.5
    //        zCoor.geometry?.materials = [material1]
    //        zCoor.position = SCNVector3(0, 0, 0)
    //        zCoor.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2))
    //        sceneView.scene?.rootNode.addChildNode(zCoor)
    //
    //        let yCoor = SCNNode()
    //        yCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
    //        let material2 = SCNMaterial()
    //        material2.diffuse.contents = UIColor.greenColor()
    //        material2.transparency = 0.5
    //        yCoor.geometry?.materials = [material2]
    //        yCoor.position = SCNVector3(0, 0, 0)
    //        yCoor.rotation = SCNVector4Make(0, 1, 0, 0)
    //        sceneView.scene?.rootNode.addChildNode(yCoor)
    //
    //        let xCoor = SCNNode()
    //        xCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
    //        let material3 = SCNMaterial()
    //        material3.diffuse.contents = UIColor.blueColor()
    //        material3.transparency = 0.5
    //        xCoor.geometry?.materials = [material3]
    //        xCoor.position = SCNVector3(0, 0, 0)
    //        xCoor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2))
    //        sceneView.scene?.rootNode.addChildNode(xCoor)
    //    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        let sceneView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(sceneView)
        let hitResults = sceneView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            let star = result.node as! StarNode
            var flag = false
            var index3 = 0
            var removableline1: LineNode!
            
            if (activeStar == nil) {
                activeStar = star
                star.highlight(true)
                if !highLightedStars.contains(star) {
                    highLightedStars.append(star)
                }
                maybedelete.append(star)
            }
            else {
                if (highLightedStars.contains(star)) {
                    maybedelete.append(star)
                    if maybedelete.count >= 2 {
                        var i = 0
                        for removableline in starLines {
                            if ((removableline.starA == maybedelete[0] && removableline.starB == maybedelete[1]) || (removableline.starB == maybedelete[0] && removableline.starA == maybedelete[1])) {
                                var index1 = 0
                                var index2 = 0
                                for index in 0...(highLightedStars.count - 1) {
                                    if highLightedStars[index]==removableline.starA {
                                        index1 = index
                                    }
                                    else if highLightedStars[index]==removableline.starB {
                                        index2 = index
                                    }
                                }
                                if index1 > index2 {
                                    highLightedStars.removeAtIndex(index1)
                                    highLightedStars.removeAtIndex(index2)
                                }
                                else if index1 < index2 {
                                    highLightedStars.removeAtIndex(index2)
                                    highLightedStars.removeAtIndex(index1)
                                }
                                removableline.starA.highlight(false)
                                removableline.starB.highlight(false)
                                removableline1 = removableline
                                maybedelete.removeAll()
                                index3 = i
                                flag = true
                                break
                            }
                            i++
                        }
                    }
                }
                if (!flag) {
                    maybedelete.removeAll()
                    let line = LineNode(starFrom: activeStar!, starTo: star)
                    starLines.append(line)
                    activeStar = nil
                    star.highlight(true)
                    sceneView.scene?.rootNode.addChildNode(line)
                    if (!highLightedStars.contains(star)) {
                        highLightedStars.append(star)
                    }
                    lineNum++
                }
                else if (flag) {
                    maybedelete.removeAll()
                    activeStar = nil
                    starLines.removeAtIndex(index3)
                    removableline1.removeFromParentNode()
                    flag = false
                    lineNum--
                }
            }
            
            let constellationNode = Constellation()
            
            for x in starLines {
                
                let temp = Line()
                temp.star1hd = (x.starA.data?.hd)!
                temp.star2hd = (x.starB.data?.hd)!
                
                constellationNode.linelist.append(temp)
            }
            
            print(constellation.linelist.count)
            print(lineNum)
            
            
            if lineNum == constellation.linelist.count {
                //if constellationNode.isequal(constellation) {
                    print("!")
                    let gameNameText = SCNText(string: "Amazing", extrusionDepth: 5)
                    gameNameText.font = UIFont(name: "Optima", size: 10)
                    let gameNameTextNode = SCNNode(geometry: gameNameText)
                    gameNameTextNode.position = SCNVector3(x: -54, y: -3, z: 80)
                    gameNameTextNode.rotation = SCNVector4(0, 0, 1, Float(-3 * (M_PI/7)))
                    sceneView.scene?.rootNode.addChildNode(gameNameTextNode)
                //}
            }
        }
        
    }
    
    
    
    
    
    
    //            if result.node.categoryBitMask == 1 {
    //                let star = result.node as! StarNode
    //                if (activeStar == nil) {
    //                    activeStar = star
    //                    star.highlight(true)
    //                    highLightedStars.append(activeStar!)
    //                }
    //                else {
    //                    let line = LineNode(starFrom: activeStar!, starTo: star)
    //                    activeStar = nil
    //                    star.highlight(true)
    //                    sceneView.scene?.rootNode.addChildNode(line)
    //                    print(line)
    //                    starLines.append(line)
    //                }
    //            }
    //            else if result.node.categoryBitMask == 2 {
    //                let removableLine = result.node as! LineNode
    //                //print("111")
    //                removableLine.removeFromParentNode()
    //            }
    
    
    
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
