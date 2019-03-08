//
//  LogInViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 23/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Parse


class LogInViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        handleSignIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func handleSignIn() {
        
        PFUser.logInWithUsername(inBackground: usernameTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil && error == nil {
//                self.alert(message: "Log In Successfull", title: "Success")
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            } else {
                self.alert(message: error?.localizedDescription as! NSString, title: "Error")
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
