//
//  MapViewController.swift
//  FoodPin
//
//  Created by TsoiKaShing on 16/4/3.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurant : FoodPinRestaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setGeoCoder()

      
    }
    //自定义MKAnnotationView
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var annotaionView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation : annotation, reuseIdentifier:identifier)
            annotaionView?.canShowCallout = true
        }
        let leftView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        leftView.image = UIImage(data: restaurant.image!)
        annotaionView?.leftCalloutAccessoryView = leftView
        return annotaionView

    }
    
    func setGeoCoder() {
        
        let geoCoder = CLGeocoder()
        
        print("restaurant.location ==== \(restaurant.location)")
        
        geoCoder.geocodeAddressString(restaurant.location!) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            if let e = error {
                print("error === \(e)")
                return
            }
            
            if placemarks?.count > 0 {
                
                if let pms = placemarks {
                    let placemark = pms[0]
                    
                    let annotation = MKPointAnnotation()

                    annotation.title = self.restaurant.name
                    annotation.subtitle = self.restaurant.type
                    if let coordinate = placemark.location?.coordinate { annotation.coordinate = coordinate }
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
                
            }
        }
    }
    

    
}
