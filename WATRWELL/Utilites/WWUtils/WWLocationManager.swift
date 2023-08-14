//
//  WWLocationManager.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 15/08/23.
//

import CoreLocation
import UIKit

final class WWLocationManager : NSObject, CLLocationManagerDelegate {
    
    static let shared = WWLocationManager()
    
    private var locationUpdateCompletion : ((CLLocation)->Void)?
    private var locationUpdateCompletionWithStatus : ((CLLocation?,Bool)->Void)?
    
    private let locationManager = CLLocationManager()
    
    private(set) var currentLocation : CLLocation!
    
    private var locationsEnabled : Bool = CLLocationManager.locationServicesEnabled()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = CLActivityType.otherNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 500.0
    }
    
    func fetchCurrentLocation(_ completion : @escaping (CLLocation)->Void){
        self.locationUpdateCompletion = completion
        getCurrentLocation()
    }
    
    func fetchCurrentLocationWithStatus(_ completion : @escaping (_ location:CLLocation?,_ status:Bool)->Void){
        self.locationUpdateCompletionWithStatus = completion
        getCurrentLocation()
    }
    
    
    private func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if locationsEnabled{
            switch CLLocationManager().authorizationStatus{
            case .denied, .restricted: requestForLocationAccess()
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
            default:
                locationManager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        if let _ = self.locationUpdateCompletion {
            locationUpdateCompletion?(locations.last!)
            locationManager.stopUpdatingLocation()
        }
        if let _ = self.locationUpdateCompletionWithStatus {
            locationUpdateCompletionWithStatus?(locations.last,true)
            locationManager.stopUpdatingLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted,.notDetermined:
            break
        default:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    private func requestForLocationAccess(){
        let alertController = UIAlertController(title: "Location Permission", message: "Please enable location permission to proceed", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak self] (action) in
            self?.locationUpdateCompletionWithStatus?(nil,false)
        }))
        
        sharedAppDelegate.window?.currentViewController?.present(alertController, animated: true, completion: nil)
    }
}
