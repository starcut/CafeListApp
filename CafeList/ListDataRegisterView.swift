//
//  ListDataRegisterView.swift
//  CafeList
//
//  Created by stardust on 2017/06/10.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class ListDataRegisterView: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    var cafeListData : ListDataRegisterBiz!
    
    var cafeListInfo : CafeInfomation!
    
    var urlText : UITextField!
    
    var nameText : UITextField!
    
    var addressText : UITextField!
    
    var openTimeLabel : UITextField!
    
    var closeTimeLabel : UITextField!
    
    var smokeTitleLabel : UILabel!
    
    let smokeItems = ["禁煙", "分煙", "喫煙"]

    override func viewDidLoad() {
        super.viewDidLoad()
        cafeListData = ListDataRegisterBiz()
        
        drawGraphic()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawGraphic(){
        var uiHeight : Int = 40;
        
        self.view.backgroundColor = UIColor.white
        
        // Collectionにする
        // URLに関する情報表示
        let urlTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 80, width: 200, height: uiHeight))
        urlTitleLabel.text = "URL"
        self.view.addSubview(urlTitleLabel)
        
        urlText = UITextField(frame: CGRect(x: 40, y: 130, width: 200, height: uiHeight))
        urlText.borderStyle = .roundedRect
        urlText.placeholder = "例:http://seeking-star.com"
        self.view.addSubview(urlText)
        
        let urlEditButton : UIButton = UIButton(frame: CGRect(x: 240, y: 130, width: 200, height: uiHeight))
        urlEditButton.setTitle("情報取得", for: .normal)
        self.view.addSubview(urlEditButton)
        
        
        // 店名に関する情報表示
        let nameTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 180, width: 200, height: uiHeight))
        nameTitleLabel.text = "店名"
        self.view.addSubview(nameTitleLabel)
        
        nameText = UITextField(frame: CGRect(x: 40, y: 230, width: 200, height: uiHeight))
        nameText.borderStyle = .roundedRect
        nameText.placeholder = "お店の名前"
        self.view.addSubview(nameText)
        
        // 住所に関する情報表示
        let addressTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 280, width: 200, height: uiHeight))
        addressTitleLabel.text = "住所"
        self.view.addSubview(addressTitleLabel)
        
        addressText = UITextField(frame: CGRect(x: 40, y: 340, width: 200, height: uiHeight))
        addressText.borderStyle = .roundedRect
        addressText.placeholder = "東京都新宿区"
        self.view.addSubview(addressText)
        
        // 営業時間に関する情報表示
        let operationTimeTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 390, width: 200, height: uiHeight))
        operationTimeTitleLabel.text = "営業時間"
        self.view.addSubview(operationTimeTitleLabel)
        
        openTimeLabel = UITextField(frame: CGRect(x: 40, y: 440, width: 100, height: uiHeight))
        openTimeLabel.text = "9:00"
        openTimeLabel.borderStyle = .roundedRect
        
        openTimeLabel.delegate = self
        
        self.view.addSubview(openTimeLabel)
        
        closeTimeLabel = UITextField(frame: CGRect(x: 180, y: 440, width: 100, height: uiHeight))
        closeTimeLabel.text = "23:00"
        closeTimeLabel.borderStyle = .roundedRect
        self.view.addSubview(closeTimeLabel)
        
        // 禁煙喫煙に関する情報
        smokeTitleLabel = UILabel(frame: CGRect(x: 40, y: 490, width: 200, height: uiHeight))
        smokeTitleLabel.text = "禁煙 / 喫煙"
        self.view.addSubview(smokeTitleLabel)
        
        // スイッチとか？
        
        let smokeEditButton : UITextField = UITextField(frame: CGRect(x: 240, y: 490, width: 200, height: uiHeight))
        smokeEditButton.text = "編集"
        smokeEditButton.backgroundColor = UIColor.magenta
        smokeEditButton.borderStyle = .roundedRect
        
        smokeEditButton.delegate = self
        
        self.view.addSubview(smokeEditButton)
        
        // 登録ボタン
        let registerButton: UIButton = UIButton(frame: CGRect(x: 40, y: 550, width: 200, height: uiHeight))
        registerButton.setTitle("登録", for: .normal)
        registerButton.backgroundColor = UIColor.blue
        registerButton.addTarget(self, action: #selector(clickRegisterButton), for: .touchUpInside)
        self.view.addSubview(registerButton)
        
        // 時間設定用のDatePicker
        let settingTimePicker = UIDatePicker()
        settingTimePicker.datePickerMode = .time
        openTimeLabel.inputView = settingTimePicker
        closeTimeLabel.inputView = settingTimePicker
        //キーボードに表示するツールバー
        let pickerToolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height * 0.16, width: self.view.frame.size.width, height: 40))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width * 0.5, y: self.view.frame.size.height - 20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        
        // ツールバーのボタン
        //右寄せのためのスペース
        let spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        //完了ボタン
        let fixButton = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(clickFixButton(sender:)))
        pickerToolBar.items = [spaceBarButton, fixButton]
        openTimeLabel.inputAccessoryView = pickerToolBar
        closeTimeLabel.inputAccessoryView = pickerToolBar
        
        
        // 喫煙設定用のDatePicker
        let settingSmokePicker = UIPickerView()
        settingSmokePicker.delegate = self
        settingSmokePicker.dataSource = self
        smokeEditButton.inputView = settingSmokePicker
        
        smokeEditButton.inputAccessoryView = pickerToolBar
    }
    
    func clickFixButton(sender: UIBarButtonItem){
        self.view.endEditing(true)
    }
    
    func clickRegisterButton(sender: UIButton){
        let cafeData : CafeInfomation
        cafeData = CafeInfomation()
        cafeData.name = nameText.text
        cafeData.url = urlText.text
        cafeData.address = addressText.text
        cafeData.openTime = openTimeLabel.text
        cafeData.closeTime = closeTimeLabel.text
        //cafeData.lastOrderTime = .text
        cafeData.smoke = smokeTitleLabel.text
        //cafeData.smoke = smokeTitleLabel.text
        
        // 同一のIDが登録されていないかチェックする
        
        
        // ユーザー登録をする
        cafeListData.registerCafeList(cafeInfo: cafeData)
        
        // 登録が完了したらアラートを表示し、登録画面へ戻る
        let completeAlert = UIAlertController(title: "登録完了", message: "登録が完了しました。", preferredStyle: .alert)
        completeAlert.addAction(UIAlertAction(title: "OK", style: .default){action in
            
        })
        self.present(completeAlert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return smokeItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return smokeItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(smokeItems[row])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
