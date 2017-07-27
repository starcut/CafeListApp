//
//  ListDataRegisterView.swift
//  CafeList
//
//  Created by stardust on 2017/06/10.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class ListDataRegisterView: UIViewController{
    var cafeListData : ListDataRegisterBiz!
    
    var cafeListInfo : CafeInfomation!
    
    var urlText : UITextField!
    
    var nameText : UITextField!
    
    var addressText : UITextField!
    
    var openTimeLabel : UILabel!
    
    var closeTimeLabel : UILabel!
    
    var smokeTitleLabel : UILabel!
    
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
        
        openTimeLabel = UILabel(frame: CGRect(x: 40, y: 440, width: 100, height: uiHeight))
        openTimeLabel.text = "9:00"
        self.view.addSubview(openTimeLabel)
        
        closeTimeLabel = UILabel(frame: CGRect(x: 180, y: 440, width: 100, height: uiHeight))
        closeTimeLabel.text = "23:00"
        self.view.addSubview(closeTimeLabel)
        
        // 禁煙喫煙に関する情報
        smokeTitleLabel = UILabel(frame: CGRect(x: 40, y: 490, width: 200, height: uiHeight))
        smokeTitleLabel.text = "禁煙 / 喫煙"
        self.view.addSubview(smokeTitleLabel)
        
        // スイッチとか？
        
        let smokeEditButton : UIButton = UIButton(frame: CGRect(x: 240, y: 490, width: 200, height: uiHeight))
        smokeEditButton.setTitle("編集", for: .normal)
        smokeEditButton.backgroundColor = UIColor.magenta
        self.view.addSubview(smokeEditButton)
        
        let registerButton: UIButton = UIButton(frame: CGRect(x: 40, y: 550, width: 200, height: uiHeight))
        registerButton.setTitle("登録", for: .normal)
        registerButton.backgroundColor = UIColor.blue
        registerButton.addTarget(self, action: #selector(clickRegisterButton), for: .touchUpInside)
        self.view.addSubview(registerButton)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
