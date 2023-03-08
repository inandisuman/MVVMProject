//
//  UserDetailsViewController.swift
//  MVVMProject
//
//  Created by Deboleena on 08/03/23.
//

import Foundation
import UIKit
import MapKit

class UserDetailsViewController: UIViewController {
    
    var user: User?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure views
        configureViews()
        plotCoordinateOnMap()
    }
    
    func configureViews() {
        guard let user = user else {
            mapView.isHidden = true
            return
        }
        mapView.isHidden = false
        address.text = user.address.street + ", " + user.address.suite + ", " + user.address.city + ", " + user.address.zipcode
        lat.text = user.address.geo.latitude + ", " + user.address.geo.longitude
        name.text = user.name
        email.text = user.email
        website.text = user.website
        phone.text = user.phone
    }
    
    func plotCoordinateOnMap() {
        guard let user = user, let lat = Double(user.address.geo.latitude), let lon = Double(user.address.geo.longitude) else {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
}
