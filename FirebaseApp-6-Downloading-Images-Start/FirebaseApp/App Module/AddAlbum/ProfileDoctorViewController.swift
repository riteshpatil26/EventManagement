//
//  ProfileDoctorViewController.swift
//  DoctorHunt
//
//  Created by Ritesh Narayan Patil on 4/24/18.
//  Copyright © 2018 Ritesh Narayan Patil. All rights reserved.
//

import UIKit
import Firebase
protocol DataprocessDelegate{
    
    func dataprocess(txtName :String,practicetxt :String ,txtAddress :String,image :UIImage,txtDoctordescription:String,txtDoctor:String)
    
}
var datadelegate :DataprocessDelegate?
class ProfileDoctorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var proficPic: UIImageView!
    @IBOutlet weak var scroollView: UIScrollView!
    
    @IBOutlet weak var practiceArrayResponder: UIButton!
    @IBOutlet weak var txtName: B68UIFloatLabelTextField!
    @IBOutlet weak var practiceTxt: B68UIFloatLabelTextField!
    
    
    let objeOverlay = LoadingOverlay()
    @IBOutlet weak var tableVIew: UITableView!
    
    @IBOutlet weak var txtAddress1: B68UIFloatLabelTextField!
    
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var txtzipCode: B68UIFloatLabelTextField!
    @IBOutlet weak var txtAddress2: B68UIFloatLabelTextField!
    
    @IBOutlet weak var txtCityField: B68UIFloatLabelTextField!
    
    var serviceArray :Array<Services> = Array<Services>()
    
    @IBAction func btnPracticeClicked(_ sender: UIButton) {
        //addCategory()
        
        
        UIView.animate(withDuration: 0.54) {
            self.tableVIew.frame = CGRect(x: 0, y: SCREEN_HEIGHT - 500, width: SCREEN_WIDTH, height: 500)
            
            self.tableVIew.alpha = 1.0
        }
        
    }
    
    
    
    @IBOutlet weak var imageButton: UIButton!
    
    var nextButton : UIBarButtonItem!
    var previousButton : UIBarButtonItem!
    var btnItemDone : UIBarButtonItem!
    
    @IBAction func onCiickButton(_ sender: UIButton) {
        openOptionsForProfilePic()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("came here")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField End")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.shouldReturnTextField(textField: textField)
        return true
    }
    func shouldReturnTextField(textField :UITextField){
        
       
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == ""{
            return true
        }else if textField == self.practiceTxt{
            if self.txtzipCode.text!.utf16.count < 35{
                
                //if string.isAllDigits() == true{
                return true
                
                
                
                
            }else{
                return false
            }
        }
        else{
            return true
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        print(selectedPhoto.size)
        self.proficPic.contentMode = UIViewContentMode.scaleAspectFit
        self.proficPic.image = selectedPhoto
        //self.isProfilePicPresent = true
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    private func openOptionsForProfilePic(){
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Select Options For Profile Picture", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Open Camera", style: .default)
        { action -> Void in
            self.openCamera()
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Open Photos", style: .default)
        { action -> Void in
            self.openPhotos()
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    private func openPhotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .photoLibrary
        OperationQueue.main.addOperation({ () -> Void in
            
            self.present(imagePicker,
                         animated: true,
                         completion: nil)
            
        })
    }
    private func openCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .camera
        OperationQueue.main.addOperation({ () -> Void in
            
            self.present(imagePicker,
                         animated: true,
                         completion: nil)
            
        })
    }
    
    @objc internal func profileClicked(){
        openOptionsForProfilePic()
    }
    @IBAction func nextClicked(_ sender: UIButton) {
        
        if (self.practiceTxt.text?.isEmpty)! {
            
            Utils.showToast(message: "Practice is empty", view: view, image: UIImage(named: errorImageName)!)
            
        }else{
            
           
            
            let profileIdStoruboard  = UIStoryboard(name: "AdminViewController", bundle: nil)
            var profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "DescriptionViewController")
            
            profileVC.view.frame = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            
   
            let randomNum:UInt32 = arc4random_uniform(5) // range is 0 to 99
            
            // convert the UInt32 to some other  types
            
            let randomTime:TimeInterval = TimeInterval(randomNum)
            
            let someInt:Int = Int(randomNum)
            
            let someString:String = String(randomNum)
            
            datadelegate?.dataprocess(txtName: "xyz", practicetxt:practiceTxt.text!, txtAddress: "fsdfsd", image: proficPic.image!, txtDoctordescription:"+ 6178186595" , txtDoctor: "\(someString)/5")
            
            
            self.navigationController?.pushViewController(profileVC, animated: true)
            
        }
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
            
            self.tableVIew.delegate = self
            self.tableVIew.dataSource = self
            
            
            self.tableVIew.alpha = 0
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        var nipName=UINib(nibName:"ServiceTableViewCell", bundle:nil)
        self.tableVIew.register(nipName, forCellReuseIdentifier:"serviceCell")
        btnNext.layer.borderWidth = 1.0
        btnNext.layer.borderColor = UIColor.white.cgColor
        imageButton.layer.borderWidth = 1.0
        imageButton.layer.borderColor = kGREEN_COLOR.cgColor
        self.tableVIew.translatesAutoresizingMaskIntoConstraints = false
        self.tableVIew.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 200)
        observePosts()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.serviceArray.isEmpty {
            return 2
        }else{
            return self.serviceArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell:ServiceTableViewCell = self.tableVIew.dequeueReusableCell(withIdentifier: "serviceCell", for: indexPath) as! ServiceTableViewCell
        
        cell.selectionStyle = .none
        cell.serviceLabel.text = self.serviceArray[indexPath.row].serviceName
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableVIew.alpha  = 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var curCell=tableView.cellForRow(at: indexPath) as! ServiceTableViewCell
        self.practiceTxt.text = curCell.serviceLabel.text
        tableVIew.alpha = 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewMoveUp(){
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.view.frame = CGRect(x: 0.0, y: -60.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    func viewDownMove(){
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.view.frame = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
 
   
func resetForm() {
    self.objeOverlay.hideOverlayView()
    
    Utils.showToast(message: "Error in Speciality add", view: self.view, image: UIImage(named: errorImageName)!)
}


}
