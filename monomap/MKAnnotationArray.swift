//
//  MKAnnotationArray.swift
//  monomap
//
//  Created by 中島詩草 on 2021/12/12.
//

import Foundation
import MapKit

let spotAnnotationArray: [SpotMKPointAnnotation] = {
    var spotArray = [SpotMKPointAnnotation]() // []
    //ピンを生成
    let myPin = SpotMKPointAnnotation()
    let myPin2 = SpotMKPointAnnotation()
    let myPin3 = SpotMKPointAnnotation()
    
    
  //どこにピンを設置するか
    myPin.coordinate = CLLocationCoordinate2D(latitude: 35.685485224293124, longitude: 139.75268636903203)
    myPin.title = "皇居"
    myPin.subtitle = "天皇のいらっしゃるところ"
    myPin.type = "toilet"
    
    myPin2.coordinate = CLLocationCoordinate2D(latitude: 35.67615110313334, longitude: 139.74486993387376)
    myPin2.title = "国会議事堂"
    myPin2.subtitle = "立法の最高機関"
    myPin2.type = "dustbox"
    
    myPin3.coordinate = CLLocationCoordinate2D(latitude: 35.6774439955982, longitude: 139.75228137085188)
    myPin3.title = "警視庁"
    myPin3.subtitle = "東京都の警察"
    myPin3.type = "vendingmachine"
    
    spotArray = [myPin, myPin2, myPin3 ]
    return spotArray
    
}()

func filteredArray(type: String) -> [SpotMKPointAnnotation]{
    let kirikaearray = spotAnnotationArray.filter { $0.type == type}
    
    return kirikaearray
}
