//
//  ProfileHelper.swift
//  BP-DIFR
//
//  Created by jkbjhs on 12/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Firebase

class ProfileHelper {
    
    var users = [AppUser]()
    var usersNetworkService: UsersNetworkService!
    var user: AppUser! = nil
    
    func fetchUsers(completion: @escaping (_ user: AppUser) -> ()){
        usersNetworkService = UsersNetworkService()
        usersNetworkService.getAllUsers { (users) in
            DispatchQueue.main.async {
                if let users = users {
                    self.users = users
                    self.user = self.findUserInDatabase(users: self.users)
                    completion(self.user)
                }
            }
        }
    }
    
    func findUserInDatabase(users: [AppUser]) -> AppUser {
        if Auth.auth().currentUser != nil {
            if(users.count != 0){
                let appUser: [AppUser] = users.filter {$0.uid == Auth.auth().currentUser?.uid as! String}
                return AppUser(id: appUser[0].id!, username: appUser[0].username ?? "", email: appUser[0].email, uid: appUser[0].uid)
            }
        } else {
            print("Current user is nil")
        }
        
        
        
        return AppUser(id: 999, username: "", email: "", uid: "")
    }
}
