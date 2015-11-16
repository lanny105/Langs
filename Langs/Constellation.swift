//
//  Constellation.swift
//  Langs
//
//  Created by Chuan Ren on 10/3/15.
//  Copyright © 2015 mg526. All rights reserved.
//

import Foundation
import SceneKit

class Line: NSObject {
    var star1hd: Int = -1
    var star2hd: Int = -1
    
    func isequal(LineB: Line) -> Bool {
        
        return self.star1hd == LineB.star1hd && self.star2hd == LineB.star2hd
    }
    
    
    func adjust(){
        
        if self.star1hd > self.star2hd {
            
            let temp = self.star2hd
            
            self.star2hd = self.star1hd
            
            self.star1hd = temp
            
        }
        
    }
    

    
    
    func returnAttri() -> String{
        
        var result = String()
        
        
        result += "star1hd: \(self.star1hd)\n"
        result += "star2hd: \(self.star2hd)\n"
        
        return result
        
    }
    
}

func starbefore(value1: Star, value2: Star) -> Bool {
    
    
    return value1.hd < value2.hd;
}

func linebefore(value1: Line, value2: Line) -> Bool{
    
    if value1.star1hd < value2.star1hd{
        return true
    }
    
    
    if value1.star1hd == value2.star1hd {
     
        return value1.star2hd < value2.star2hd
    }
    
    return false
    
}


class Constellation: NSObject{
    
    var name: String = ""
    
    var category: Int = 0 //true means western
    
    var story: String = ""
    
    var starlist: [Star] = []
    var linelist: [Line] = []
    
    
    func isequal(constellationB: Constellation) -> Bool{
        /*
        // Sort the array.
        self.starlist.sortInPlace(starbefore)
        // Display sorted array.

        
        
        constellationB.starlist.sortInPlace(starbefore)
        
        if self.starlist.count != constellationB.starlist.count {
            return false
        }
        
        
        for x in 0...self.starlist.count {
            if !self.starlist[x].isequal(constellationB.starlist[x]) {
                return false
            }
        }
        
        */
        
        self.linelist.sortInPlace(linebefore)
        // Display sorted array.
        
        constellationB.linelist.sortInPlace(linebefore)
        
        
        
        if self.linelist.count != constellationB.linelist.count {
            return false
        }
        
        
        for x in 0...self.linelist.count-1 {
            if (self.linelist[x].isequal(constellationB.linelist[x])==false) {
                return false
            }
        }
        
        
    
        return true
    }
    
    
    
    func returnAttri() -> String{
        
        var result = String()
        
        result += "Constellation name: \(self.name)\n"
        
        result += "Constellation category: \(self.category)\n"
        
        result += "Constellation story: \(self.story)\n"
            
        
        
        result += "\(starlist.count) stars\n"
        
        result += "Starinfo:\n"
        
        for x in starlist{
            result += x.returnAttri()
        }
        
        result += "Lineinfo:\n"
        
        for x in linelist{
            result += x.returnAttri()
        }
        
        return result
        
    }
    
    
}
