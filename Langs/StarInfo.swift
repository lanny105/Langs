//
//  StarInfo.swift
//  swiftdata_test
//
//  Created by apple on 9/20/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation


class Star {
    var ID:Int
    var Hip: Int
    var Bf: String
    var Proper: String
    var Ra: Double
    var Dec: Double
    var Dist: Double
    var Mag: Double
    var Absmag: Double
    var Spect: String
    var X: Double
    var Y: Double
    var Z: Double
    var Bayer: String
    var Flam: String
    var Con:String
    var Lum: Double
    
    
    func setID(ID: Int){
        self.ID = ID
    }
    
    func setHip(Hip: Int){
        self.Hip = Hip
    }
    
    func setBf(Bf: String){
        self.Bf = Bf
    }
    
    func setProper(Proper: String){
        self.Proper = Proper
    }
    
    func setRa(Ra: Double){
        self.Ra = Ra
    }
    
    func setDec(Dec: Double){
        self.Dec = Dec
    }
    
    func setDist(Dist: Double){
        self.Dist = Dist
    }
    
    func setMag(Mag: Double){
        self.Mag = Mag
    }
    
    func setAbsmag(Absmag: Double){
        self.Absmag = Absmag
    }
    
    func setSpect(Spect: String){
        self.Spect = Spect
    }
    
    func setX(X: Double){
        self.X = X
    }
    
    func setY(Y: Double){
        self.Y = Y
    }
    
    func setZ(Z: Double){
        self.Z = Z
    }
    
    func setBayer(Bayer: String){
        self.Bayer = Bayer
    }
    
    func setFlam(Flam: String){
        self.Flam = Flam
    }
    
    func setCon(Con: String){
        self.Con = Con
    }
    
    func setLum(Lum: Double){
        self.Lum = Lum
    }

    
    init(){
        ID = -1
        Hip = -1
        Bf = ""
        Proper = ""
        Ra = -1
        Dec = -1
        Dist = -1
        Mag = -1
        Absmag = -1
        Spect = ""
        X = -1
        Y = -1
        Z = -1
        Bayer = ""
        Flam = ""
        Con = ""
        Lum = -1
    }
    
    
    
    func setAttri(ID: Int, Hip: Int, Bf: String, Proper: String, Ra: Double,
        Dec: Double, Dist: Double, Mag: Double, Absmag: Double, Spect: String,
        X: Double, Y: Double, Z: Double, Bayer: String, Flam: String, Con: String,
        Lum: Double) {
            self.ID = ID
            self.Hip = Hip
            self.Bf = Bf
            self.Proper = Proper
            self.Ra = Ra
            self.Dec = Dec
            self.Dist = Dist
            self.Mag = Mag
            self.Absmag = Absmag
            self.Spect = Spect
            self.X = X
            self.Y = Y
            self.Z = Z
            
            self.Bayer = Bayer
            self.Flam = Flam
            self.Con = Con
            self.Lum = Lum

    }
    
    
    
    func returnAttri() -> String{
        
        var result = String()
        
        
        result += "ID: \(self.ID)\n"
        result += "Hip: \(self.Hip)\n"
        result += "Bf: \(self.Bf)\n"
        result += "Proper: \(self.Proper)\n"
        result += "Ra: \(self.Ra)\n"
        result += "Dec: \(self.Dec)\n"
        result += "Dist: \(self.Dist)\n"
        result += "Mag: \(self.Mag)\n"
        result += "Absmag: \(self.Absmag)\n"
        result += "Spect: \(self.Spect)\n"
        result += "X: \(self.X)\n"
        result += "Y: \(self.Y)\n"
        result += "Z: \(self.Z)\n"
        result += "Bayer: \(self.Bayer)\n"
        result += "Flam: \(self.Flam)\n"
        result += "Con: \(self.Con)\n"
        result += "Lum: \(self.Lum)\n"
        
        
        return result
        
    }
    
    
    
    
    //public static func Coordinate_Transform()
    
    
    
    
}