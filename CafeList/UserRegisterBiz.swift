//
//  UserRegisterBiz.swift
//  CafeList
//
//  Created by stardust on 2017/07/25.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation

class UserRegisterBiz{
    init(){
        
    }
    
    func jsonPost(registerData: UserData){
        //JSONデータ作成
        let myDict:NSMutableDictionary = NSMutableDictionary()
        myDict.setObject(registerData.loginId, forKey: "user_id" as NSCopying)
        myDict.setObject(registerData.password, forKey: "password" as NSCopying)
        
        var json: NSData!
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
            let url:URL = URL(string: Const.REGISTER_USER_API_URL)!
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            let session : URLSession = URLSession(configuration: config)
            
            request.httpMethod = "POST"
            
            //josnデータを一度文字列にしてキーと合わせる
            let data:NSString = "registerUser=\(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)" as NSString
            
            //jsonデータのセット
            request.httpBody = data.data(using: String.Encoding.utf8.rawValue)
            
            let task:URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                
                DispatchQueue.main.async(execute: {
                    print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String)
                    
                    do {
                        // 受け取ったJSONデータをパースする.
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
                        
                    } catch {
                        print("error")
                        print(error)
                    }
                })
            })
            
            task.resume()
        }
    }
}
