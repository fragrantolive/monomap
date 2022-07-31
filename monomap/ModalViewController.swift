//
//  ModalViewController.swift
//  monomap
//
//  Created by 中島詩草 on 2022/07/17.
//

import UIKit

class ModalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var PickerView: UIPickerView! // 自販機とかのPickerView
    var placeArray: [String] = ["vendingmachine","toilet","dustbox" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        // データソースの設定
           PickerView.dataSource = self
           // デリゲートの設定
          PickerView.delegate = self
       }
        // Do any additional setup after loading the view.
    
    @IBAction func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return placeArray.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return placeArray[row] //row = 前から一つずつ取り出す
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
