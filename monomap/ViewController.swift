//
//  ViewController.swift
//  monomap
//
//  Created by 中島詩草 on 2021/11/14.
//

import UIKit
import MapKit//mapkitによってマップを表示させる
import CoreLocation//現在地を使用するため

import FloatingPanel
import RealmSwift


class ViewController: UIViewController,  FloatingPanelControllerDelegate, UIGestureRecognizerDelegate {
    
    //storyBoardにmapviewを置き、それと接続する
    @IBOutlet weak var mapView:MKMapView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    let pinArray: [SpotMKPointAnnotation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        addLongPressGesture()
        showSemiModal()
        locationManager.delegate = self
        mapView.delegate = self //マップのデリゲートの設定
        locationManager.requestWhenInUseAuthorization()
        
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
        
        mapView.addAnnotation(myPin)
        mapView.addAnnotation(myPin2)
        mapView.addAnnotation(myPin3)

        let result = getAnnotations() //Realmに保存したAnnotationを取得
        mapView.addAnnotations(result) //AnnotationをMapViewに表示
        
    }
    
    func showSemiModal(){
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "half") as? ViewController2 else {return}
        
        let half = FloatingPanelController()
        
        half.delegate = self
        
        half.surfaceView.appearance.cornerRadius = 24.0
        
        half.set(contentViewController: vc)
        vc.delegate = self
        
        // セミモーダルビューを表示する
        half.addPanel(toParent: self)
        half.move(to: .tip, animated: false)
    }
    
    func setupMapView() {
        
        //緯度・経度を設定
        let location:CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(35.68154,139.752498)
        
        mapView.setCenter(location,animated: true)
 
        var region:MKCoordinateRegion = mapView.region  // 縮尺を設定
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        mapView.setRegion(region,animated:true)
        mapView.mapType = MKMapType.standard  // 表示タイプを航空写真と地図のハイブリッドに設定
    }
    
    func addLongPressGesture() {
        //ロングプレス用のインスタンスを生成する
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(ViewController.longPress(_:))
        )
        longPressGesture.delegate = self //デリゲートをセット
        self.mapView.addGestureRecognizer(longPressGesture)  //viewにロングプレスジェスチャーを追加
    }
}

// @IBAction
extension ViewController {
    func switchMarker(type: String) {
        let allAnnotations = self.mapView.annotations //1. マップのピン全削除
        self.mapView.removeAnnotations(allAnnotations)
        let annotations = getAnnotations().filter(type: type)  //2. フィルターしたピンを取得
        mapView.addAnnotations(annotations) //3. ピンを追加
    }
    
    //座標の取得
    func getAllPins() -> [Pin] {
        let realm = try! Realm()
        var results: [Pin] = []
        for pin in realm.objects(Pin.self) {
            results.append(pin)
        }
        return results
    }
    func getAnnotations() -> [SpotMKPointAnnotation]  {
        let pins = getAllPins()
        var results:[SpotMKPointAnnotation] = []
        
        pins.forEach { pin in
            let annotation = SpotMKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: (pin.latitude as NSString).doubleValue, longitude:(pin.longitude as NSString).doubleValue)
            annotation.coordinate = centerCoordinate
            annotation.type = pin.type
            results.append(annotation)
        }
        return results
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
                    
            //保存したピンの呼び出し
            savePin(latitude: lat, longitude: lon, type: annotation.type)
        }
    }
    //ピンの保存処理
    func savePin(latitude: String, longitude: String, type: String) {
        let pin = Pin()
        pin.latitude = latitude
        pin.longitude = longitude
        pin.type = type
        let realm = try! Realm()
        try! realm.write {
            realm.add(pin)
        }
    }
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //アノテーションビューをマップビューから取り出し、あれば再利用する。
        var testMarkerView = mapView.dequeueReusableAnnotationView(withIdentifier: "testPinName") as? MKMarkerAnnotationView
        
        let spotMKPointAnnotation = annotation as! SpotMKPointAnnotation
        var markImage = UIImage(named: "toilet")
        if (testMarkerView != nil) {
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
        
        testMarkerView!.canShowCallout = true //吹き出しの表示をONにする。
        
        let size: CGSize = CGSize(width: 25, height: 25)
        
        UIGraphicsBeginImageContext(size)
        markImage?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        testMarkerView?.glyphImage = resizedImage
        
        return testMarkerView
    }
}

//位置情報系
extension ViewController: CLLocationManagerDelegate {
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
