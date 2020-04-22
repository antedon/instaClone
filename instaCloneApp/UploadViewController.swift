//
//  UploadViewController.swift
//  instaCloneApp
//
//  Created by Yaşar Bayındır on 21.04.2020.
//  Copyright © 2020 Yaşar Bayındır. All rights reserved.
//

import UIKit
import Firebase
 

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        imageView.addGestureRecognizer(gestureRecogniser)
        
        let keyboarGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard ))
        view.addGestureRecognizer(keyboarGestureRecogniser)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    

    func alert(titleInput:String,messageInput:String)  {
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        
        
        
        
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let  data = imageView.image?.jpegData(compressionQuality: 0.1){
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metadata,error) in
                if error != nil{
                    self.alert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil{
                            let imageUrl = url?.absoluteString

                            
                            //database
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference
                            let firestorePost = ["imageUrl" : imageUrl!,"postedBy" : Auth.auth().currentUser!.email!,"postComment": self.commentText.text!,"date" :FieldValue.serverTimestamp(), "likes":0] as [String:Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                
                                if error != nil{
                                    self.alert(titleInput: "error", messageInput:error?.localizedDescription ?? "error")
                                    
                                }else{
                                    self.imageView.image = UIImage(named: "imageSelect.jpg")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                
                            })
                            
                            
                            
                        }
                    }
                }
            }
            
        }
    }
    
    
    @objc func choseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }

}
