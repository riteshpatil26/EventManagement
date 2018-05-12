//
//  PhotoAlbumViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 5/11/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
class PhotoAlbumViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,CategorynameDelegate,UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var containerCollectionView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var serviceArray :Array<Doctor> = Array<Doctor>()
    var serviceName :String = String()
    var isSearching :Bool = false
    var noDataLabel :UILabel = UILabel()
    var practiceArray : Array<Doctor> = Array<Doctor>()
    let objeOverlay = LoadingOverlay()
    let reuseIdentifier = "PhotoLibraryCell"
    var doctorArray : Array<Doctor> = Array<Doctor>()
    var selectedIndexpath = -1
    var selectedIndexPathNew :IndexPath = IndexPath()
    
    var keyArray:Array<String>  = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
        
        if isFromAdmin == false{
            
            
        }else{
            var longGesture = UILongPressGestureRecognizer()
            longGesture = UILongPressGestureRecognizer(target: self, action: #selector(CategoryViewController.longPress(_:)))
            longGesture.minimumPressDuration = 1
            
            
            longGesture.minimumPressDuration = 0.5
            longGesture.delaysTouchesBegan = true
            longGesture.delegate = self
            self.collectionView.addGestureRecognizer(longGesture)
            
        }
        
        
        catergorydelegate1 = self
        
        objeOverlay.showOverlay(view: self.collectionView)
        if Network.iSConnectedToNetwork(){
            self.observePosts(string: serviceName)
        }
        else{
            Utils.showToast(message: "No Internet Connection", view: view, image: UIImage(named: errorImageName)!)
        }
        
        // Do any additional setup after loading the view.
    }
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        
        
        
        let p = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            var cell = self.collectionView.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
            
            selectedIndexPathNew = index
            selectedIndexpath = index.row
            self.collectionView.reloadData()
            openActionSheet()
            
            
            
        } else {
            print("Could not find index path")
        }
        
    }
    func getAllKeys(string :String){
        
        
        
        
        Database.database().reference().child("Doctors").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
                
                print(string)
                
                print(globalCategorySring1)
                
                let snap = child as! DataSnapshot
                let key = snap.key
                if string == globalCategorySring1{
                    
                    self.keyArray.append(key)
                    print("----------------")
                    print(self.keyArray)
                    print("----------------")
                    print(self.keyArray.count)
                    
                }
                
            }
        }
        
        
    }
    
    func openActionSheet(){
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
            
            
            //            let storage = Storage.storage()
            //            let url = self.serviceArray[self.selectedIndexpath].photoURL
            //            let storageRef = storage.reference(forURL: url!)
            //
            //            //Removes image from storage
            //            storageRef.delete { error in
            //                if let error = error {
            //
            //
            //                    print(error)
            //                } else {
            //                    // File deleted successfully
            //                    print("deleted succesfully")
            //                    print("suceess")
            //
            //
            //
            //                }
            //            }
            //
            
            
            
            
            //print(self.selectedIndexpath)
            
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                
                
                
                
                
                
                
                Database.database().reference().child("Doctors").child(self.keyArray[self.selectedIndexpath]).removeValue()
                
                
                
                
                self.serviceArray.remove(at: self.selectedIndexpath)
                self.collectionView.deleteItems(at: [self.selectedIndexPathNew])
                self.selectedIndexpath = -1
                self.collectionView.reloadData()
            })
            
            
            
        })
        
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
            self.selectedIndexpath = -1
            self.collectionView.reloadData()
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func observePosts(string : String) {
        
        
        let postsRef = Database.database().reference().child("Doctors")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Doctor]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["service"] as? [String:Any],
                    
                    
                    
                    let text = dict["doctorName"] as? String,
                    
                    let photourl = dict["photoURL"] as? String
                {
                    
                    let service = author["serviceName"] as? String!
                    print(author["serviceName"] as? String!)
                    print(text)
                    
                    
                    
                    var userProfile = Services(author:service!, photoUrl: "")
                    
                    
                    
                    let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress:"werwer", doctorPhoneNumber: "ffdsfsd", service: userProfile, doctorRating: "fsdf", doctorDescription: "sdfgds", photoUrl: photourl)
                  
                    
                   
                    if isFromAdmin == true{
                       
                        let snap = child as! DataSnapshot
                        let key = snap.key
                        if userProfile.serviceName == globalCategorySring1{
                            
                            self.keyArray.append(key)
                            print("----------------")
                            print(self.keyArray)
                            print("----------------")
                            print(self.keyArray.count)
                            
                        }
                        //self.getAllKeys(string: userProfile.serviceName)
                    }
                    if userProfile.serviceName == globalCategorySring1{
                        tempPosts.append(post)
                    }
                    
                    
                }
            }
            
            self.serviceArray = tempPosts
            print(self.serviceArray)
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            
            
            self.collectionView.alpha = 1
            //objeOverlay.showOverlay(view: self.tableView)
            self.objeOverlay.hideOverlayView()
            // self.animateTable()
            
        })
        
    }
    
    func sendCategoryName(string: String) {
        serviceName = string
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        noDataLabel.frame = CGRect(x: 0, y: 0, width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height)
        
        noDataLabel.text = "No Records Found."
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 2
   
        noDataLabel.alpha = 0.0
        
        self.title = "Categories"
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-------#MARK:CollectionView Delegate Methods-------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return serviceArray.count;
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        
        cell.activityIndicatorView.startAnimating()
        cell.libraryImageView.contentMode = .scaleAspectFill
        cell.libraryImageView.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        
        
        if let checkedUrl = URL(string: serviceArray[indexPath.row].photoURL) {
            
            ImageService.getImage(withURL: checkedUrl) { image in
                cell.libraryImageView.image = image
                
                cell.activityIndicatorView.stopAnimating()
                cell.activityIndicatorView.hidesWhenStopped = true
            }
        }
        
        if isFromAdmin == true{
            
            
            if indexPath.row == selectedIndexpath{
                
                cell.ovelerayView.alpha = 0.45
            }else{
                
                cell.ovelerayView.alpha = 0
            }
            
        }else{
            
            cell.ovelerayView.alpha = 0
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView
        {
            let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! PhotoCollectionViewCell
            
//            let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
//            var profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "DoctorViewController")
//            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        print(self.view.frame)
        
        let length : CGFloat = (self.containerCollectionView.frame.width / 3)
        let lenght2 :CGFloat = ((self.containerCollectionView.frame.height - 64) / 3)
        
        
        print(length)
        print(lenght2)
        return CGSize(width: length, height: length)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _ = cell as! PhotoCollectionViewCell
    }
    
    
    
}
