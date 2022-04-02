//
//  ViewModel.swift
//  TrainingPlans
//
//  Created by Andrei Mirica on 02.04.2022.
//

import Foundation
import Firebase
class ViewModel : ObservableObject {
    @Published var users = [Athlete]()
    
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
        db.collection("Users").addDocument(data: ["Username":athlete.Username,"Email":athlete.Email,"Password":athlete.Password,"Height":athlete.Height,"Weight":athlete.Weight,"Cyclist":athlete.Cyclist,"Runner":athlete.Runner]) { error in
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
                        
                        return Athlete(id: d.documentID, Username: d["Username"] as?String ?? "",Email: d["Email"] as? String ?? "", Password: d["Password"] as?String ?? "", Height: d["Height"] as?String ?? "", Weight: d["Weight"] as?String ?? "", Cyclist: d["Cyclist"] as?Bool ?? false, Runner: d["Runner"] as?Bool ?? false)
                    }
                        print(self.users)
                    }
                   
                  
                }
                
            }
            else {
                
            }
        }
        
    }
    func getUsers()->[Athlete]{
        return users
    }
    
}
