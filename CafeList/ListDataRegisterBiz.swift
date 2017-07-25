//
//  ListDataRegisterBiz.swift
//  CafeList
//
//  Created by stardust on 2017/07/15.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation

class ListDataRegisterBiz{
    init() {
        
    }
    
    
    func registerCafeList(cafeInfo: CafeInfomation){
        //JSON登録処理
        let cafeData = NSMutableDictionary()
        cafeData.setObject(cafeInfo.name, forKey: "name" as NSCopying)
        cafeData.setObject(cafeInfo.url, forKey: "url" as NSCopying)
        cafeData.setObject(cafeInfo.address, forKey: "address" as NSCopying)
        cafeData.setObject(cafeInfo.openTime, forKey: "openTime" as NSCopying)
        cafeData.setObject(cafeInfo.closeTime, forKey: "closeTime" as NSCopying)
        cafeData.setObject(cafeInfo.lastOrderTime, forKey: "lastOrder" as NSCopying)
        cafeData.setObject(cafeInfo.smoke, forKey: "smoke" as NSCopying)
        
        var jsonData: NSData!
        
        // JSONに変換可能かチェック
        if JSONSerialization.isValidJSONObject(cafeData) {
            do{
                jsonData = try JSONSerialization.data(withJSONObject: cafeData, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            }
            catch{
                print("カフェリスト登録エラー")
            }
        }
        
        // HTTP通信のリクエスト生成
        let config: URLSessionConfiguration = .default
        let apiURL: URL = URL(fileURLWithPath: Const.REGISTER_LIST_API)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: apiURL)
        let session: URLSession = URLSession(configuration: config)
        
        request.httpMethod = "POST"
        
        // JSONデータを一度文字列にしてキーと組み合わせる
        let jsonString: NSString = "json=\(NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue))" as NSString
        
        // JSONデータのセット
        request.httpBody = jsonString.data(using: String.Encoding.utf8.rawValue)
        
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {(jsonString, request, error) -> Void in
            
            DispatchQueue.main.async(execute: { 
                do{
                    // 受け取ったJOSNデータをパースする
                    let parsedJson = try JSONSerialization.jsonObject(with: jsonString!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    
                }
            })
        })
    }
}
