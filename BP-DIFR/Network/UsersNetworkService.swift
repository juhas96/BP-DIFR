//
//  UsersNetworkService.swift
//  BP-DIFR
//
//  Created by jkbjhs on 12/04/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import Foundation
import Alamofire

class UsersNetworkService {
    
    func getAllUsers(completion: @escaping ([AppUser]?) -> Void) {
        guard let url = URL(string: "https://difr.herokuapp.com/users") else { return }
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let req = try JSONDecoder().decode([AppUser].self, from: data)
                completion(req)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    func createUser(user: Parameters) {
        guard let userURL = URL(string: "https://difr.herokuapp.com/users") else { return }
        Alamofire.request(userURL, method: .post, parameters: user, encoding: JSONEncoding.default).validate().response { (response) in
            print(response)
        }
    }
}
