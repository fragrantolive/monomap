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
    @IBOutlet weak var mapView:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //緯度・経度を設定
        let location:CLLocationCoordinate2D
                    = CLLocationCoordinate2DMake(35.68154,139.752498)
             
                    mapView.setCenter(location,animated:true)
        
        
          //中心となる場所の座標オブジェクト作成
              //フィリピンのセブ・マクタン空港

             //let coordinate = CLLocationCoordinate2DMake(10.310656, 123.98022)

             
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
             
        mapView.setRegion(region,animated:true)
        //種尺を設定
           //let span = MKCoordinateSpanMake(0.2, 0.2)
             
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = MKMapType.hybrid
        // mapView.mapType = MKMapType.standard
        // mapView.mapType = MKMapType.satellite
        
        //範囲オブジェクトを作成
        let region = MKCoordinateRegionMake(coordinate, span)
        //spanがサイトだと縮尺の宣言に利用されているがこの場合縮尺のどこを当てはめればいいのか分からない
        
        //MapViewに範囲オブジェクトを設定
           mapView.setRegion(region, animated: true)

        //ピンを生成
        let myPin = MKPointAnnotation()

        //ピンの座標設定
        myPin.coordinate = coordinate
        
        //タイトル、サブタイトルを設定
        myPin.title = "皇居"
        myPin.subtitle = "天皇がいらっしゃるところ"
        
        //mapViewにピンを追加
        mapView.addAnnotation(myPin)
        
        
        
        // Do any additional setup after loading the view.
    }


}


