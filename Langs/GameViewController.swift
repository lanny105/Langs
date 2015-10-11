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

var indicatefinal = 0

class GameViewController: UIViewController, SCNSceneRendererDelegate{
    // var level: Level!;
    var light: SCNNode!
    
    var line: SCNNode!
    var starLines = [LineNode]()
    var maybedelete = [StarNode]()
    var highLightedStars = [StarNode]()
    var activeStar: StarNode?
    var lineNum = 0
    
    let constellationUserState = Constellation()
    // get star statistics
    let starList = YQDataMediator.instance.getStarByAttr()
    
    // get constellation
    let constellation = YQDataMediator.instance.getConstellationByLevel(1)
    
    
    let cameraNode = SCNNode()
    var flag = false
    var xPosition : Float = 0
    var yPosition : Float = 0
    
    let cameraPositionZ : Float = 0
    
    var lastLocation : SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    
    
    //// animation
    
    var cameraHandleTranforms = [SCNMatrix4](count:10, repeatedValue:SCNMatrix4(m11: 0.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 0.0))
    
    
    var spriteScene = OverlayScene!()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.name = "camera"
        
        //// animation
        
        //        self.cameraHandleTranforms.insert(cameraNode.transform, atIndex: 0)
        
        scene.rootNode.addChildNode(self.cameraNode)
        
        // place the camera
        self.cameraNode.position = SCNVector3(x: 0, y: 0, z: self.cameraPositionZ)
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
        sceneView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // configure the view
        sceneView.backgroundColor = UIColor.blackColor()
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        sceneView.addGestureRecognizer(panGesture)
        
        // add a tap gesture recognizer
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: "handleTap:")
        sceneView.addGestureRecognizer(tapRecognizer)
        
        spriteScene = OverlayScene(size: self.view.bounds.size)
        sceneView.overlaySKScene = spriteScene
        
        //setScene()
        
        
    }
    
//        func setScene() {
//            let sceneView = self.view as! SCNView
//    
//            let sphere = SCNNode()
//            sphere.geometry = SCNSphere(radius: 0.5)
//            let materialsphere = SCNMaterial()
//            //        materialsphere.diffuse.contents = UIColor.whiteColor()
//            materialsphere.transparency = 0.5
//            sphere.geometry?.materials = [materialsphere]
//            sphere.position = SCNVector3(0, 0, 0)
//            //        sphere.camera = camera
//            sceneView.scene?.rootNode.addChildNode(sphere)
//    
//            let zCoor = SCNNode()
//            zCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
//            let material1 = SCNMaterial()
//            material1.diffuse.contents = UIColor.yellowColor()
//            material1.transparency = 0.5
//            zCoor.geometry?.materials = [material1]
//            zCoor.position = SCNVector3(0, 0, 0)
//            zCoor.rotation = SCNVector4Make(1, 0, 0, Float(M_PI/2))
//            sceneView.scene?.rootNode.addChildNode(zCoor)
//    
//            let yCoor = SCNNode()
//            yCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
//            let material2 = SCNMaterial()
//            material2.diffuse.contents = UIColor.greenColor()
//            material2.transparency = 0.5
//            yCoor.geometry?.materials = [material2]
//            yCoor.position = SCNVector3(0, 0, 0)
//            yCoor.rotation = SCNVector4Make(0, 1, 0, 0)
//            sceneView.scene?.rootNode.addChildNode(yCoor)
//    
//            let xCoor = SCNNode()
//            xCoor.geometry = SCNCylinder(radius: 0.1, height: 100)
//            let material3 = SCNMaterial()
//            material3.diffuse.contents = UIColor.blueColor()
//            material3.transparency = 0.5
//            xCoor.geometry?.materials = [material3]
//            xCoor.position = SCNVector3(0, 0, 0)
//            xCoor.rotation = SCNVector4Make(0, 0, 1, Float(M_PI/2))
//            sceneView.scene?.rootNode.addChildNode(xCoor)
//        }
    
    func checkLine(node1: StarNode, node2: StarNode)->Bool{
        let lineRes = Line()
        lineRes.star1hd = (node1.data?.hd)!
        lineRes.star2hd = (node2.data?.hd)!
        lineRes.adjust()
        //var index:Int
        //print(constellationUserState.linelist)
        
        //constellationUserState.linelist.append(lineRes)
        
        for findline in constellationUserState.linelist{
            if(findline.star1hd == lineRes.star1hd && findline.star2hd == lineRes.star2hd){
                return true
            }
        }
        return false
        
        
    }
    
    func findLineIndex(node1: StarNode, node2: StarNode)->Int{
        var index=0
        let lineRes = Line()
        lineRes.star1hd=(node1.data?.hd)!
        lineRes.star2hd=(node2.data?.hd)!
        lineRes.adjust()
        for findline in constellationUserState.linelist{
            if(findline.star1hd == lineRes.star1hd && findline.star2hd == lineRes.star2hd){
                return index
            }
            index++
        }
        return index
    }
    
    func findStarIndex(node: StarNode)->Int{
        var index=0
        let starRes = Star()
        starRes.hd = (node.data?.hd)!
        for findstar in constellationUserState.starlist{
            if(findstar.hd == starRes.hd){
                return index
            }
            index++
        }
        return -1
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        let sceneView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(sceneView)
        let hitResults = sceneView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result:SCNHitTestResult = hitResults[0]
            //let result: AnyObject! = hitResults[0]
            let star = result.node as! StarNode
            
            
            if(activeStar == nil){
                activeStar = star
                star.highlight(true)
            }else{
                if activeStar != star{
                if(!checkLine(activeStar!, node2: star)){
                    let line = LineNode(starFrom: activeStar!, starTo: star)
                    starLines.append(line)
                    let lineRes = Line()
                    lineRes.star1hd=(activeStar?.data?.hd)!
                    lineRes.star2hd=(star.data?.hd)!
                    lineRes.adjust()
                    constellationUserState.linelist.append(lineRes)
                    let star1Res = Star()
                    star1Res.hd = (activeStar?.data?.hd)!
                    let star2Res = Star()
                    star2Res.hd = (star.data?.hd)!
                    constellationUserState.starlist.append(star1Res)
                    constellationUserState.starlist.append(star2Res)
                    star.highlight(true)
                    sceneView.scene?.rootNode.addChildNode(line)
                    lineNum++
                }else{
                    let lineindex = findLineIndex(activeStar!, node2: star)
                    let removeline = LineNode(starFrom: activeStar!, starTo: star)
                    for starline in starLines{
                        if ((starline.starA.data?.hd == removeline.starA.data?.hd && starline.starB.data?.hd == removeline.starB.data?.hd) || (starline.starA.data?.hd == removeline.starB.data?.hd && starline.starB.data?.hd == removeline.starA.data?.hd)){
                            starline.removeFromParentNode()
                            let index = starLines.indexOf(starline)
                            starLines.removeAtIndex(index!)
                            break
                        }
                    }
                    
                    if(lineindex != -1){
                        constellationUserState.linelist.removeAtIndex(lineindex)
                    }
                    
                    lineNum--
                    //use to unhighlight stars
                    var flag = 0
                    for stars in constellationUserState.starlist{
                        let starnode1: StarNode = StarNode(star: stars as! Star)
                        if(checkLine(star, node2: starnode1)){
                            flag++
                        }
                    }
                    if(flag == 0){
                        star.highlight(false)
                        let star1index = findStarIndex(star)
                        if(star1index != -1){
                            constellationUserState.starlist.removeAtIndex(star1index)
                        }
                    }
                    flag = 0
                    for stars in constellationUserState.starlist{
                        let starnode2: StarNode = StarNode(star: stars as! Star)
                        if(checkLine(activeStar!, node2: starnode2)){
                            flag++
                        }
                    }
                    if(flag == 0){
                        activeStar!.highlight(false)
                        let star2index = findStarIndex(star)
                        if(star2index != -1){
                            constellationUserState.starlist.removeAtIndex(star2index)
                        }
                    }
                }
                activeStar = nil
            }
                
            }
            
            
            
            print(lineNum)
            

            
            if lineNum >= constellation.linelist.count {
                let constellationNode = Constellation()
                
                for x in constellationUserState.linelist {
                    constellationNode.linelist.append(x)
                }
                if constellationNode.isequal(constellation) {
                    indicatefinal = 1
                    spriteScene.makeHintFinal()
                    let gameNameText = SCNText(string: "Amazing", extrusionDepth: 5)
                    gameNameText.font = UIFont(name: "Optima", size: 10)
                    let gameNameTextNode = SCNNode(geometry: gameNameText)
                    gameNameTextNode.position = SCNVector3(x: -54, y: -3, z: 80)
                    gameNameTextNode.rotation = SCNVector4(0, 0, 1, Float(-3 * (M_PI/7)))
                    sceneView.scene?.rootNode.addChildNode(gameNameTextNode)
                }
            }
        }
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //        lastLocation = self.cameraNode.position
        lastLocation = self.cameraNode.eulerAngles
    }
    
}
