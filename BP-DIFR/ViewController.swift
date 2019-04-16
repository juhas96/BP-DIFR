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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser)
        } else {
            print("current user is nil")
        }
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

