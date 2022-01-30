//
//  ViewController2.swift
//  monomap
//
//  Created by 中島詩草 on 2022/01/16.
//

import UIKit
import MapKit

class ViewController2: UIViewController {
 
    var delegate: ViewController?
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        
        
//        @IBAction func switchMarker(){
//    //        1. マップのピン全削除
//            let allAnnotations = self.mapView.annotations
//            self.mapView.removeAnnotations(allAnnotations)
//    //
//    //        2. フィルターしたピンを取得
//            let filteredArray = filteredArray(type: "toilet")
//
//    //        3. ピンを追加
//            self.mapView.addAnnotations(filteredArray)
//        }
//
//        @IBAction func switchMarker2(){
//    //        1. マップのピン全削除
//            let allAnnotations = self.mapView.annotations
//            self.mapView.removeAnnotations(allAnnotations)
//    //
//    //        2. フィルターしたピンを取得
//            let filteredArray = filteredArray(type: "dustbox")
//
//    //        3. ピンを追加
//            self.mapView.addAnnotations(filteredArray)
//        }
//
//        @IBAction func switchMarker3(){
//    //        1. マップのピン全削除
//            let allAnnotations = self.mapView.annotations
//            self.mapView.removeAnnotations(allAnnotations)
//    //
//    //        2. フィルターしたピンを取得
//            let filteredArray = filteredArray(type: "vendingmachine")
//
//    //        3. ピンを追加
//            self.mapView.addAnnotations(filteredArray)
//        }
        
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
        self.button1.backgroundColor = UIColor.systemYellow
        self.button2.backgroundColor = UIColor.systemYellow
        self.button3.backgroundColor = UIColor.systemYellow
    
           
           //角丸の程度を指定
           self.button1.layer.cornerRadius = 35.0
        self.button2.layer.cornerRadius = 35.0
        self.button3.layer.cornerRadius = 35.0
        
        
       }
    
    @IBAction func toilet() {
        delegate?.switchMarker()
    }

    @IBAction func dustbox() {
        delegate?.switchMarker2()
    }

    @IBAction func jihanki() {
        delegate?.switchMarker3()
    }


        // Do any additional setup after loading the view.
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


