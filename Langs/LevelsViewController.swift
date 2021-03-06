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
    let lightNode = SCNNode()
    var flag = false
    var xPosition : Float = 0
    var yPosition : Float = 0
    
    let cameraPositionZ : Float = 30
    
    var lastLocation : SCNVector3 = SCNVector3(x: 0, y: 0, z: 30)
    
    
    // camera position boundary
    var leftPosition : Float = 0
    var rightPosition : Float = 0
    
    //// animation
    
    var cameraHandleTranforms = [SCNMatrix4](count:10, repeatedValue:SCNMatrix4(m11: 0.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 0.0))
    
//    override func viewWillAppear(animated: Bool) {
//        code
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        //        defaults.setFloat(2001, forKey: "userScore")
        
        if (defaults.stringForKey("userScore") == nil) {
            defaults.setFloat(0, forKey: "userScore")
        }
            
        
        // create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        let scene = SCNScene()
        
        
        // load level info and generate level boxNode
        
        let levelInfo: NSArray = YQDataMediator.instance.getConstellation()
        //        print(levelInfo.count)
        
        let path = NSBundle.mainBundle().pathForResource("LevelConfig", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        let score = defaults.stringForKey("userScore")
        
        for index in 0...((levelInfo.count)-1) {
            let dic = levelInfo[index] as! NSDictionary
            let levelID = dic.objectForKey("levelID") as! String
            
            //print(levelID)
            
            if let levelDict = dict!.valueForKey(levelID) {
                let levelBar = levelDict.valueForKey("bar")
                
                if (Float(score!) >= levelBar as? Float) {
                    //                print("Bar: \(levelBar)")
                    //                print("Index: \(index)")
                    //                print("Right: \(self.rightPosition)")
                    let boxNode = genLevelBoxNode(index, dic: dic)
                    if index == 0 {
                        //                    print("Set left")
                        self.leftPosition = boxNode.position.x - 1
                    }
                    
                    self.rightPosition = boxNode.position.x + 1
                    scene.rootNode.addChildNode(boxNode)
                }
                
            }
            else {
                print("\(levelID) is nil!!")
            }
            
        }
        
        
        
        // create and add a camera to the scene
        //        let cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        self.cameraNode.name = "camera"
        
        //// animation
        
//        self.cameraHandleTranforms.insert(cameraNode.transform, atIndex: 0)
        
        scene.rootNode.addChildNode(self.cameraNode)
        
        // place the camera
        self.cameraNode.position = SCNVector3(x: self.rightPosition, y: 0, z: self.cameraPositionZ)
        
        
        
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
        
        
        
        
        
//        for index in 0...((ary?.count)!-1) {
//            let boxNode = genLevelBoxNode(index)
//            if index == 0 {
//                self.leftPosition = boxNode.position.x - 1
//            }
//            else if index == ((ary?.count)!-1) {
//                self.rightPosition = boxNode.position.x + 1
//            }
//            scene.rootNode.addChildNode(boxNode)
//        }
        
        
        // create and add a light to the scene
        self.lightNode.light = SCNLight()
        self.lightNode.light!.type = SCNLightTypeOmni
//        self.lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(self.lightNode)
        
        // place the light
        self.lightNode.position = SCNVector3(x: self.rightPosition, y: 0, z: 5)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        //scnView.backgroundColor = UIColor(red: 14.0/255, green: 18.0/255, blue: 60.0/255, alpha: 1.0)
        scnView.scene?.background.contents = UIImage(named: "level-1.png")
        
        // add a pan gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        scnView.addGestureRecognizer(panGesture)
        
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        scnView.addGestureRecognizer(tapGesture)
        
        // add overlay
        let spriteScene = LevelOverlay(size: self.view.bounds.size)
        scnView.overlaySKScene = spriteScene
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goToStartView", name: "backNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keepTouch", name: "keepTouchNotification", object: nil)
    }
    
    func keepTouch() {
        self.lastLocation = self.cameraNode.position
    }
    
    func goToStartView() {
        self.performSegueWithIdentifier("levelsViewToStartViewSegue", sender: nil)
    }
    
    func genLevelBoxNode(indexNum: Int, dic: NSDictionary) -> SCNNode {
        let levelID = dic.objectForKey("levelID") as! String
        let levelName = dic.objectForKey("levelName") as! String
        let levelCat = dic.objectForKey("levelCat") as! String

//        print(levelID)
//        print(levelName)
//        print(levelCat)
        
        let material = SCNMaterial()
        //        material.diffuse.contents = UIImage(named: "level1-1.png")
        
        material.diffuse.contents = genTextLayer(levelName, levelCat: levelCat)
        
        // add level box
        let boxGeometry = SCNBox(width: 10, height: 6, length: 2, chamferRadius: 0.4)
        boxGeometry.materials = [material]
        let boxNode = SCNNode(geometry: boxGeometry)
        boxNode.name = levelID
        boxNode.position = SCNVector3(indexNum * 12, 0, 0)
        
        return boxNode
    }
    
    func genTextLayer(textStr: String, levelCat: String) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRectMake(0, 0, 1000, 600)
        
        layer.backgroundColor = UIColor.whiteColor().CGColor
        if (levelCat == "1") {
            layer.backgroundColor = UIColor.yellowColor().CGColor
        }
        
        
        let textLayer = CATextLayer()
//        print(layer.bounds)
        textLayer.frame = CGRectMake(0, -220, layer.bounds.width, layer.bounds.height)
        textLayer.fontSize = 140
        textLayer.font = "Chalkduster"
        textLayer.string = textStr
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.foregroundColor = UIColor.blackColor().CGColor
        textLayer.display()
        layer.addSublayer(textLayer)
        
        return layer
    }
    
    
    func handlePan(gestureRecognize: UIPanGestureRecognizer) {
//        print("Pan!!")
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        let point = gestureRecognize.translationInView(scnView)
        
//        print("\(point.x), \(point.y)")
        
        //// animation
        
//                SCNTransaction.begin()
//                SCNTransaction.setAnimationDuration(0.5)
//        
//                SCNTransaction.setCompletionBlock() {
//                    print("done")
//                }
        
        
        if (lastLocation.x - Float(point.x)/10 <= self.rightPosition) && (lastLocation.x - Float(point.x)/10 >= self.leftPosition)   {
            self.cameraNode.position.x = lastLocation.x - Float(point.x)/10
//        print("Current pos: \(self.cameraNode.position.x)")
    //        self.cameraNode.position.y = lastLocation.y + Float(point.y)/10
            self.lightNode.position.x = lastLocation.x - Float(point.x)/10
    //        self.lightNode.position.y = lastLocation.y + Float(point.y)/10
        }
        else if (lastLocation.x - Float(point.x)/10 > self.rightPosition) {
            self.cameraNode.position.x = self.rightPosition;
            self.lightNode.position.x = self.rightPosition;
        }
        else if (lastLocation.x - Float(point.x)/10 < self.leftPosition) {
            self.cameraNode.position.x = self.leftPosition;
            self.lightNode.position.x = self.leftPosition;
        }
        
        
//        self.cameraNode.eulerAngles.x = lastLocation.x + Float(point.y)/400
//        self.cameraNode.eulerAngles.y = lastLocation.y + Float(point.x)/400
        
        
//                SCNTransaction.commit()
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
//            let results: SCNHitTestResult = hitResults[0]
//            print("\(results)\n")
//            let result = results.node as SCNNode!
            
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
            
//            print("\(result.node!.name)")
            
//            let path = NSBundle.mainBundle().pathForResource("LevelConfig", ofType: "plist")
//            let dict = NSDictionary(contentsOfFile: path!)
//            
//            print(dict)
//            
//            let levelDict = dict?.valueForKey(result.node!.name!)
//            let levelID = levelDict?.valueForKey("levelID")
//            let levelHint = levelDict?.valueForKey("hint")
//            let levelFinal = levelDict?.valueForKey("final")
//            
////            dict?.valueForKeyPath(<#T##keyPath: String##String#>)
//            
//            print(levelID)
//            print(levelHint)
//            print(levelFinal)
            
            
            self.performSegueWithIdentifier("levelsViewToGameViewSegue", sender: result.node!.name!)
            
            // segue.dest
        }
        
        //                self.cameraNode.eulerAngles.x -= 0.1
        //                self.cameraNode.eulerAngles.y += 0.1
        //                self.cameraNode.eulerAngles.z += 0.1
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "levelsViewToGameViewSegue" {
            
            let path = NSBundle.mainBundle().pathForResource("LevelConfig", ofType: "plist")
            let dict = NSDictionary(contentsOfFile: path!)
            
//            print(dict)
            
            let levelDict = dict!.valueForKey(sender as! String)
            
//            print(levelDict)

            let levelHint = levelDict!.valueForKey("hint")
            let levelFinal = levelDict!.valueForKey("final")
            
            //print(name)
            
            print(levelHint)
            print(levelFinal)
            
            let secondVC = segue.destinationViewController as! GameViewController
            
            //print(sender as! String)
            let levelIDNum = Int(sender as! String)!
            secondVC.constellation = YQDataMediator.instance.getConstellationByLevel(levelIDNum)
            
            secondVC.starList = YQDataMediator.instance.getStarByAttr(levelIDNum) as! [Star]
            
            secondVC.hintImageNamed = levelHint as! String
            
            secondVC.finalImageNamed = levelFinal as! String
            
            secondVC.level = sender as! String

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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.lastLocation = self.cameraNode.position
//        lastLocation = self.cameraNode.eulerAngles
    }
}