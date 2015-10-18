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
import SpriteKit

//var indicatefinal = 0

class GameViewController: UIViewController, SCNSceneRendererDelegate{
    
    var light: SCNNode!
    
    var line: SCNNode!
    var starLines = [LineNode]()
    var activeStar: StarNode?
    var lineNum = 0
    
    var spriteScene = OverlayScene!()
    
    let constellationUserState = Constellation()
    // get star statistics
//    let starList = YQDataMediator.instance.getStarByAttr(2)
    var starList = [Star]()
    
    // get constellation
//    var constellation = YQDataMediator.instance.getConstellationByLevel(1)
    var constellation = Constellation()
    
    var hintImageNamed = "bdqx2"
    var finalImageNamed = "finish"
    
    
    let cameraNode = SCNNode()
    
    let cameraPositionZ : Float = 0
    
    var lastLocation : SCNVector3 = SCNVector3(x: 0, y: 0, z: 0)
    var scale: CGFloat = 1.0
    
    var clickHintFlag=0
    //// animation
    
    var cameraHandleTranforms = [SCNMatrix4](count:10, repeatedValue:SCNMatrix4(m11: 0.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 0.0))
   
    var timer = NSTimer()
    //var timer2 = NSTimer()
    var timecount = 0
    var timerRuning = true
    var result = "Time: "
    
    
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
        scene.rootNode.addChildNode(cameraNode)
        
        let ambientLight = SCNLight()
        ambientLight.color = UIColor.whiteColor()
        ambientLight.type = SCNLightTypeAmbient
        cameraNode.light = ambientLight
        cameraNode.camera?.zFar = 200
        
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
            let starNode: StarNode = StarNode(star: star )
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
        
        // configure camera gestures
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        sceneView.addGestureRecognizer(panGesture)
        
        let pinchGesture = UIPinchGestureRecognizer()
        pinchGesture.addTarget(self, action: "handlePinch:")
        sceneView.addGestureRecognizer(pinchGesture)
        
        // add a tap gesture recognizer
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: "handleTap:")
        sceneView.addGestureRecognizer(tapRecognizer)
        

        spriteScene = OverlayScene(size: self.view.bounds.size)
        sceneView.overlaySKScene = spriteScene
        //NSNotificationCenter.defaultCenter().addObserver(spriteScene, selector:"handleHint:" as Selector, name:"ShowHintNotification", object:nil)
        print("44444")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeScene", name: "changeSceneNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeHintNotifi", name: "makeHintNotification", object: nil)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("Counting"), userInfo: nil, repeats: true)
        
//        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: ("callHintNotifi"), userInfo: nil, repeats: true)        
        print("22222")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // Function to pop this view controller and go back to my Levels screen
    func changeScene() {
        print("0000000")
        self.performSegueWithIdentifier("gameViewToLevelsViewSegue", sender: nil)
        print("1111")
    }
    
//    func callHintNotifi(){
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "makeHintNotifi", name: "makeHintNotification", object: nil)
//    }
    
    func makeHintNotifi(){
        
        let sceneView = self.view as! SCNView
        if(clickHintFlag == 0){
            clickHintFlag = 1
            spriteScene.makeHint(hintImageNamed)
        }else{
            clickHintFlag = 0
            spriteScene.hindHint()
            
        }
        sceneView.overlaySKScene=spriteScene
        
    }
    
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
                }else{
                    star.highlight(false)
                    activeStar = nil
                }
                
            }
            
            
            
            //print(lineNum)
            

            
            if lineNum >= constellation.linelist.count {
                let constellationNode = Constellation()
                
                for x in constellationUserState.linelist {
                    constellationNode.linelist.append(x)
                }
                print(constellation.returnAttri())
                if constellationNode.isequal(constellation) {
                    //indicatefinal = 1

//                    spriteScene.makeHintFinal()
                    spriteScene.timerNode.text = self.result
                    
                    //spriteScene.updatemem(result)
                    changetimerstate()

                    spriteScene.makeHintFinal(finalImageNamed)
                    spriteScene.maketimer()

                }
            }
        }
        
        
        
        
    }
    
    func handlePan(gestureRecognize: UIPanGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        let point = gestureRecognize.translationInView(scnView)
        
        //print("\(point.x), \(point.y)")
        
        self.cameraNode.eulerAngles.x = lastLocation.x + Float(point.y)/2000
        self.cameraNode.eulerAngles.y = lastLocation.y + Float(point.x)/2000
        lastLocation = self.cameraNode.eulerAngles
        
        //print("----",lastLocation)
        //print("||||",matrix_transform(lastLocation.x,theta2: lastLocation.y))
        
        //var a: SCNVector3
        
        //a = matrix_transform(lastLocation.x, theta2: lastLocation.y)
        
        //self.cameraNode.position = coordinates_transform()
        //print(cameraNode.position)
        //print(lastLocation)
        
        
        //let x = self.cameraNode.position.x
        //let y = self.cameraNode.position.y
        //let z = self.cameraNode.position.z
        
        
        //print(pow(x*x + y*y + z*z, 0.5))
        
        
        
        //        SCNTransaction.commit()
    }
    
    
    func changetimerstate(){
        
        if(!timerRuning){
            timerRuning = true
        }
            
        else{
            timerRuning = false
        }
    }
    
    
    func Counting(){
        
        
        if(!timerRuning){
            return
        }
        //let sceneView = self.view as! SCNView
        self.timecount += 1
        
        //spriteScene = OverlayScene(size: self.view.bounds.size)
        //spriteScene.timer()
        
        
        
        
        result = "Time: "
        
        let minute = self.timecount/60;
        
        if(minute>=1 && minute<10){
            result += "0\(minute):"
        }
            
        else if(minute>=10){
            result += "\(minute):"
        }
            
        else{
            result += "00:"
        }
        
        if(self.timecount%60<10){
            result += "0\(self.timecount%60)"
        }
            
        else{
            result += "\(self.timecount%60)"
        }
        
        
        
        //spriteScene.scoreNode.text = "Time: "+result
        //spriteScene.updatemem(result)
        
        
        //sceneView.overlaySKScene = spriteScene
        
        print(result)
        
        //spriteScene.timer()
        //print("hello")
        
    }
    
    
    
    func matrix_transform(theta1: Float, theta2: Float) ->SCNVector3{
        
        //var a: SCNVector3
        let x = sin(-theta2)*cos(-theta1)
        let y = -sin(-theta1)
        let z = -cos(-theta1)*cos(-theta2)
        
        return SCNVector3Make(x,y,z)
        
    
    }
    
    
//    func coordinates_transform() ->SCNVector3{
//        
//        let theta1 = lastLocation.x
//        let theta2 = lastLocation.y
//        
//        let x = self.cameraNode.position.x * cos(theta2) + sin(theta1) * sin(theta2) * self.cameraNode.position.y + self.cameraNode.position.z * cos(theta1) * sin(theta2)
//        
//        
//        let y = self.cameraNode.position.y * cos(theta1) + sin(-theta1)*self.cameraNode.position.z
//        
//        let z = -self.cameraNode.position.x*sin(theta2) + self.cameraNode.position.y * sin(theta1)*cos(theta2) + self.cameraNode.position.z * cos(theta1)*cos(theta2)
//        
//        
//        return SCNVector3Make(x,y,z)
//        
//        
//        
//    }
    
    
    func handlePinch(gestureRecognizer: UIPinchGestureRecognizer) {
        
        var a: SCNVector3
        
        a = matrix_transform(lastLocation.x, theta2: lastLocation.y)
        //print("|||||",self.lastLocation)
        //print("-----",a)
//        let x = self.cameraNode.position.x
//        let y = self.cameraNode.position.y
//        let z = self.cameraNode.position.z
//        
//        
//        print(pow(x*x + y*y + z*z, 0.5))
//        //print(gestureRecognizer.scale)
//        self.scale = gestureRecognizer.scale
        
        if(gestureRecognizer.scale < 1){
            
            self.cameraNode.position = SCNVector3Make(self.cameraNode.position.x - a.x, self.cameraNode.position.y - a.y, self.cameraNode.position.z - a.z)
            //print("fuck!")
            //print("-----",lastLocation)
            //print("|||||",self.cameraNode.position)
            
        }
        
        else{
            self.cameraNode.position = SCNVector3Make(self.cameraNode.position.x + a.x, self.cameraNode.position.y + a.y, self.cameraNode.position.z + a.z)
            //print("-----",lastLocation)
            //print("|||||",self.cameraNode.position)
            
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
