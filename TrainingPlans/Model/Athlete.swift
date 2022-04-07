//
//  Athlete.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import Foundation
struct Athlete:Identifiable {
    var id:String
    var Username:String
    var Email:String
    var Password:String
    var Height : String
    var Weight :String
    var Cyclist:Bool
    var Runner:Bool
    var lastWorkoutIndex:Int
    var lastWorkoutTime:Date
    
    
}
