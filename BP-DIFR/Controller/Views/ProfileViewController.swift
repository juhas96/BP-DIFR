//
//  ProfileViewController.swift
//  BP-DIFR
//
//  Created by jkbjhs on 22/02/2019.
//  Copyright © 2019 jkbjhs. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTabBarIcon: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTabBarIcon.image = StyleKit.imageOf_GlyphsTabBarProfile()
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

}
