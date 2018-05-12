//
//  DoctorTableViewCell.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
protocol detailViewDelegate {
    func detailClicked(sender:Int)
    func mapClicked(sender:Int)
    func bookClicked(sender:Int)
}

var globalDetailViewDelegate :detailViewDelegate!

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var doctorNameTxt: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var proficPic: UIImageView!
   
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var btnMoreDetails: UIButton!
    
    @IBOutlet weak var btnMapClick: UIButton!
    
   
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBAction func onClickOfMapClick(_ sender: UIButton) {
        globalDetailViewDelegate?.mapClicked(sender: sender.tag)
    }
    
    @IBAction func onClickOfBook(_ sender: UIButton) {
    globalDetailViewDelegate?.bookClicked(sender: sender.tag)
    }
    @IBAction func onClickOfMoreDetails(_ sender: UIButton) {
   
        globalDetailViewDelegate?.detailClicked(sender:sender.tag)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  

}
