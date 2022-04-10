//
//  ViewModel.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 02.04.2022.
//

import Foundation
import Firebase
import SwiftUI
class ViewModel : ObservableObject {
    @AppStorage("currentUserIndex") var index:Int = -1
    @Published var users = [Athlete]()
    @Published var trainingPlans = [[Session]]()
    @Published var trainingPlan = [Session]()
    @Published var restDays = [Date]()
    @Published var trainingDays = [Date]()
    @Published var trainingIndex :Int = -1
 
    init() {
        getData()
        getTrainingPlan()
       
    }
    func refresh(){
        getData()
        getTrainingPlan()
    }
    func fetchTrainingDays() {
        
        trainingDays.append(users[index].startDate)
        trainingPlan[0].recovery = "2"
        for i in 1...trainingPlan.count-1 {
           
            let lastTrainingDay = trainingDays.last as Date?
            let timeInterval = TimeInterval().advanced(by: (Double(trainingPlan[i-1].recovery)!+1)*86400)
            trainingDays.append((lastTrainingDay?.addingTimeInterval(timeInterval))!)
        }
       
    }
    func isTrainingDay()->Bool {
        var today = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let thisMonth = dateFormatter.string(from:today)
        dateFormatter.dateFormat = "E"
        let thisDay = dateFormatter.string(from: today)
        dateFormatter.dateFormat = "dd"
        let thisDayOfMonth = dateFormatter.string(from: today)
        for i in 0...trainingDays.count-1{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM"
            let  month = dateFormatter.string(from: trainingDays[i])
            dateFormatter.dateFormat = "E"
          let   day = dateFormatter.string(from: trainingDays[i])
            dateFormatter.dateFormat = "dd"
           let dayOfMonth = dateFormatter.string(from: trainingDays[i])
            if(thisMonth == month && thisDay == day && thisDayOfMonth == dayOfMonth){
                trainingIndex = i
                return true
            }
        }
        
        
        return false
    }
    func userExits(username:String)->Bool{
        for i in users {
            if username == i.Username {
                return true
            }
        }
        return false
    }
    func emailAlreadyUsed(email:String)->Bool{
        for i in users {
            if email == i.Email{
                return true
            }
        }
        return false
    }
    
    func addData(athlete:Athlete){
        let db = Firestore.firestore()
            db.collection("Users").addDocument(data: ["Username":athlete.Username,"Email":athlete.Email,"Password":athlete.Password,"Height":athlete.Height,"Weight":athlete.Weight,"Cyclist":athlete.Cyclist,"Runner":athlete.Runner,"Last Workout":athlete.lastWorkoutIndex,"Last Workout Date":athlete.startDate,"Date of Last Workout":athlete.startDate]){ error in
            if error == nil {
                self.getData()
            }
            else
            {
                
            }
        }
    }
    func getData(){
        let db = Firestore.firestore()
       
        db.collection("Users").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                      
                     self.users =  snapshot.documents.map { d in
                        var date = Date.distantPast
                         var lastDate = Date.distantPast
                        if d["Last Workout Date"] != nil {
                      
                            date = NSDate(timeIntervalSince1970: TimeInterval((d["Last Workout Date"] as!  Timestamp).seconds)) as Date
                           
                        }
                         if d["Date of Last Workout"] != nil {
                       
                             lastDate = NSDate(timeIntervalSince1970: TimeInterval((d["Date of Last Workout"] as!  Timestamp).seconds)) as Date
                            
                         }
                        return Athlete(id: d.documentID, Username: d["Username"] as?String ?? "",Email: d["Email"] as? String ?? "", Password: d["Password"] as?String ?? "", Height: d["Height"] as?String ?? "", Weight: d["Weight"] as?String ?? "", Cyclist: d["Cyclist"] as?Bool ?? false, Runner: d["Runner"] as?Bool ?? false,lastWorkoutIndex: d["Last Workout"] as?Int ?? 0, startDate: date, lastTimeOfTraining:lastDate)
                    }
                        
                    }
                   
                  
                }
                
            }
            else {
                
            }
        
        }
       
       
       

        
    }
    func getTrainingPlan(){
        let db = Firestore.firestore()
        db.collection("Training plans").getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                      
                        self.trainingPlans = snapshot.documents.map { d in
                            let m =  d["Sessions"]  as! [[String: Any]]
                            var s = [Session]()
                            for i in m{
                                s.append(Session(description: i["Description"] as?String ?? "" , duration: i["Duration"] as?String ?? "", name: i["name"] as?String ?? "", recovery: i["recovery"] as?String ?? ""))
                                                                                                                                                                            }
                           
                          
                            return s
                        }
                        self.trainingPlan = self.trainingPlans[0]
                        
                        
                   }
                    
                 
                }
            }
        }
    }
    func getUsers()->[Athlete]{
        return users
    }
    func updateLastWorkout(){
        
        let db = Firestore.firestore()
        let name = users[index].Username
        db.collection("Users")
            .whereField("Username", isEqualTo: name)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    // Some error occured
                } else if querySnapshot!.documents.count != 1 {
                    // Perhaps this is an error for you?
                } else {
                    let document = querySnapshot!.documents.first
                    document!.reference.updateData([
                        "Last Workout": self.users[self.index].lastWorkoutIndex+1,
                        "Date of Last Workout": Date.now
                    ])
                  
                }
            }
        
    }
    func trainingSessionAlreadyDone()->Bool{
        let today = users[index].lastTimeOfTraining
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let thisMonth = dateFormatter.string(from:today)
        dateFormatter.dateFormat = "E"
        let thisDay = dateFormatter.string(from: today)
        dateFormatter.dateFormat = "dd"
        let thisDayOfMonth = dateFormatter.string(from: today)
        dateFormatter.dateFormat = "MMMM"
        let  month = dateFormatter.string(from: trainingDays[trainingIndex])
        dateFormatter.dateFormat = "E"
      let   day = dateFormatter.string(from: trainingDays[trainingIndex])
        dateFormatter.dateFormat = "dd"
       let dayOfMonth = dateFormatter.string(from: trainingDays[trainingIndex])
       print(users[index].lastTimeOfTraining)
        if(thisMonth == month && thisDay == day && thisDayOfMonth == dayOfMonth){
            return true
        }
        return false
    }
    
}
