//
//  ViewController.swift
//  CFToR
//
//  Created by stardust on 2017/03/28.
//  Copyright © 2017年 stardust. All rights reserved.
//

import UIKit

class LoginView: UIViewController,URLSessionDelegate,URLSessionDataDelegate,URLSessionDownloadDelegate {
    var window: UIWindow?
    var naviController :UINavigationController?
    
    private var loginBiz = LoginBiz()
    
    /// ログインテキストボックス
    private var loginIdText :UITextField?
    
    /// パスワード入力ボックス
    private var passwordText :UITextField?
    
    /// ログインボタン
    private var loginButton :UIButton?
    
    /// 新規登録ボタン
    private var registerButton :UIButton?
    
    /// メイン処理
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.backgroundColor = UIColor.white;
        
        self.drawGrapgic();
    }

    
    /// 描画メイン
    func drawGrapgic(){
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
        
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

        // ログインボタン
        let loginButtonRect :CGRect? = CGRect.init(x: 30, y: 150 + Const.NAVIGATION_BAR_HEIGHT, width: 100, height: 40);
        loginButton = UIButton.init(frame: loginButtonRect!);
        loginButton!.isEnabled = true
        loginButton!.backgroundColor = UIColor.orange;
        loginButton!.setTitle("ログイン", for: UIControlState.normal);
        loginButton!.addTarget(self, action: #selector(loginButtonClick(sender:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(loginButton!);
        
        // 新規登録ボタン
        let registerButtonRect :CGRect? = CGRect.init(x: 180, y: 150 + Const.NAVIGATION_BAR_HEIGHT, width: 100, height: 40);
        registerButton = UIButton.init(frame: registerButtonRect!);
        registerButton!.isEnabled = true
        registerButton!.backgroundColor = UIColor.green;
        registerButton!.setTitle("新規登録", for: UIControlState.normal);
        registerButton!.addTarget(self, action: #selector(registerButtonClick(sender:)), for: UIControlEvents.touchUpInside);
        self.view.addSubview(registerButton!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// ログインボタンを押下した場合の処理
    ///
    /// - Parameter sender: <#sender description#>
    func loginButtonClick(sender :UIButton){
        if((loginIdText?.text)! == "" || (passwordText?.text)! == ""){
            let loginErrorAlert = UIAlertController(title: "ログインエラー", message: "ユーザIDまたはパスワードが入力されていません。", preferredStyle: .alert)
            loginErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(loginErrorAlert, animated: true, completion: nil)
            
            return
        }
        
        var loginUserData = NSDictionary()
        loginUserData = loginBiz.jsonPost(loginID: (loginIdText?.text)!, password: (passwordText?.text)!)
        
        var userIdNumber = loginUserData["id"] as! Int
        
        if userIdNumber != -1 {
            let caftListView  = CafeListMainView()
            caftListView.modalTransitionStyle = .crossDissolve
            self.present(caftListView, animated: true, completion: nil)
        }
        else{
            let loginErrorAlert = UIAlertController(title: "ログインエラー", message: "ユーザIDまたはパスワードが違います。", preferredStyle: .alert)
            loginErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(loginErrorAlert, animated: true, completion: nil)
        }
    }
    
    /// ログインボタンを押下した場合の処理
    ///
    /// - Parameter sender: <#sender description#>
    func registerButtonClick(sender :UIButton){
        
        
        let registerView :UIViewController = RegisterView()
        registerView.modalTransitionStyle = .crossDissolve
        //self.present(registerView, animated: true, completion: nil)
        
        self.naviController?.pushViewController(registerView, animated: true)
    }
    
    
    
    var myProgress:UIProgressView!
    var myProgressLabel:UILabel!
    func download(){
        // Progressバーの設定.
        myProgress = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        myProgress.layer.position = CGPoint(x: self.view.frame.width/2, y: 400)
        myProgress.progress = 0.0
        self.view.addSubview(myProgress)
        
        // Progressの内容を表示するためのラベル.
        myProgressLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        myProgressLabel.text = "0%　ダウンロード"
        myProgressLabel.textAlignment = NSTextAlignment.center
        myProgressLabel.center = CGPoint(x: self.view.frame.width/2, y: 450)
        
        // 通信用のConfigを生成.
        let config: URLSessionConfiguration =  URLSessionConfiguration.default
        
        // Sessionを生成.
        let session: URLSession = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        // 通信先のURLを生成.
        let url:NSURL = NSURL(string: Const.FETCH_LIST_API)!
        
        let request: URLRequest = URLRequest(url: url as URL)
        // ダウンロードタスクを生成.
        let progressTask: URLSessionDownloadTask = session.downloadTask(with: request)
        progressTask.resume()
    }
    
    /*
     ダウンロード終了時に呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("data is found")
    }
    
    /*
     ダウンロードの開始時に呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        myProgress.progress = 0
        myProgress.setProgress(1.0, animated: true)
        myProgressLabel.text = "100% ダウンロード"
        print(myProgressLabel.text!)
    }
    
    /*
     タスク処理中に定期的に呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let per:Float = Float(totalBytesWritten/totalBytesExpectedToWrite)
        myProgress.setProgress(per, animated: true)
        
        myProgressLabel.text = "\((Int)(myProgress.progress * 100))%　ダウンロード"
        print(myProgress.progress)
        print(myProgressLabel.text!)
    }
    
    /*
     タスク終了時に呼び出されるデリゲート.
     */
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error != nil {
            print("ダウンロードが失敗しました")
            print(error!)
        } else {
            print("ダウンロードが完了しました")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.window?.rootViewController != nil){
            
        }
        else{
            // ナビゲーションバーの設定
            naviController = UINavigationController(rootViewController:self)
            self.window = UIWindow(frame: UIScreen.main.bounds);
            self.window?.rootViewController = naviController
            self.window!.makeKeyAndVisible();
        }
    }
}

