//
//  CategoryViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 5/11/18.
//  Copyright © 2018 Ritesh Patil. All rights reserved.
//

import UIKit
import Firebase


protocol CategorynameDelegate {
    func sendCategoryName(string : String)
}
var catergorydelegate1 :CategorynameDelegate!
var globalCategorySring1 :String = String()

class CategoryViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {

    @IBOutlet weak var containerCollectionView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuseIdentifier = "LibraryCell"
    var serviceArray :Array<Services> = Array<Services>()
    var isSearching :Bool = false
    var noDataLabel :UILabel = UILabel()
    var practiceArray : Array<Services> = Array<Services>()
    let objeOverlay = LoadingOverlay()
    var doctorArray : Array<Doctor> = Array<Doctor>()
    var selectedIndexpath = -1
    var selectedIndexPathNew :IndexPath = IndexPath()
    
    var keyArray:Array<String>  = Array<String>()
    
    @IBOutlet weak var deleteOverlay: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isFromAdmin == false{
        addSlideMenuButton()
            
            
        }else{
            
            var longGesture = UILongPressGestureRecognizer()
            longGesture = UILongPressGestureRecognizer(target: self, action: #selector(CategoryViewController.longPress(_:)))
            longGesture.minimumPressDuration = 1
           
           
            longGesture.minimumPressDuration = 0.5
            longGesture.delaysTouchesBegan = true
            longGesture.delegate = self
            self.collectionView.addGestureRecognizer(longGesture)
            
            let newBackButton = UIBarButtonItem(image: UIImage(named: "back"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.backButtonClick(sender:)))
           
            self.navigationItem.rightBarButtonItem = newBackButton
            
              self.getAllKeys()
        }
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
        
        objeOverlay.showOverlay(view: self.collectionView)
        if Network.iSConnectedToNetwork(){
            self.observePosts()
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
    func getAllKeys(){
       
        
        
        
        Database.database().reference().child("services").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children{
               
                
                let snap = child as! DataSnapshot
                let key = snap.key
                self.keyArray.append(key)
                  print("----------------")
                print(self.keyArray)
                print("----------------")
                print(self.keyArray.count)
                
            }
        }
        
        
    }

    func openActionSheet(){
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("File Deleted")
          
            
            let storage = Storage.storage()
            let url = self.serviceArray[self.selectedIndexpath].photoURL
            let storageRef = storage.reference(forURL: url!)

            //Removes image from storage
            storageRef.delete { error in
                if let error = error {


                    print(error)
                } else {
                    // File deleted successfully
                    print("deleted succesfully")
                    print("suceess")



                }
            }
            
          

         
            
            //print(self.selectedIndexpath)
            print(self.keyArray[self.selectedIndexpath])
            let when = DispatchTime.now() + 1
            
            DispatchQueue.main.asyncAfter(deadline: when, execute: {


                print(self.keyArray[self.selectedIndexpath])
                
                
                
                
                Database.database().reference().child("services").child(self.keyArray[self.selectedIndexpath]).removeValue()
                
             
                
               
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
    
    @objc func backButtonClick(sender: UIBarButtonItem) {
        
    }
    func observePosts() {
        
        // on "services put"
        let postsRef = Database.database().reference().child("services")
        var tempPosts = [Services]()
        
        postsRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let text = dict["serviceName"] as? String,let photourl = dict["photoURL"] as? String
                {
                    
                    print(text)
                    
                    let post = Services(author: text, photoUrl:photourl)
                    tempPosts.append(post)
                }
            }
            
            self.serviceArray = tempPosts
            
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.alpha = 1
            //objeOverlay.showOverlay(view: self.tableView)
            self.objeOverlay.hideOverlayView()
            
        })
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
        
        
        return serviceArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        
        cell.labelCollectionView.text = serviceArray[indexPath.row].serviceName
        cell.libraryImage.contentMode = .scaleAspectFill
        cell.libraryImage.clipsToBounds = true
        collectionView.backgroundColor = UIColor.clear
        

        print(serviceArray[indexPath.row].photoURL)
        if let checkedUrl = URL(string: serviceArray[indexPath.row].photoURL) {
             cell.activityIndicator.startAnimating()
            ImageService.getImage(withURL: checkedUrl) { image in
                cell.libraryImage.image = image
                
                cell.activityIndicator.stopAnimating()
                cell.activityIndicator.hidesWhenStopped = true
            }
        }
        if isFromAdmin == true{
            
           
            if indexPath.row == selectedIndexpath{
                
                cell.deleteOveleya.alpha = 0.45
            }else{
                
                cell.deleteOveleya.alpha = 0
            }
            
        }else{
            
            cell.deleteOveleya.alpha = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView
        {
           let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! CategoryCollectionViewCell
          
                globalCategorySring1 = serviceArray[indexPath.row].serviceName
                
        
            let profileIdStoruboard  = UIStoryboard(name: "Category", bundle: nil)
            var profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "PhotoAlbumViewController")
            
            
            catergorydelegate1?.sendCategoryName(string: globalCategorySring1)
            
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
        
        
    }
   
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        print(self.view.frame)
        
        let length : CGFloat = (self.containerCollectionView.frame.width / 2)
        let lenght2 :CGFloat = ((self.containerCollectionView.frame.height - 64) / 3)
        
        
        print(length)
        print(lenght2)
        return CGSize(width: length, height: lenght2)
    }
    
  
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _ = cell as! CategoryCollectionViewCell
    }

   

}
