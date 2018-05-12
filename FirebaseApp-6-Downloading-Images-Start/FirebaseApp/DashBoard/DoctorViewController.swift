//
//  DoctorViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//
//

import UIKit
import Firebase

var globalDoctorName : String = String()
class DoctorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchBarDelegate,UINavigationControllerDelegate ,ServiceNameDelegate,detailViewDelegate,CategorynameDelegate {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var serviceArray :Array<Doctor> = Array<Doctor>()
    var serviceName :String = String()
    
    var isSearching :Bool = false
    var noDataLabel :UILabel = UILabel()
    var practiceArray : Array<Doctor> = Array<Doctor>()
    let objeOverlay = LoadingOverlay()
    
    
    var expandedIndexPathsArray:NSMutableArray = NSMutableArray()
    var selectedIndexPath :NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false
        
        serviecdelegate = self
        
        objeOverlay.showOverlay(view: self.tableView)
        if Network.iSConnectedToNetwork(){
            self.observePosts(string: serviceName)
        }
        else{
            Utils.showToast(message: "No Internet Connection", view: view, image: UIImage(named: errorImageName)!)
        }
        
    }
    
    func sendCategoryName(string: String) {
        
        print("came Here")
    }
    
    func detailClicked(sender: Int) {
        
           var curCell=tableView.cellForRow(at: IndexPath(row: sender, section: 0)) as! DoctorTableViewCell
        
        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        if isSearching == true{
            globalstring = curCell.detailDescription.text!
        }else{
            globalstring = curCell.detailDescription.text!
        }
       
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func mapClicked(sender: Int) {
        //var curCell=tableView.cellForRow(at: IndexPath(row: sender, section: 0)) as! DoctorTableViewCell
        var curCell=tableView.cellForRow(at: IndexPath(row: sender, section: 0)) as! DoctorTableViewCell
        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "MapViewController")
        if isSearching == true{
            globalDetailMap = curCell.addressLabel.text!
            
        }else{
            globalDetailMap = curCell.addressLabel.text!
        }
        
      //  globalstring = curCell.doctorName.text!
        self.navigationController?.pushViewController(profileVC, animated: true)
       
    }
    
    
    func bookClicked(sender: Int) {
        
        var curCell=tableView.cellForRow(at: IndexPath(row: sender, section: 0)) as! DoctorTableViewCell
        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "BookToken")
        if isSearching == true{
            globalDoctorName = curCell.addressLabel.text!
            
        }else{
            globalDoctorName = curCell.addressLabel.text!
        }
        
        //  globalstring = curCell.doctorName.text!
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
   
        var nipName=UINib(nibName:"Doctors", bundle:nil)
        self.tableView.register(nipName, forCellReuseIdentifier:"doctorInfoCell")
        
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
        self.title = "Doctors List"
        
        globalDetailViewDelegate = self
        
    }
    func sendServiceName(string: String) {
        
        print("Here")
        serviceName = string
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateTable() {
        
        tableView.alpha = 0.98
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
    
    
    
    func observePosts(string : String) {
        
        
        let postsRef = Database.database().reference().child("Doctors")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Doctor]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["service"] as? [String:Any],
                    
                    
                    
                    let text = dict["doctorName"] as? String,
                    let address = dict["doctorAddress"] as? String,
                    let phonenUMEBER = dict["doctorPhoneNumner"] as? String,
                    let rating = dict["doctorRating"] as? String,
                     let description = dict["doctorDescription"] as? String,
                    let photourl = dict["photoURL"] as? String
                {
                    
                    let service = author["serviceName"] as? String!
                    print(author["serviceName"] as? String!)
                    print(text)
                    
                   
                    
                    var userProfile = Services(author:service!, photoUrl:"")
                    
               
                    
                    let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress:address, doctorPhoneNumber: phonenUMEBER, service: userProfile, doctorRating: rating, doctorDescription: description, photoUrl: photourl)
                    
                    if userProfile.serviceName == globalCategorySring1{
                        tempPosts.append(post)
                    }
                    
                    
                }
            }
            
            self.serviceArray = tempPosts
            print(self.serviceArray)
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            
            self.tableView.alpha = 1
            //objeOverlay.showOverlay(view: self.tableView)
            self.objeOverlay.hideOverlayView()
            // self.animateTable()
            
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
        
        
        
        var cell:DoctorTableViewCell = self.tableView.dequeueReusableCell(withIdentifier:"doctorInfoCell",
                                                                          for: indexPath) as! DoctorTableViewCell
//        cell.btnMoreDetails.layer.borderWidth = 1.0
//        cell.btnMoreDetails.layer.borderColor = UIColor.black.cgColor
        
//        cell.btnMapClick.layer.borderWidth = 1.0
//        cell.btnMapClick.layer.borderColor = UIColor.black.cgColor
        
        
        cell.selectionStyle = .none
        
        cell.btnMoreDetails.tag = indexPath.row
        cell.btnMapClick.tag = indexPath.row
        if serviceArray.count != 0{
            
            
            if isSearching == true{
                //        cell.practiceName.text = practiceArray[indexPath.row].serviceName
                cell.doctorNameTxt.text = practiceArray[indexPath.row].doctorName
                cell.ratingLabel.text = practiceArray[indexPath.row].doctorRating
                cell.addressLabel.text = practiceArray[indexPath.row].doctorAddress
                //cell.text = practiceArray[indexPath.row].doctorName
                cell.phoneNumber.text = practiceArray[indexPath.row].doctorPhoneNumber
                
                cell.detailDescription.text = practiceArray[indexPath.row].doctorDescription
                return cell
            }else{
               //  cell.practiceName.text = serviceArray[indexPath.row].
                cell.doctorNameTxt.text = serviceArray[indexPath.row].doctorName
                    cell.ratingLabel.text = serviceArray[indexPath.row].doctorRating
                    cell.addressLabel.text = serviceArray[indexPath.row].doctorAddress
                cell.phoneNumber.text = serviceArray[indexPath.row].doctorPhoneNumber
                   cell.detailDescription.text = serviceArray[indexPath.row].doctorDescription
                //  cell.text = serviceArray[indexPath.row].doctorName
                   // cell.doctorName.text = serviceArray[indexPath.row].doctorName
                //       cell.practiceName.text = serviceArray[indexPath.row].serviceName
                
            
               // func set(post:Doctor) {
                
                
                if let checkedUrl = URL(string: serviceArray[indexPath.row].photoURL) {
                    
                    ImageService.getImage(withURL: checkedUrl) { image in
                        cell.proficPic.image = image
                    }
                }
                
                
//
//                            usernameLabel.text = post.author.username
//                            postTextLabel.text = post.text
//
//
                
              //  }
                
                return cell
                
            }
            
            
        }
        return cell;
    }
    
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = UIImage(named: "Image")
          var curCell=tableView.cellForRow(at: indexPath) as! DoctorTableViewCell
        
        // set up activity view controller
        let imageToShare = [ curCell.proficPic.image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
//        if tableView == tableView
//        {
//
//
//            var curCell=tableView.cellForRow(at: indexPath) as! DoctorTableViewCell
//            tableView.deselectRow(at: indexPath, animated: false)
//            var indexCount=0
//            for expandedIndexPath in expandedIndexPathsArray{
//                indexCount = indexCount + 1
//
//                if indexPath.compare((expandedIndexPath as! NSIndexPath) as IndexPath!) == ComparisonResult.orderedSame{
//                    expandedIndexPathsArray.remove(expandedIndexPath)
//
//                    tableView.beginUpdates()
//                    tableView.endUpdates()
//                    break;
//                }
//            }
//
//            if indexCount==expandedIndexPathsArray.count  {
//                expandedIndexPathsArray.add(indexPath)
//
//
//                //println("vertical frame... \(curCell.verticalView.frame)")
//                self.selectedIndexPath.add(indexPath.row)
//
//            }
//            else if selectedIndexPath.contains(indexPath.row)          {
//
//                expandedIndexPathsArray.remove(indexPath)
//
//                self.selectedIndexPath.remove(indexPath.row)
//
//            }
//            tableView.beginUpdates()
//            tableView.endUpdates()
//
//        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight:CGFloat = 76
        
        for expandedIndexPath in expandedIndexPathsArray{
            if indexPath.compare((expandedIndexPath as! NSIndexPath) as IndexPath)==ComparisonResult.orderedSame {
                
                cellHeight=151
            }
        }
        return cellHeight
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            
            
            let storage = Storage.storage()
            let url = serviceArray[indexPath.row].photoURL
            let storageRef = storage.reference(forURL: url!)
            
            //Removes image from storage
            storageRef.delete { error in
                if let error = error {
                  
                    
                    print(error)
                } else {
                    // File deleted successfully
                print("suceess")
                    
                    
                
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            
            isSearching = true
            
            let ref = Database.database().reference().child("Doctors")
            
            ref.queryOrdered(byChild: "doctorName").queryStarting(atValue: searchText).queryEnding(atValue: searchText+"\u{f8ff}").observe(.value, with: { snapshot in
                
                
                var tempDict = [Doctor]()
                
                
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                        let dict = childSnapshot.value as? [String:Any],
                        let author = dict["service"] as? [String:Any],
                        
                        
                        
                        let text = dict["doctorName"] as? String
                    {
                        
                        let service = author["serviceName"] as? String!
                        print(author["serviceName"] as? String!)
                        print(text)
                        
                        
                        
                        var userProfile = Services(author:service!, photoUrl: "")
                        
                //        let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress: "dsfsdf", doctorPhoneNumber: "sdfsd", service: userProfile)
                  
                        let post = Doctor(id: childSnapshot.key, doctorName: text, doctorAddress: "41 Saint Germain Street", doctorPhoneNumber: "9967930731", service: userProfile, doctorRating: "3/5", doctorDescription: "nkfankslf", photoUrl: "sdfsdf.png")
                        
                        //if userProfile.serviceName == "Ritesh" {
                            tempDict.append(post)
                      //  }
                        
                        
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
