//
//  DetailViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
var globalstring :String = String()
class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    textView.text = globalstring
    self.title = "Doctor Education"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
