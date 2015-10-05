


//
//  StarInfo.swift
//  swiftdata_test
//
//  Created by apple on 9/20/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation



class Star {
    var id:Int
    var hip: Int
    var hd: Int
    var bf: String
    var proper: String
    var ra: Double
    var dec: Double
    var dist: Double
    var mag: Double
    var absmag: Double
    var spect: String
    var x: Double
    var y: Double
    var z: Double
    var bayer: String
    var flam: String
    var con:String
    var lum: Double
    var guanka: Int
    var conid: Int
    
    /*
    func setid(id: Int){
    self.ID = ID
    }
    
    func setHip(Hip: Int){
    self.Hip = Hip
    }
    
    func setHd(Hd: Int){
    self.Hd = Hd
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
    
    func setguanka(guanka: Int){
    self.guanka = guanka
    }
    
    func setconName(conName: String){
    self.conName = conName
    }
    
    func setAnswer(Answer: Int){
    self.Answer = Answer
    }
    
    */
    init(){
        id = -1
        hip = -1
        hd = -1
        bf = ""
        proper = ""
        ra = -1
        dec = -1
        dist = -1
        mag = -1
        absmag = -1
        spect = ""
        x = -1
        y = -1
        z = -1
        bayer = ""
        flam = ""
        con = ""
        lum = -1
        guanka = -1
        conid = -1
    }
    
    
    /*
    func setAttri(id: Int, hip: Int, hd: Int, bf: String, proper: String, ra: Double,
    dec: Double, dist: Double, mag: Double, absmag: double, spect: String,
    x: Double, y: Double, Z: Double, Bayer: String, Flam: String, Con: String,
    Lum: Double, guanka: Int, conName: String, Answer: Int) {
    self.ID = ID
    self.Hip = Hip
    self.Hd = Hd
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
    self.guanka = guanka
    self.conName = conName
    self.Answer = Answer
    
    }
    
    
    */
    
    
    func isequal(starB: Star) -> Bool{
        
        return self.hd == starB.hd
        
    }
    
    
    
    func returnAttri() -> String{
        
        var result = String()
        
        
        //result += "ID: \(self.id)\n"
        //result += "Hip: \(self.hip)\n"
        result += "Hd: \(self.hd)\n"
        //result += "Bf: \(self.bf)\n"
        //result += "Proper: \(self.proper)\n"
        //result += "Ra: \(self.ra)\n"
        //result += "Dec: \(self.dec)\n"
        //result += "Dist: \(self.dist)\n"
        //result += "Mag: \(self.mag)\n"
        //result += "Absmag: \(self.absmag)\n"
        //result += "Spect: \(self.spect)\n"
        result += "X: \(self.x)\n"
        result += "Y: \(self.y)\n"
        result += "Z: \(self.z)\n"
        //result += "Bayer: \(self.bayer)\n"
        //result += "Flam: \(self.flam)\n"
        //result += "Con: \(self.con)\n"
        //result += "Lum: \(self.lum)\n"
        //result += "guanka:\(self.guanka)\n"
        result += "conid:\(self.conid)\n"
        
        
        
        return result
        
    }
    
    
    
    
    
    
    
    //public static func Coordinate_Transform()
    
    
    
    
}





