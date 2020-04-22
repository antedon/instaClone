//
//  FeedViewController.swift
//  instaCloneApp
//
//  Created by Yaşar Bayındır on 21.04.2020.
//  Copyright © 2020 Yaşar Bayındır. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var userEmailArray = [String]()
    var userCommendArray = [String]()
    var UserImageArray = [String]()
    var LikeArray = [Int]()
     
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirebase()
        
    }
    
    
    func getDataFromFirebase() {
        let fireStoreDatabase = Firestore.firestore()
       /* let settings = fireStoreDatabase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        */
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error!.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.userCommendArray.removeAll(keepingCapacity: false)
                    self.UserImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.LikeArray.removeAll(keepingCapacity: false)
                    
                    
                    
                    for document in snapshot!.documents{
                        
                      
                        if let postedBy = document.get("postedBy")as? String{
                            self.userEmailArray.append(postedBy)
                            
                        }
                        if let postCommend = document.get("postComment") as? String{
                            self .userCommendArray.append(postCommend)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.LikeArray.append(likes)
                        }
                        if let ImageUrl = document.get("imageUrl") as? String{
                            self.UserImageArray.append(ImageUrl)
                        }
                         
                            
                        
                    }
                    self.tableView.reloadData()
                }
                
                
            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommendArray[indexPath.row]
        cell.likeLabel.text = String(LikeArray[indexPath.row])
        
        cell.userImageView.sd_setImage(with: URL(string: self.UserImageArray[indexPath.row]))
        return cell
    }
    
}
