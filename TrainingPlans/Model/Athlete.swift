//
//  Athlete.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import Foundation
class Athlete:ObservableObject {
    var username:String
    var password:String
    var height : String
    var weight :String
    var isCyclist:Bool
    var isRunner:Bool
    init(username:String,password:String,height : String,weight :String,isCyclist:Bool,isRunner:Bool){
        self.username = username
        self.password = password
        self.height = height
        self.weight = weight
        self.isRunner = isRunner
        self.isCyclist = isCyclist
    }
    
    
}
