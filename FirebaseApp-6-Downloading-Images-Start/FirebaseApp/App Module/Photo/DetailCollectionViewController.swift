//
//  DetailCollectionViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 5/13/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

class DetailCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var detailCollectionVIew: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailCollectionVIew.dataSource = self
        detailCollectionVIew.delegate = self
        detailCollectionVIew.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 1;
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailViewCell", for: indexPath) as! DetailCollectionViewCell
        
        cell.imageView1.image = imageview1
//
//        cell.activityIndicatorView.startAnimating()
//        cell.libraryImageView.contentMode = .scaleAspectFill
//        cell.libraryImageView.clipsToBounds = true
       collectionView.backgroundColor = UIColor.clear
//
//
//        if let checkedUrl = URL(string: serviceArray[indexPath.row].photoURL) {
//
//            ImageService.getImage(withURL: checkedUrl) { image in
//                cell.libraryImageView.image = image
//
//                cell.activityIndicatorView.stopAnimating()
//                cell.activityIndicatorView.hidesWhenStopped = true
//            }
//        }
//
//        if isFromAdmin == true{
//
//
//            if indexPath.row == selectedIndexpath{
//
//                cell.ovelerayView.alpha = 0.45
//            }else{
//
//                cell.ovelerayView.alpha = 0
//            }
//
//        }else{
//
//            cell.ovelerayView.alpha = 0
//        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        print(self.view.frame)
        
        let length : CGFloat = (self.view.frame.width)
        let lenght2 :CGFloat = (self.view.frame.height)
        
        
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
        _ = cell as! DetailCollectionViewCell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
