//
//  MapVC.swift
//  loginDemo
//
//  Created by Priyal on 28/09/23.
//
import UIKit
import GoogleMaps

class MapVC: HeaderViewController  {
    
    fileprivate var missionPostModel: MapModel?
    let didFindMyLocation = false
    var latitude: String = "29.0167"
    var longitude: String = "77.3833"
    var isSingleLatLong: Bool = false
    var webservice = mapWebService()
    var arr : [MapObjMissionPostList] = []
    var arr1 : [MapObjMissionPostList] = []
    var arr11 : [MapObjMissionPostList] = []
    var arr2 :[MapObjMissionPostList] = []
    var minDist: [MapObjMissionPostList] = []
    var arrLoc : MapObjMissionPostList?
    var mapPinTitle: String = ""
    var mapPinAddress: String = ""
    var isShowAlert = true
    var distanceToCurrentLocation: Double = 0.0
    var clLocationManager : CLLocationManager?
    private lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setUpHeader()
        getData()
        setMapViewData()
        clLocationManager?.delegate = self

        
    }
    //        // Do any additional setup after loading the view.
    //
    func setUpHeader(){
        self.setUpHeaderTitle(strHeaderTitle: "NEAREST MISSION/POST".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        self.showFindLocation()
        //self.setupImgLocation()
        if self.isShowAlert {
            self.showAlert()
            self.isShowAlert = false
        }
    }
    func setUpMapview(){
        
        self.mapView.mapStyle = isDarkModeAppearance ? try? GMSMapStyle.init(jsonString: self.jsonMapStyle) : nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
            guard let `self` = self else { return  }
            let camera = GMSCameraPosition.camera(withLatitude: self.latitude.nsString.doubleValue, longitude: self.longitude.nsString.doubleValue, zoom: 4)
            self.mapView.animate(with: GMSCameraUpdate.zoomOut())
            self.mapView.animate(toLocation: camera.target)
        }
        if self.isSingleLatLong {
            let locationCoordinate = CLLocationCoordinate2D(latitude: self.latitude.nsString.doubleValue, longitude: self.longitude.nsString.doubleValue)
            
            let marker = GMSMarker(position: locationCoordinate)
            marker.icon = UIImage(named: "mapPin_Big")
            
            let item = MapObjMissionPostList(dictionary: [:])
            item.pointerName = self.mapPinTitle
            item.addressLine1 = self.mapPinAddress
            marker.userData = item
            marker.map = self.mapView
        }
    }
    fileprivate func showAlert() {
        let dvc = DisclaimerVC.instantiate(appStoryboard: .disclaimer)
        //        slideInTransitioningDelegate.direction = .bottom
        //        slideInTransitioningDelegate.ratio = 0.8
        //        dvc.transitioningDelegate = slideInTransitioningDelegate
        dvc.modalPresentationStyle = .overFullScreen
        /*let navController = (appDelegate?.window?.rootViewController as? BottomBarViewController)?.selectedViewController?.parentNavigationController
         navController?.present(dvc, animated: true, completion: nil)*/
        self.navigationController?.present(dvc, animated: true, completion: nil)
    }
    
    fileprivate func setMapViewData() {
        
        self.mapView.clear()
        
        arr.forEach({ item in
            
            let locationCoordinate = CLLocationCoordinate2D(latitude: item.lattitude.nsString.doubleValue, longitude: item.longitude.nsString.doubleValue)
            
            let marker = GMSMarker(position: locationCoordinate)
            marker.icon = UIImage(named: "mapPin_Big")
            marker.title = item.pointerName
            marker.map = self.mapView
            
            marker.userData = item
        })
        
        arr2.forEach({ item in
            
            let locationCoordinate = CLLocationCoordinate2D(latitude: item.lattitude.nsString.doubleValue, longitude: item.longitude.nsString.doubleValue)
            
            let marker = GMSMarker(position: locationCoordinate)
            marker.icon = UIImage(named: "mapPin_small")
            marker.title = item.pointerName
            marker.map = self.mapView
            marker.userData = item
        })
        
    }
    
    fileprivate func setMapViewDataMin() {
        self.mapView.clear()
        
        // Check if minDist is not empty
        if let firstItem = self.minDist.first {
            let locationCoordinate = CLLocationCoordinate2D(latitude: firstItem.lattitude.nsString.doubleValue, longitude: firstItem.longitude.nsString.doubleValue)
            
            let marker = GMSMarker(position: locationCoordinate)
            marker.icon = UIImage(named: "mapPin_Big")
            marker.title = firstItem.pointerName
            marker.map = self.mapView
            
            marker.userData = firstItem
        }
    }
    override func btnFindLocationTapped(_ sender: UIButton) {
        if clLocationManager == nil {
            clLocationManager = CLLocationManager()
            clLocationManager?.requestWhenInUseAuthorization()
            clLocationManager?.delegate = self
        }
        
        clLocationManager?.startUpdatingLocation()
    }
}
    

extension MapVC : GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        guard let model = marker.userData as? MapObjMissionPostList else { return nil }
           // Check if the Nib file is loaded successfully
        let infoView = MapPinView.loadNib()
        infoView.lblTitle.text = model.pointerName
        infoView.lblAddress.text = [model.addressLine1.is_trimming_WS_NL_to_String?.trimming_WS, model.addressLine2.is_trimming_WS_NL_to_String?.trimming_WS, model.addressLine3.is_trimming_WS_NL_to_String?.trimming_WS].compactMap({ $0 }).joined(separator: " ")
        infoView.lblNumber.text = model.telephone
        
        infoView.lblAddress.isHidden = (infoView.lblAddress.text ?? "").trimming_WS_NL.isEmptyString
        infoView.lblNumber.superview?.isHidden = (infoView.lblNumber.text ?? "").trimming_WS_NL.isEmptyString
        
        var newWidth = SCREEN_WIDTH / 1.5
        infoView.frame = CGRect(x: 0, y: 0, width: newWidth, height: 50)
        
        infoView.setNeedsLayout()
        infoView.layoutIfNeeded()
        
        let newHeight = infoView.systemLayoutSizeFitting(.init(width: newWidth, height: 50), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        
        let new_Width = infoView.systemLayoutSizeFitting(.init(width: newWidth, height: newHeight), withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required).width
        
        if newWidth > new_Width {
            newWidth = new_Width
        }
        
        infoView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        
        guard let model = marker.userData as? MapObjMissionPostList else { return  }
        
        var number = model.telephone.trimming_WS_NL
        number = number.components(separatedBy: NSCharacterSet(charactersIn: "0123456789+").inverted).joined()
        
        guard number.count != 0 else { return }
        
        openURL(urlString: "tel://\(number)")
    }

}
extension MapVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        guard let locations = locations.last else {
            return
        }
        
        let latitude = locations.coordinate.latitude
        let longitude = locations.coordinate.longitude
        
        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
        self.view.isUserInteractionEnabled = false
        
        let geoCoder = CLGeocoder.init()
        geoCoder.reverseGeocodeLocation(locations) { places, error in
            
            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
            self.view.isUserInteractionEnabled = true
            if let place = places?.first {
              
                guard let isoCountryCode = place.isoCountryCode?.is_trimming_WS_NL_to_String else { return }
                self.webservice.latitude = "\(latitude)"
                self.webservice.longitude = "\(longitude)"
                self.webservice.countryCode = isoCountryCode
                print(place.country)
                self.arr = self.arr1.filter {
                    item in
                        let countryCondition = place.country!.lowercased().contains(item.countryName.lowercased())
                        //let addressCondition = place.country!.lowercased().contains(item.addressLine2.lowercased())
                    let addressCondition = item.addressLine2.lowercased().contains(place.country!.lowercased())
                        return countryCondition || addressCondition
                }
                self.arr2 = self.arr11.filter {
                    //place.country!.lowercased().contains($0.countryName.lowercased())
                    item in
                        let countryCondition = place.country!.lowercased().contains(item.countryName.lowercased())
                    let addressCondition = item.addressLine2.lowercased().contains(place.country!.lowercased())
                        return countryCondition || addressCondition
                }
                self.minDist = self.arr + self.arr2
                
                self.minDist = self.minDist.map { element in
                    var updatedElement = element
                    let elementLatitude = element.lattitude
                    let elementLongitude = element.longitude
                    let distance = calculateDistance(lat1: latitude, lon1: longitude, lat2: getDouble(anything: elementLatitude), lon2: getDouble(anything: elementLongitude))
                    updatedElement.distanceToCurrentLocation = distance
                    return updatedElement
                }
                self.minDist.sort(by: { $0.distanceToCurrentLocation < $1.distanceToCurrentLocation })
                
                for element in self.minDist {
                    print("Country: \(element.countryName)")
                    print("Latitude: \(element.lattitude)")
                    print("Longitude: \(element.longitude)")
                    print("Distance to Current Location: \(element.distanceToCurrentLocation)")
                    // Add any other properties you want to print
                    print("---")
                }
                //self.arr2.sort(by: { $0.distanceToCurrentLocation < $1.distanceToCurrentLocation })
                if let minDistance = self.minDist.first?.distanceToCurrentLocation {
                    print("Minimum Distance from arr: \(minDistance)")
                } else {
                    // Handle the case where arr is empty
                    print("arr is empty")
                }
                
                self.mapView.animate(toLocation: locations.coordinate)
                self.mapView.animate(toZoom: 5)
                //self.mapView.clear()
                self.setMapViewDataMin()
                //                    self.webservice.getSpecificCountryData(forCountryID: isoCountryCode){ arr in
                //                    self.arrLoc = arr
                //
                if place.country?.lowercased() == "india" {
                    UIAlertController.showWith(title: "Message", msg: "You are currently in India. The headquarters of the Ministry is located at South Block , New Delhi.", style: .alert, sender: self.view, actionTitles: ["OK"], actionStyles: [.default], actionHandlers: [nil])
                    
    //                    let camera = GMSCameraPosition.camera(withLatitude: latitude,longitude: longitude, zoom: 7)
    //                    let mapView = GMSMapView.map(withFrame: CGRectZero, camera: camera)

                   // mapView.isMyLocationEnabled = true
                    //self.mapView = mapView
                }
            }
           
        }
        
   }
    
    
}
func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
    let earthRadius = 6371.0 // Radius of the Earth in kilometers.
    
    let dLat = (lat2 - lat1).degreesToRadians
    let dLon = (lon2 - lon1).degreesToRadians
    
    let a = sin(dLat/2) * sin(dLat/2) + sin(dLon/2) * sin(dLon/2) * cos(lat1.degreesToRadians) * cos(lat2.degreesToRadians)
    let c = 2 * atan2(sqrt(a), sqrt(1-a))
    
    return earthRadius * c
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
}

extension MapVC {
    
    func getData(){
        webservice.getLocationData { lists,list2  in
            self.arr = lists
            self.arr1 = lists
            self.arr2 = list2
            self.arr11 = list2
            self.setUpMapview()
        }
    }
//    func getFindNearestByCountryCode() {
//        CustomActivityIndicator.sharedInstance.showIndicator(view: self.view)
//        webservice.getdataFromCountryCode { getModel,<#arg#>  in
//            
//            CustomActivityIndicator.sharedInstance.hideIndicator(view: self.view)
//                self.arr = getModel
//                self.setMapViewData()
//    
//        }
//    }
    
}
extension MapVC {
    var jsonMapStyle: String {
        return """
[
{
"featureType": "all",
"elementType": "geometry",
"stylers": [
  {
    "color": "#242f3e"
  }
]
},
{
"featureType": "all",
"elementType": "labels.text.stroke",
"stylers": [
  {
    "lightness": -80
  }
]
},
{
"featureType": "administrative",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#746855"
  }
]
},
{
"featureType": "administrative.locality",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#d59563"
  }
]
},
{
"featureType": "poi",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#d59563"
  }
]
},
{
"featureType": "poi.park",
"elementType": "geometry",
"stylers": [
  {
    "color": "#263c3f"
  }
]
},
{
"featureType": "poi.park",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#6b9a76"
  }
]
},
{
"featureType": "road",
"elementType": "geometry.fill",
"stylers": [
  {
    "color": "#2b3544"
  }
]
},
{
"featureType": "road",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#9ca5b3"
  }
]
},
{
"featureType": "road.arterial",
"elementType": "geometry.fill",
"stylers": [
  {
    "color": "#38414e"
  }
]
},
{
"featureType": "road.arterial",
"elementType": "geometry.stroke",
"stylers": [
  {
    "color": "#212a37"
  }
]
},
{
"featureType": "road.highway",
"elementType": "geometry.fill",
"stylers": [
  {
    "color": "#746855"
  }
]
},
{
"featureType": "road.highway",
"elementType": "geometry.stroke",
"stylers": [
  {
    "color": "#1f2835"
  }
]
},
{
"featureType": "road.highway",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#f3d19c"
  }
]
},
{
"featureType": "road.local",
"elementType": "geometry.fill",
"stylers": [
  {
    "color": "#38414e"
  }
]
},
{
"featureType": "road.local",
"elementType": "geometry.stroke",
"stylers": [
  {
    "color": "#212a37"
  }
]
},
{
"featureType": "transit",
"elementType": "geometry",
"stylers": [
  {
    "color": "#2f3948"
  }
]
},
{
"featureType": "transit.station",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#d59563"
  }
]
},
{
"featureType": "water",
"elementType": "geometry",
"stylers": [
  {
    "color": "#17263c"
  }
]
},
{
"featureType": "water",
"elementType": "labels.text.fill",
"stylers": [
  {
    "color": "#515c6d"
  }
]
},
{
"featureType": "water",
"elementType": "labels.text.stroke",
"stylers": [
  {
    "lightness": -20
  }
]
}
]
"""
    }
    
    
}
