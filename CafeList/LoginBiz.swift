//
//  LoginBiz.swift
//  CafeList
//
//  Created by stardust on 2017/06/07.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation

class LoginBiz{
    init(){
        
    }
    
    func jsonPost(loginID: String, password: String) -> NSDictionary{
        //JSONデータ作成
        let myDict:NSMutableDictionary = NSMutableDictionary()
        myDict.setObject(loginID, forKey: "userID" as NSCopying)
        myDict.setObject(password, forKey: "password" as NSCopying)
        
        var json: NSData!
        
        var loginUserData = NSDictionary()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        //JSONに変換可能かチェック
        if JSONSerialization.isValidJSONObject(myDict){
            do{
                json = try JSONSerialization.data(withJSONObject: myDict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                
                print(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)
            }
            catch{
                print(error)
            }
            
            //HTTP通信のリクエスト生成
            let config:URLSessionConfiguration = .default
            let url:URL = URL(string: Const.LOGIN_API_URL)!
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            let session : URLSession = URLSession(configuration: config)
            
            request.httpMethod = "POST"
            
            //josnデータを一度文字列にしてキーと合わせる
            let data:NSString = "json=\(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)" as NSString
            
            //jsonデータのセット
            request.httpBody = data.data(using: String.Encoding.utf8.rawValue)
            
            let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                
                DispatchQueue.global(qos: .default).sync(execute: {
                    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String)
                    
                    do {
                        // 受け取ったJSONデータをパースする.
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        loginUserData = json as! NSDictionary
                        
                    } catch {
                        print("error")
                        print(error)
                    }
                })
                semaphore.signal()
            })
            
            task.resume()
            semaphore.wait()
        }
        
        return loginUserData
    }
    
    
    func callAPI(urlDelegate: URLSessionDelegate? ){
        // 通信用のConfigを生成.
        let config: URLSessionConfiguration =  URLSessionConfiguration.default
        
        // Sessionを生成.
        let session: URLSession = URLSession(configuration: config, delegate: urlDelegate, delegateQueue: nil)
        
        // 通信先のURLを生成.
        let url:NSURL = NSURL(string: Const.FETCH_LIST_API)!
        
        // タスクの生成.
        let task: URLSessionDataTask = session.dataTask(with: url as URL, completionHandler: { (data, response, err) -> Void in
            
            if data != nil {
                DispatchQueue.main.async(execute: {
                    //UIへの処理を入れる
                })
                
                do {
                    // 受け取ったJSONデータをパースする.
                    let json: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    
                    // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
                    
                    DispatchQueue.main.async(execute: {
                        
                        // パースしたJSONデータへのアクセス.
                        for _value in json {
                            let key: String = _value.key as! String
                            let value: Any = _value.value
                            
                            if String(describing: type(of: value)) == "__NSDictionaryI" {
                                for valueData in value as! NSDictionary {
                                    let dataKey = valueData.key as! String
                                    let date = valueData.value as! String
                                    
                                    print("key:\(dataKey) value:\(date)")
                                }
                            }
                            print("key:\(key) value:\(value)")
                        }
                        
                    })
                    
                } catch {
                    print("error")
                    print(error)
                }
            }
        })
        
        // タスクの実行.
        task.resume()
    }
}
