//
//  RegisterView.swift
//  CafeList
//
//  Created by stardust on 2017/07/01.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class RegisterView: UIViewController {
    var window: UIWindow?
    var naviController :UINavigationController?
    
    private var userRegisterBiz = UserRegisterBiz()
    
    /// ログインテキストボックス
    private var loginIdText :UITextField?
    
    /// パスワード入力ボックス
    private var passwordText :UITextField?
    
    /// 新規登録ボタン
    private var registerButton :UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        self.view.backgroundColor = UIColor.white
        let textLable = UILabel(frame: CGRect(x: 40, y: 40, width: 100, height: 50))
        textLable.text = "register"
        self.view.addSubview(textLable)
        
        // ID入力テキストボックス
        let loginTextRect :CGRect? = CGRect.init(x: 30, y: 30 + Const.NAVIGATION_BAR_HEIGHT, width: Const.LOGIN_TEXTFIELD_WIDTH, height: Const.LOGIN_TEXTFIELD_HEIGHT);
        loginIdText = UITextField.init(frame: loginTextRect!);
        loginIdText!.borderStyle = UITextBorderStyle.roundedRect;
        loginIdText!.placeholder = "ユーザID";
        self.view.addSubview(loginIdText!);
        
        // パスワード入力テキストボックス
        let passwordTextRect :CGRect? = CGRect.init(x: 30, y: 90 + Const.NAVIGATION_BAR_HEIGHT, width: 200, height: 40);
        passwordText = UITextField.init(frame: passwordTextRect!);
        passwordText!.borderStyle = UITextBorderStyle.roundedRect;
        passwordText!.placeholder = "パスワード";
        passwordText!.isSecureTextEntry = true;
        self.view.addSubview(passwordText!);
        
        // 登録ボタン
        let registerButtonRect :CGRect? = CGRect.init(x: 180, y: 150 + Const.NAVIGATION_BAR_HEIGHT, width: 100, height: 40);
        registerButton = UIButton.init(frame: registerButtonRect!);
        registerButton!.isEnabled = true
        registerButton!.backgroundColor = UIColor.green;
        registerButton!.setTitle("登録", for: UIControlState.normal);
        registerButton!.addTarget(self, action: #selector(registerButtonClick(sender:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(registerButton!);
        
        // Do any additional setup after loading the view.
    }

    func backButtonClick(){
        self.navigationController?.popViewController(animated: true)
    }
    
    /// ログインボタンを押下した場合の処理
    ///
    /// - Parameter sender: <#sender description#>
    func registerButtonClick(sender :UIButton){
        let userData : UserData
        userData = UserData()
        userData.loginId = loginIdText?.text
        userData.password = passwordText?.text
        
        // 同一のIDが登録されていないかチェックする
        
        
        // ユーザー登録をする
        userRegisterBiz.jsonPost(registerData: userData)
        
        // 登録が完了したらアラートを表示し、登録画面へ戻る
        let completeAlert = UIAlertController(title: "登録完了", message: "登録が完了しました。", preferredStyle: .alert)
        completeAlert.addAction(UIAlertAction(title: "OK", style: .default){action in
            print("戻るよ")
        })
        self.present(completeAlert, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func viewWillAppear(_ animated: Bool) {
        if (self.window?.rootViewController != nil){
            
        }
        else{
            // ナビゲーションバーの設定
            naviController = UINavigationController(rootViewController:self)
            self.window = UIWindow(frame: UIScreen.main.bounds);
            self.window?.rootViewController = naviController
            self.window!.makeKeyAndVisible();
        }
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
