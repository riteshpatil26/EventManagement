
//  AdminViewController.swift


//
//  Created by Ritesh Patil.
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

class AdminViewController: BaseViewController {

    @IBOutlet weak var lblProfile: UILabel!
    @IBOutlet weak var lblService: UILabel!
   
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    let objeOverlay = LoadingOverlay()
    override func viewDidLoad() {
        super.viewDidLoad()
 addSlideMenuButton()
 
        //addSlideMenuButton()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.isNavigationBarHidden = false

        
        animateCell(cell: btnProfile)
        animateCell(cell: btnAdd)
      
      animateCell(cell: btnDelete)
       
       addShadowandBorder(button: btnProfile)
        addShadowandBorder(button: btnAdd)
        addShadowandBorder(button: btnDelete)
        
        
    }
    func addShadowandBorder(button :UIButton){
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1.0
    
        button.layer.cornerRadius = 5
        
    }
    
    
    
    @IBAction func onClickOfDeleteButton(_ sender: UIButton) {
        let profileIdStoruboard  = UIStoryboard(name: "Category", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "CategoryViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    func animateCell(cell: UIView) {
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration:1.5,
                       delay: 0,
                       usingSpringWithDamping: 0.18,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        cell.transform = .identity
            },
                       completion: nil)
        
    }
    
    @IBAction func onClickOfAdd(_ sender: UIButton) {
   
        let profileIdStoruboard  = UIStoryboard(name: "AdminViewController", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "PracticeViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)

    }
    
   
    @IBAction func onClickOfProfile(_ sender: UIButton) {
        
        let profileIdStoruboard  = UIStoryboard(name: "AdminViewController", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "ProfileDoctorViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}
