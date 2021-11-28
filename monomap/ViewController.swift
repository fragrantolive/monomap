//
//  ViewController.swift
//  monomap
//
//  Created by 中島詩草 on 2021/11/14.
//

import UIKit

//mapkitによってマップを表示させる
import MapKit

//現在地を使用するため
import CoreLocation

//MKMapViewDeligateの追加
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //storyBoardにmapviewを置き、それと接続する
    @IBOutlet weak var mapView:MKMapView!
    //weakって何？ = ?
    
    var locationManager: CLLocationManager!
    //CLの意味は？＝ CoreLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        //緯度・経度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        mapView.setCenter(location,animated: true)
        
        
        //中心となる場所の座標オブジェクト作成
        
        let coordinate = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        
        // 縮尺を設定
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        mapView.setRegion(region,animated:true)
        //種尺を設定
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = MKMapType.standard
        // mapView.mapType = MKMapType.standard
        // mapView.mapType = MKMapType.satellite
        
        //マップのデリゲートの設定
           mapView.delegate = self
        
        
        
        //範囲オブジェクトを作成
        //let region = MKCoordinateRegion(center: coordinate, span: span)
        //spanがサイトだと縮尺の宣言に利用されているがこの場合縮尺のどこを当てはめればいいのか分からない
        
        //MapViewに範囲オブジェクトを設定
        //  mapView.setRegion(region, animated: true)
        
        //ピンを生成
        let myPin = MKPointAnnotation()
        
        //ピンの座標設定
        myPin.coordinate = coordinate
        
      //どこにピンを設置するか
        myPin.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        myPin.title = "タイトル"
        myPin.subtitle = "サブタイトル"
        mapView.addAnnotation(myPin)
        

//        mapView.addAnnotation(myPin)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // 許可を求めるためのdelegateメソッド
    func locationManager(_ manager: CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        // 許可されてない場合
        case .notDetermined:
            // 許可を求める
            manager.requestWhenInUseAuthorization()
        // 拒否されてる場合
        case .restricted, .denied:
            // 何もしない
            break
        // 許可されている場合
        case .authorizedAlways, .authorizedWhenInUse:
            // 現在地の取得を開始
            manager.startUpdatingLocation()
            break
        default:
            break
            
            
            
        }
    }
    
    
    //アノテーションビューを返すメソッド
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
            //アノテーションビューをマップビューから取り出し、あれば再利用する。
            var testMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier: "testPinName") as? MKMarkerAnnotationView
            if (testMarkerView != nil) {
            //nil= 値が存在しない　"!=" = イコールじゃない、つまり”!= nil” は”存在する”
                
                //アノテーションビューに座標、タイトル、サブタイトルを設定する。
                testMarkerView!.annotation = annotation
            
            } else {
            
                //アノテーションビューを生成する。
                testMarkerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier:"testPinName")
            }
            
            //アノテーションビューに色を設定する。
            testMarkerView!.markerTintColor = .blue

            //吹き出しの表示をONにする。
            testMarkerView!.canShowCallout = true
            
//
            let size: CGSize = CGSize(width: 25, height: 25)

            let markImage = UIImage(named: "toilet")
            UIGraphicsBeginImageContext(size)
            markImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            testMarkerView?.glyphImage = resizedImage
            
//            testMarkerView!.glyphImage = UIImage(named: "toilet")
            
     
            return testMarkerView
            
        }
    
    
    
    
}




