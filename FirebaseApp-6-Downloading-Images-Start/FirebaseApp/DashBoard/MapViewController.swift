//
//  MapViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

import MapKit

var globalDetailMap :String = String()
class MapViewController: UIViewController,UISearchBarDelegate{

    var latitude:CLLocationDegrees = 0
    var longitude:CLLocationDegrees = 0

    let objeOverlay = LoadingOverlay()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location"
       
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        searchBarSearchButtonClicked()
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func mapSearchBtn(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func DoneBtnFunc(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func searchBarSearchButtonClicked() {
        
        //ingnoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        activityIndicator.center = self.view.center
//        activityIndicator.hidesWhenStopped = true
//        activityIndicator.startAnimating()
//
//        self.view.addSubview(activityIndicator)
        self.objeOverlay.showOverlay(view: self.view)
        
        
        dismiss(animated: true, completion: nil)
      //  self.objeOverlay.showOverlay(view: self.view)
        
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = globalDetailMap
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start{(response, error) in
            
            self.objeOverlay.hideOverlayView()
          //  activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil{
                print("error")
            }else{
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                
                self.latitude = (response?.boundingRegion.center.latitude)!
                self.longitude = (response?.boundingRegion.center.longitude)!
                
                
                let annotation = MKPointAnnotation()
                annotation.title = globalDetailMap
                annotation.coordinate = CLLocationCoordinate2DMake(self.self.latitude, self.longitude)
                self.mapView.addAnnotation(annotation)
                
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude,self.longitude)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                
                let region = MKCoordinateRegionMake(coordinate, span)
                self.mapView.setRegion(region, animated: true)
                
                
            }
            
            
        }
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
