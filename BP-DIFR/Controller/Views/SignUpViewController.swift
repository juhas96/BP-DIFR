//
//  SignUpViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire


class SignUpViewController: UIViewController {

    var userNetworkservice: UsersNetworkService!
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        handleSignUp()
    }
    
    var user = Parameters()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func addUserToDatabase() {
        userNetworkservice = UsersNetworkService()
        user =
            [
                "username":             usernameTextField.text!,
                "email":                emailTextField.text!,
                "uid":                  ""
                
        ]
        print("TUSOM \(user)")
        userNetworkservice.createUser(user: user)
    }

    func handleSignUp() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.alert(message: "Registration Sucessfull", title: "Congratulation registration successfull")
                self.addUserToDatabase()
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            }
        }
        
    }
    
    // message pre usera
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
