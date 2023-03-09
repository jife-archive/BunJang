//
//  MapViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/09.
//

import UIKit
import CoreLocation

protocol MapViewDelegate: AnyObject{
    func sendMap(_ map : String?)
}
class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    weak var delegate:MapViewDelegate?
    @IBOutlet weak var IntroSV: UIStackView!
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var addressLabel: UILabel!
    var latitude: Double?
     var longitude: Double?
    var city: String?
    var dong: String?
    @IBOutlet weak var addressSV: UIStackView!
    
    
    @IBAction func DeleteAddress(_ sender: Any) {
        self.addressLabel.text = ""
        addressSV.isHidden = true
        IntroSV.isHidden = false
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func SearchLocation(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchAddressViewController") as! SearchAddressViewController
        pushVC.delegate = self
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
    }
    
    @IBAction func CompleteAddress(_ sender: Any) {
        self.delegate?.sendMap(self.addressLabel.text)
        self.dismiss(animated: false)
    }
    
    
    @IBAction func myLocation(_ sender: Any) {
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        
        let geoCoder = CLGeocoder()
             //cllocatoin객체는 위도와 경로 좌표로 초기화
             let newLocation = CLLocation(latitude: latitude!, longitude: longitude!)
             
             //geoCoder에 reverseGeocodeLocation 메서드로 전달 된다.
             geoCoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) in
                 if error != nil {
                     print("에러 발생 \(error!.localizedDescription)")
                 }
                 //값이 있으면 배열 값으로 반환
                 if placemarks!.count > 0 {
                     let placemark = placemarks![0]
                     //딕셔너리 값으로 반환
                     let addressDictionary = placemark.addressDictionary
                     
                     //key 값을 이용해서 주소 찾기
                     self.city = addressDictionary!["City"] as! String
                     self.dong = addressDictionary!["SubLocality"] as! String
                     print("\(self.city!) \(self.dong!)")
                     print(addressDictionary)
                     DispatchQueue.main.async {
                         self.IntroSV.isHidden = true
                         self.addressSV.isHidden = false
                         self.addressLabel.text = self.city! + " " + self.dong!
              }
                 }
 })


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }
   


}
extension MapViewController: SearchAddressViewDelegate {
    func SendAddress(_ data: String?) {
        print("주소받음")
        self.addressLabel.text = data
        IntroSV.isHidden = true
        addressSV.isHidden = false
    }
    
}
