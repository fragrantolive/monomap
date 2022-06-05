//
//  ViewController.swift
//  monomap
//
//  Created by 中島詩草 on 2021/11/14.
//

import UIKit
import RealmSwift

//mapkitによってマップを表示させる
import MapKit

//現在地を使用するため
import CoreLocation

import FloatingPanel

//MKMapViewDeligateの追加
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    
    //storyBoardにmapviewを置き、それと接続する
    @IBOutlet weak var mapView:MKMapView!
    //weakって何？ = ?
    
    var locationManager: CLLocationManager!
    let pinArray: [SpotMKPointAnnotation] = []
    //CLの意味は？＝ CoreLocation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        //ロングプレス用のインスタンスを生成する
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(ViewController.longPress(_:))
        )
        
        //デリゲートをセット
        longPressGesture.delegate = self
        
        //viewにロングプレスジェスチャーを追加
        self.mapView.addGestureRecognizer(longPressGesture)
        
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
        
        //マップのデリゲートの設定
        mapView.delegate = self
        
        //ピンを生成
        let myPin = SpotMKPointAnnotation()
        let myPin2 = SpotMKPointAnnotation()
        let myPin3 = SpotMKPointAnnotation()
        
        //ピンの座標設定
        myPin.coordinate = coordinate
        myPin2.coordinate = coordinate
        myPin3.coordinate = coordinate
        
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
        
        mapView.addAnnotation(myPin)
        mapView.addAnnotation(myPin2)
        mapView.addAnnotation(myPin3)
        
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "half") as? ViewController2 else {
            return
        }
        self.showSemiModal(vc: vc)
    }
    
    func showSemiModal(vc:ViewController2){
        
        let half = FloatingPanelController()
        
        half.delegate = self
        
        half.surfaceView.appearance.cornerRadius = 24.0
        
        half.set(contentViewController: vc)
        vc.delegate = self
        
        // セミモーダルビューを表示する
        half.addPanel(toParent: self)
        half.move(to: .tip, animated: false)
    }
}

// @IBAction
extension ViewController {
    @IBAction func switchMarker(){
        //        1. マップのピン全削除
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        //
        //        2. フィルターしたピンを取得
        let filteredArray = filteredArray(type: "toilet")
        
        //        3. ピンを追加
        self.mapView.addAnnotations(filteredArray)
        //座標の取得
        func getAllPins() -> [Pin] {
           let realm = try! Realm()
           var results: [Pin] = []
           for pin in realm.objects(Pin.self) {
               results.append(pin)
           }
           return results
        }
        
        //String の緯度と軽度をCLLocationCoordinate2D に変換
        func getAnnotations() -> [MKPointAnnotation]  {
           let pins = getAllPins()
           var results:[MKPointAnnotation] = []
           
           pins.forEach { pin in
               let annotation = MKPointAnnotation()
               let centerCoordinate = CLLocationCoordinate2D(latitude: (pin.latitude as NSString).doubleValue, longitude:(pin.longitude as NSString).doubleValue)
               annotation.coordinate = centerCoordinate
               results.append(annotation)
           }
           return results
        }
        let annotations = getAnnotations()
        annotations.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
    }
    @IBAction func switchMarker2(){
        //        1. マップのピン全削除
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        //
        //        2. フィルターしたピンを取得
        let filteredArray = filteredArray(type: "dustbox")
        
        //        3. ピンを追加
        self.mapView.addAnnotations(filteredArray)
        //座標の取得
        func getAllPins() -> [Pin] {
           let realm = try! Realm()
           var results: [Pin] = []
           for pin in realm.objects(Pin.self) {
               results.append(pin)
           }
           return results
        }
        
        //String の緯度と軽度をCLLocationCoordinate2D に変換
        func getAnnotations() -> [MKPointAnnotation]  {
           let pins = getAllPins()
           var results:[MKPointAnnotation] = []
           
           pins.forEach { pin in
               let annotation = MKPointAnnotation()
               let centerCoordinate = CLLocationCoordinate2D(latitude: (pin.latitude as NSString).doubleValue, longitude:(pin.longitude as NSString).doubleValue)
               annotation.coordinate = centerCoordinate
               results.append(annotation)
           }
           return results
        }
        let annotations = getAnnotations()
        annotations.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
    }
    
    @IBAction func switchMarker3(){
        //        1. マップのピン全削除
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        //
        //        2. フィルターしたピンを取得
        let filteredArray = filteredArray(type: "vendingmachine")
        
        //        3. ピンを追加
        self.mapView.addAnnotations(filteredArray)
        //座標の取得
        func getAllPins() -> [Pin] {
           let realm = try! Realm()
           var results: [Pin] = []
           for pin in realm.objects(Pin.self) {
               results.append(pin)
           }
           return results
        }
        
        //String の緯度と軽度をCLLocationCoordinate2D に変換
        func getAnnotations() -> [MKPointAnnotation]  {
           let pins = getAllPins()
           var results:[MKPointAnnotation] = []
           
           pins.forEach { pin in
               let annotation = MKPointAnnotation()
               let centerCoordinate = CLLocationCoordinate2D(latitude: (pin.latitude as NSString).doubleValue, longitude:(pin.longitude as NSString).doubleValue)
               annotation.coordinate = centerCoordinate
               results.append(annotation)
           }
           return results
        }
        let annotations = getAnnotations()
        annotations.forEach { annotation in
            mapView.addAnnotation(annotation)
        }
    }

    
    //ロングプレス処理の実装
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer) {
        
        let location:CGPoint = sender.location(in: mapView)
        
        if (sender.state == UIGestureRecognizer.State.ended){
            //タップした位置を緯度、経度の座標に変換する。
            let mapPoint:CLLocationCoordinate2D = mapView.convert(location,toCoordinateFrom: mapView)
           
            //位置を取得
            // 緯度
            let lat:String = mapPoint.latitude.description
            // 経度
            let lon:String = mapPoint.longitude.description
            
            
            //ピンを作成してマップビューに登録する。
            let annotation = SpotMKPointAnnotation()
            annotation.type = "dustbox"
            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
            annotation.title = "新規追加"
            annotation.subtitle = "\(annotation.coordinate.latitude), \(annotation.coordinate.longitude)"
            mapView.addAnnotation(annotation)
            
            
            //ピンの保存処理
            func savePin(latitude: String, longitude: String) {
                let pin = Pin()
                pin.latitude = latitude
                pin.longitude = longitude
                let realm = try! Realm()
                try! realm.write {
                    realm.add(pin)
                }
            }
            //保存したピンの呼び出し
            savePin(latitude: lat, longitude: lon)
        }
    }
}

// MapViewの設定
extension ViewController {
    
    //アノテーションビューを返すメソッド
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //アノテーションビューをマップビューから取り出し、あれば再利用する。
        var testMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier: "testPinName") as? MKMarkerAnnotationView
        
        let spotMKPointAnnotation = annotation as! SpotMKPointAnnotation
        var markImage = UIImage(named: "toilet")
        if (testMarkerView != nil) {
            //nil= 値が存在しない　"!=" = イコールじゃない、つまり”!= nil” は”存在する”
            
            //アノテーションビューに座標、タイトル、サブタイトルを設定する。
            testMarkerView!.annotation = annotation
            
        } else {
            
            //アノテーションビューを生成する。
            testMarkerView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier:"testPinName")
        }
        
        if(spotMKPointAnnotation.type == "toilet"){
            testMarkerView?.markerTintColor = .blue
            markImage = UIImage(named: "toilet")
        }else if(spotMKPointAnnotation.type == "dustbox") {
            testMarkerView?.markerTintColor = .red
            markImage = UIImage(systemName: "trash")
            //trush
        }else if(spotMKPointAnnotation.type == "vendingmachine"){
            testMarkerView?.markerTintColor = .orange
            markImage = UIImage(named: "vendingmachine")
        }
        
        //吹き出しの表示をONにする。
        testMarkerView!.canShowCallout = true
        
        let size: CGSize = CGSize(width: 25, height: 25)
        
        UIGraphicsBeginImageContext(size)
        markImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        testMarkerView?.glyphImage = resizedImage
        
        return testMarkerView
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
           // TODO: Pinを取得してMap上に表示する
        
//        //座標の取得
//        func getAllPins() -> [Pin] {
//           let realm = try! Realm()
//           var results: [Pin] = []
//           for pin in realm.objects(Pin.self) {
//               results.append(pin)
//           }
//           return results
//        }
//
//        //String の緯度と軽度をCLLocationCoordinate2D に変換
//        func getAnnotations() -> [MKPointAnnotation]  {
//           let pins = getAllPins()
//           var results:[MKPointAnnotation] = []
//
//           pins.forEach { pin in
//               let annotation = MKPointAnnotation()
//               let centerCoordinate = CLLocationCoordinate2D(latitude: (pin.latitude as NSString).doubleValue, longitude:(pin.longitude as NSString).doubleValue)
//               annotation.coordinate = centerCoordinate
//               results.append(annotation)
//           }
//           return results
//        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
           // TODO: Pinを取得してMap上に表示する
//           let annotations = getAnnotations()
//           annotations.forEach { annotation in
//               mapView.addAnnotation(annotation)
//           }
        }
}

// 位置情報の設定
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


}
