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
    init() {
        getData()
        getTrainingPlan()
    }
    func fetchTrainingDays() {
        
        trainingDays.append(users[index].lastWorkoutTime)
        trainingPlan[0].recovery = "2"
        for i in 1...trainingPlan.count-1 {
           
            let lastTrainingDay = trainingDays.last as Date?
            let timeInterval = TimeInterval().advanced(by: (Double(trainingPlan[i-1].recovery)!+1)*86400)
            trainingDays.append((lastTrainingDay?.addingTimeInterval(timeInterval))!)
        }
       
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
        db.collection("Users").addDocument(data: ["Username":athlete.Username,"Email":athlete.Email,"Password":athlete.Password,"Height":athlete.Height,"Weight":athlete.Weight,"Cyclist":athlete.Cyclist,"Runner":athlete.Runner,"Last Workout":athlete.lastWorkoutIndex,"Last Workout Date":athlete.lastWorkoutTime]) { error in
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
                        if d["Last Workout Date"] != nil {
                      
                            date = NSDate(timeIntervalSince1970: TimeInterval((d["Last Workout Date"] as!  Timestamp).seconds)) as Date
                           
                        }
                        return Athlete(id: d.documentID, Username: d["Username"] as?String ?? "",Email: d["Email"] as? String ?? "", Password: d["Password"] as?String ?? "", Height: d["Height"] as?String ?? "", Weight: d["Weight"] as?String ?? "", Cyclist: d["Cyclist"] as?Bool ?? false, Runner: d["Runner"] as?Bool ?? false,lastWorkoutIndex: d["Last Workout"] as?Int ?? 0, lastWorkoutTime:date)
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
    
}
