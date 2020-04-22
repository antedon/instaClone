//
//  ViewController.swift
//  instaCloneApp
//
//  Created by Yaşar Bayındır on 20.04.2020.
//  Copyright © 2020 Yaşar Bayındır. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecogniser)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            
            Auth.auth().signIn(withEmail: emailText.text!, password:  passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "Error")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "error", messageInput: "Email And Pasword Required")
        }
        
        
         
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else{
            makeAlert(titleInput: "error", messageInput: "email And Pasword required")
        }
        
    }
    
    func makeAlert(titleInput:String,messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

