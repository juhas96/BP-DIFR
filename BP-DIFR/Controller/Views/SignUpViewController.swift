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
import FirebaseDatabase

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
    
    func addUserToDatabase(uid: String) {
        userNetworkservice = UsersNetworkService()
        user =
            [
                "username":             usernameTextField.text!,
                "email":                emailTextField.text!,
                "uid":                  uid
                
        ]
        print("TUSOM \(user)")
        userNetworkservice.createUser(user: user)
    }

    func handleSignUp() {
        // Ak je jedno policko prazdne signUp neprebehne
        guard let email = emailTextField.text, let password = emailTextField.text, let username = usernameTextField.text else {
            print("Form is not valid")
            return
        }
        
        // Vytvorim usera
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.user.uid else {
                return
            }
            
            let values = ["name": username, "email": email]
            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
            
            self.alert(message: "Registration Sucessfull", title: "Congratulation registration successfull")
                self.addUserToDatabase(uid: uid)
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
        }
        
    }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
//
//            let user = ChatUser(dictionary: values)
//
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    // message pre usera
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
