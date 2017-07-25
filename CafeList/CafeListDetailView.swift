//
//  CafeListDetailView.swift
//  CafeList
//
//  Created by stardust on 2017/07/07.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class CafeListDetailView: UIViewController {
    
    var editTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawGraphic()
        
        // Do any additional setup after loading the view.
    }
    
    func drawGraphic(){
        // URLに関する情報表示
        let urlTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 100, width: 200, height: 50))
        urlTitleLabel.text = "URL"
        self.view.addSubview(urlTitleLabel)
        
        let urlLabel : UITextField = UITextField(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        urlLabel.text = "example.com"
        self.view.addSubview(urlLabel)
        
        let urlEditButton : UIButton = UIButton(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        urlEditButton.setTitle("情報取得", for: .normal)
        self.view.addSubview(urlEditButton)
        
        
        // 店名に関する情報表示
        let nameTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 100, width: 200, height: 50))
        nameTitleLabel.text = "店名"
        self.view.addSubview(nameTitleLabel)
        
        let nameLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        nameLabel.text = "お店の名前"
        self.view.addSubview(nameLabel)
        
        let nameEditButton : UIButton = UIButton(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        nameEditButton.setTitle("編集", for: .normal)
        nameEditButton.tag = 0
        nameEditButton.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        self.view.addSubview(nameEditButton)

        
        // 住所に関する情報表示
        let addressTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 100, width: 200, height: 50))
        addressTitleLabel.text = "住所"
        self.view.addSubview(addressTitleLabel)
        
        let addressLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        addressLabel.text = "東京都新宿区"
        self.view.addSubview(addressLabel)
        
        let addressEditButton : UIButton = UIButton(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        addressEditButton.setTitle("編集", for: .normal)
        addressEditButton.tag = 1
        addressEditButton.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        self.view.addSubview(addressEditButton)
        
        // 営業時間に関する情報表示
        let operationTimeTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 100, width: 200, height: 50))
        operationTimeTitleLabel.text = "営業時間"
        self.view.addSubview(operationTimeTitleLabel)
        
        let openTimeLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        openTimeLabel.text = "9:00"
        self.view.addSubview(openTimeLabel)
        
        let closeTimeLabel : UILabel = UILabel(frame: CGRect(x: 350, y: 160, width: 200, height: 50))
        closeTimeLabel.text = "23:00"
        self.view.addSubview(closeTimeLabel)
        
        let operationTimeEditButton : UIButton = UIButton(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        operationTimeEditButton.setTitle("編集", for: .normal)
        operationTimeEditButton.tag = 2
        operationTimeEditButton.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        self.view.addSubview(operationTimeEditButton)
        
        // 禁煙喫煙に関する情報
        let smokeTitleLabel : UILabel = UILabel(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        smokeTitleLabel.text = "禁煙 / 喫煙"
        self.view.addSubview(smokeTitleLabel)
        
        let smokeEditButton : UIButton = UIButton(frame: CGRect(x: 40, y: 160, width: 200, height: 50))
        smokeEditButton.setTitle("編集", for: .normal)
        smokeEditButton.tag = 3
        smokeEditButton.addTarget(self, action: #selector(editButtonClick), for: .touchUpInside)
        self.view.addSubview(smokeEditButton)
    }
    
    func editButtonClick(sender: UIButton){
        var alertTitle: String
        
        switch sender.tag {
        case 0:
            alertTitle = "店名の編集"
            break
            
        case 1:
            alertTitle = "住所の編集"
            break
            
        case 2:
            alertTitle = "営業時間"
            break
        
        case 3:
            alertTitle = "禁煙 / 喫煙"
            break
            
        default:
            alertTitle = "不正です"
            break
        }
        
        // 登録が完了したらアラートを表示し、登録画面へ戻る
        let editAlert = UIAlertController(title: alertTitle, message: "登録が完了しました。", preferredStyle: .alert)
        editAlert.addAction(UIAlertAction(title: "OK", style: .default){action in
            print("OK")
        })
        editAlert.addAction(UIAlertAction(title: "キャンセル", style: .default){action in
            print("キャンセル")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
