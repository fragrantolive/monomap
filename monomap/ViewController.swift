//
//  ViewController.swift
//  monomap
//
//  Created by 中島詩草 on 2021/11/14.
//

import UIKit

//mapkitによってマップを表示させる
import MapKit

//MKMapViewDeligateの追加
class ViewController: UIViewController, MKMapViewDelegate {
    
    //storyBoardにmapviewを置き、それと接続する
    @IBOutlet var mapView:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //緯度・経度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.68154,139.752498)
             
                    mapView.setCenter(location,animated:true)
             
                    // 縮尺を設定
                    var region:MKCoordinateRegion = mapView.region
                    region.center = location
                    region.span.latitudeDelta = 0.02
                    region.span.longitudeDelta = 0.02
             
                    mapView.setRegion(region,animated:true)
             
                    // 表示タイプを航空写真と地図のハイブリッドに設定
                    mapView.mapType = MKMapType.hybrid
                    // mapView.mapType = MKMapType.standard
                    // mapView.mapType = MKMapType.satellite
        
        
        // Do any additional setup after loading the view.
    }


}


