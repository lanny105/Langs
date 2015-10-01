//
//  File.swift
//  Langs
//
//  Created by apple on 9/28/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation



extension String {
    
    var lastPathComponent: String {
        
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        
        get {
            
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        
        get {
            
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        
        get {
            
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        
        get {
            
            return (self as NSString).pathComponents
        }
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathExtension(ext)
    }
}

class YQDataMediator {
    
    
    /*
    class func copyFile(fileName: NSString) {
    
    let (tables, _) = SD.existingTables()
    
    if let _ = tables.indexOf("Starmatrix_1"){
    
    print("Database exists!")
    return
    }
    
    let dbPath: String = getPath(fileName as String)
    print("copyFile fileName=\(fileName) to path=\(dbPath)")
    let fileManager = NSFileManager.defaultManager()
    let fromPath: String? = NSBundle.mainBundle().resourcePath?.stringByAppendingPathComponent(fileName as String)
    if !fileManager.fileExistsAtPath(dbPath) {
    print("dB not found in document directory filemanager will copy this file from this path=\(fromPath) :::TO::: path=\(dbPath)")
    
    
    //fileManager.copyItemAtPath(fromPath!, toPath: dbPath)
    
    
    } else {
    print("DID-NOT copy dB file, file allready exists at path:\(dbPath)")
    }
    
    }
    
    */
    
    
    class func getPath(fileName: String) -> String {
        
        
        return (NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(fileName)
    }
    
    class func copyFile(fileName: NSString) {
        
        
        let (tables, _) = SD.existingTables()
        
        if let _ = tables.indexOf("Starmatic_1"){
            
            print("Database exists!")
            return
        }
        
        
        let dbPath: String = getPath(fileName as String)
        let fileManager = NSFileManager.defaultManager()
        
        
        let fromPath: String? = NSBundle.mainBundle().resourcePath!.stringByAppendingPathComponent(fileName as String)
        
        //fileManager.copyItemAtPath(fromPath!, toPath: dbPath)
        /*
        NSData myData = [NSData dataWithContentsOfURL:FileURL]; /fetch single file
        [myData writeToFile:targetPath atomically:YES];
        */
        
        var error : NSError?
        do {
            
            try fileManager.removeItemAtPath(dbPath)
            try fileManager.copyItemAtPath(fromPath!, toPath: dbPath)
        } catch let error1 as NSError {
            error = error1
            
            print("完了！")
            print(error)
        }
        
        print("\(fromPath)")
        print("\(dbPath)")
        
        
    }
    
    
    
    
    
    
    
    
    class func getStarByAttr() -> [Star]{
        
        
        var Starlist: [Star] = []
        let (resultSet, err) = SD.executeQuery("SELECT * FROM Starmatic_1 WHERE ID<10000")
        
        if err != nil {
            //there was an error during the query, handle it here
        } else {
            
            
            for row in resultSet {
                
                let temp_star = Star()
                
                if let ID = row["ID"]?.asInt() {
                    //println("The Star name is: \(ID)")
                    temp_star.setID(ID)
                }
                
                if let Hip = row["Hip"]?.asInt() {
                    //println("The Star Hip is: \(Hip)")
                    temp_star.setHip(Hip)
                    
                    
                }
                if let Bf = row["Bf"]?.asString() {
                    //println("The Star Bf is \(Bf)")
                    temp_star.setBf(Bf)
                    
                }
                
                if let Proper = row["Proper"]?.asString() {
                    //println("The Star Proper is \(Proper)")
                    
                    temp_star.setProper(Proper)
                }
                
                if let Ra = row["Ra"]?.asDouble() {
                    //println("The Star Ra is \(Ra)")
                    temp_star.setRa(Ra)
                    
                }
                
                
                
                
                if let Dec = row["Dec"]?.asDouble() {
                    //println("The Star Dec is \(Dec)")
                    
                    temp_star.setDec(Dec)
                }
                if let Dist = row["Dist"]?.asDouble() {
                    //println("The Star Dist is \(Dist)")
                    
                    temp_star.setDist(Dist)
                }
                
                if let Mag = row["Mag"]?.asDouble() {
                    //println("The Star Mag is \(Mag)")
                    temp_star.setMag(Mag)
                    
                }
                if let Absmag = row["Absmag"]?.asDouble() {
                    //println("The Star Absmag is \(Absmag)")
                    temp_star.setAbsmag(Absmag)
                    
                }
                if let Spect = row["Spect"]?.asString() {
                    //println("The Star Spect is \(Spect)")
                    
                    temp_star.setSpect(Spect)
                }
                if let X = row["X"]?.asDouble() {
                    //println("The Star X is \(X)")
                    temp_star.setX(X)
                }
                
                if let Y = row["Y"]?.asDouble() {
                    //println("The Star Y is \(Y)")
                    
                    temp_star.setY(Y)
                    
                }
                if let Z = row["Z"]?.asDouble() {
                    //println("The Star Z is \(Z)")
                    
                    temp_star.setZ(Z)
                    
                }
                
                
                
                if let Bayer = row["Bayer"]?.asString() {
                    //println("The Star Bayer is \(Bayer)")
                    
                    temp_star.setSpect(Bayer)
                }
                if let Flam = row["Flam"]?.asString() {
                    //println("The Star Flam is \(Flam)")
                    
                    temp_star.setSpect(Flam)
                }
                if let Con = row["Con"]?.asString() {
                    //println("The Star Con is \(Con)")
                    
                    temp_star.setSpect(Con)
                }
                
                
                if let Lum = row["Lum"]?.asDouble() {
                    //println("The Star Lum is \(Lum)")
                    
                    temp_star.setZ(Lum)
                    
                }
                
                Starlist.append(temp_star)
                
                
                
                
            }
        }
        //TextView_DisplayAll.text = result
        
        return Starlist
        
    }
    
}
