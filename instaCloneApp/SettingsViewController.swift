//
//  SettingsViewController.swift
//  instaCloneApp
//
//  Created by Yaşar Bayındır on 21.04.2020.
//  Copyright © 2020 Yaşar Bayındır. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            
            print("error")
            
        }
        
    }
     
    }

 
