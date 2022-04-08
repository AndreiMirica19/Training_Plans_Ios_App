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
    @Published var users = [Athlete]()
    @Published var trainingPlans = [[Session]]()
    @Published var trainingPlan = [Session]()
    init() {
        getData()
        getTrainingPlan()
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
                        
                        return Athlete(id: d.documentID, Username: d["Username"] as?String ?? "",Email: d["Email"] as? String ?? "", Password: d["Password"] as?String ?? "", Height: d["Height"] as?String ?? "", Weight: d["Weight"] as?String ?? "", Cyclist: d["Cyclist"] as?Bool ?? false, Runner: d["Runner"] as?Bool ?? false,lastWorkoutIndex: d["Last Workout"] as?Int ?? 0, lastWorkoutTime:d["Last Workout Date"] as? Date ?? Date.now)
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
