//
//  ViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 18/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseUI


class ViewController: UIViewController {
    
    let backgroundImageView = UIImageView();

    @IBAction func logInButtonTapped(_ sender: UIButton) {
        
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.email as Any)
        }
        
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
//        let providers: [FUIAuthProvider] = [
//            EmailAuthProvider
//        ]
//        authUI?.providers = providers
        
        let authViewController = authUI!.authViewController()
        present(authViewController,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
    }
   
    /**
     Nasetujem pozadie na celu plochu
     */
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Background")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

    }


}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else { return }
        
        performSegue(withIdentifier: "toHomeScreen", sender: self)
    }
}

