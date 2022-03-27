//
//  appStorage.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 27.03.2022.
//

import SwiftUI

struct appStorageUtility {
    @AppStorage("username") var username: String = ""
    @AppStorage("password") var password: String = ""
    @AppStorage("email")    var email:String = ""
    @AppStorage("height")   var height:String = ""
    @AppStorage("weight")   var weight:String = ""
    @AppStorage("cyclist")  var isCyclist:String = ""
    @AppStorage("runner")  var isRunner:String = ""
}
