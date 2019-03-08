//
//  SignUpViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {

    
    @IBAction func registerButtonTapped(_ sender: Any) {
        handleSignUp()
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func handleSignUp() {
        // Defining the user object
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        
        user.signUpInBackground { (result, error) in
            if error == nil && result == true {
//                self.alert(message: "Register Successfull", title: "Success")
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            } else {
                self.alert(message: error?.localizedDescription as! NSString, title: "Error")
            }
        }
        
        // We won't set the email for this example;
        // Just for simplicity
        
        // Signing up using the Parse API
        
    }
    
    // message pre usera
    func alert(message: NSString, title: NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
