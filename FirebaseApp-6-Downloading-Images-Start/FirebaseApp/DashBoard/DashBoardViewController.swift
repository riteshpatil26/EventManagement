//
//  DashBoardViewController.swift
//  DoctorHunt
//
//  Created by Ritesh Narayan Patil on 4/16/18.
//  Copyright © 2018 Ritesh Narayan Patil. All rights reserved.
//

import UIKit
import Firebase
protocol ServiceNameDelegate {
    func sendServiceName(string : String)
}
var serviecdelegate :ServiceNameDelegate!

var globalServiceSring :String = String()
class DashBoardViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate,UINavigationControllerDelegate {
    

    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
     var serviceArray :Array<Services> = Array<Services>()
    
    var isSearching :Bool = false
    var noDataLabel :UILabel = UILabel()
    var practiceArray : Array<Services> = Array<Services>()
     let objeOverlay = LoadingOverlay()
    
    var doctorArray : Array<Doctor> = Array<Doctor>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSlideMenuButton()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
      
        objeOverlay.showOverlay(view: self.tableView)
        if Network.iSConnectedToNetwork(){
          self.observePosts()
        }
        else{
             Utils.showToast(message: "No Internet Connection", view: view, image: UIImage(named: errorImageName)!)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        var nipName=UINib(nibName:"Practice", bundle:nil)
        self.tableView.register(nipName, forCellReuseIdentifier:"praticeCell")
        
        noDataLabel.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height)
        
        noDataLabel.text = "No Records Found."
        noDataLabel.textColor = UIColor.black
        noDataLabel.textAlignment = .center
        noDataLabel.numberOfLines = 2
        self.tableView.backgroundView = noDataLabel
        self.tableView.separatorStyle = .none
        noDataLabel.alpha = 0.0
       // tableView.reloadData()
        
       // animateTable()
        self.searchbar.delegate = self
        self.title = "Practices"
        
        
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateTable() {
        
        tableView.alpha = 0.6
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        
        self.tableView.layoutIfNeeded()
        var tableHeight: CGFloat = tableView.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 1.8, delay:  0.050 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: { (Bool) in
                
            })
            index += 1
        }
        
        objeOverlay.hideOverlayView()
        
    }
    func observePosts() {
        
        // on "services put"
        let postsRef = Database.database().reference().child("services")
        var tempPosts = [Services]()
        
        postsRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let text = dict["serviceName"] as? String{
                    
                    print(text)
                    
                    let post = Services(author: text, photoUrl: "")
                    tempPosts.append(post)
                }
            }
            
            self.serviceArray = tempPosts
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            
            self.tableView.alpha = 1
            //objeOverlay.showOverlay(view: self.tableView)
            self.objeOverlay.hideOverlayView()
            self.animateTable()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if serviceArray.count == 0{
            
            noDataLabel.alpha = 1
            return 0
        }else{
            if isSearching == false{
             noDataLabel.alpha = 0
            return serviceArray.count
            }else{
                noDataLabel.alpha = 0
                return practiceArray.count
            }
        }
        
       // return ;
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell:PracticeTableViewCell = self.tableView.dequeueReusableCell(withIdentifier:"praticeCell",
                                                                            for: indexPath) as! PracticeTableViewCell
        
        cell.selectionStyle = .none
        cell.image1.image = cell.image1.image!.withRenderingMode(.alwaysTemplate)
          //  profileImage.image = profileImage.image!.withRenderingMode(.alwaysTemplate)
        cell.image1.tintColor = UIColor.white
        
        
        if serviceArray.count != 0{
            
            
            if isSearching == true{
                cell.practiceName.text = practiceArray[indexPath.row].serviceName
               
                
                return cell
            }else{
                
                
                
                cell.practiceName.text = serviceArray[indexPath.row].serviceName
                
                return cell
                
            }
          
            
        }
        return cell;
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if tableView == self.tableView
            {
                var curCell=tableView.cellForRow(at: indexPath) as! PracticeTableViewCell
                if isSearching == true{
                    globalstring = practiceArray[indexPath.row].serviceName
                }else{
                    
                    globalstring = serviceArray[indexPath.row].serviceName
      
                }
         let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
                var profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "DoctorViewController")
                
                
                serviecdelegate?.sendServiceName(string:globalstring)
                
                self.navigationController?.pushViewController(profileVC, animated: true)
            }
            
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var cellHeight:CGFloat = 76
            
            return cellHeight;
            
        }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            
            
            if editingStyle == .delete {
                
            }
        }
    func observePosts(string1 :String) {
        let postsRef = Database.database().reference().child("Doctors")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Doctor]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["service"] as? [String:Any],
                    
                    
                    
                    let text = dict["doctorName"] as? String
                {
                    
                    let service = author["serviceName"] as? String!
                    print(author["serviceName"] as? String!)
                    print(text)
                    
                    
                    
                    var userProfile = Services(author:service!, photoUrl:"")
                    
                    //let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress: "dsfsdf", doctorPhoneNumber: "sdfsd", service: userProfile,rat)
                let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress: "41 Saint Germain Street", doctorPhoneNumber: "9967930731", service: userProfile, doctorRating: "3/5", doctorDescription: "nkfankslf", photoUrl: "sdfsdg.png")
                    
                    
                    if userProfile.serviceName == string1 {
                        tempPosts.append(post)
                    }
                    
                    
                }
            }
            
            self.doctorArray = tempPosts
            
            
        })
    }
  
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
            
            if searchBar.text == nil || searchBar.text == "" {
                isSearching = false
                view.endEditing(true)
                tableView.reloadData()
            }else{
                
                isSearching = true
                
                let ref = Database.database().reference().child("services")
                
                ref.queryOrdered(byChild: "serviceName").queryStarting(atValue: searchText).queryEnding(atValue: searchText+"\u{f8ff}").observe(.value, with: { snapshot in
                    
                    
                    var tempDict = [Services]()
                    
                    for child in snapshot.children {
                        
                        if let childSnapshot = child as? DataSnapshot,
                            
                            let dict = childSnapshot.value as? [String:Any]{
                            
                            let propertyName = dict["serviceName"] as? String
                          
                            let proper_ = //ser(propertyDescription:propertyDescription!,propertyName:propertyName!,propertyFoundOrLost:propertyFoundOrLost!)
                                Services(author: propertyName!, photoUrl: "")
                            
                            tempDict.append(proper_)
                        }
                    }
                    self.practiceArray = tempDict
                    
                    print(self.practiceArray.count)
                    self.tableView.reloadData()
                    
                })
                
                //Search Code
            }
            
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            isSearching = false
        }
        
        
        
}


