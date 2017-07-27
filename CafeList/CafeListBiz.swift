//
//  CafeListBiz.swift
//  CafeList
//
//  Created by stardust on 2017/06/08.
//  Copyright © 2017年 stardust. All rights reserved.
//
import Foundation

class CafeListBiz{
    /// リストに表示する文字列
    static public var listItems: Dictionary = Dictionary<String, String>()
    
    var loginID : String
    
    /// コンストラクタ
    init(){
        loginID = ""
    }
    
    /// サーバーからリストに表示する項目を取得する
    func getListItemsFromServer() -> Array<NSDictionary>{
        //JSONデータ作成
        let myDict:NSMutableDictionary = NSMutableDictionary()
        myDict.setObject(loginID, forKey: "userID" as NSCopying)
        
        var json: NSData!
        
        var cafeLists = Array<NSDictionary>()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        //JSONに変換可能かチェック
        if JSONSerialization.isValidJSONObject(myDict){
            do{
                json = try JSONSerialization.data(withJSONObject: myDict, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            }
            catch{
                print(error)
            }
            
            //HTTP通信のリクエスト生成
            let config:URLSessionConfiguration = .default
            let url:URL = URL(string: Const.FETCH_LIST_API)!
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
            let session : URLSession = URLSession(configuration: config)
            
            request.httpMethod = "POST"
            
            //josnデータを一度文字列にしてキーと合わせる
            let data:NSString = "json=\(NSString(data: json as Data, encoding: String.Encoding.utf8.rawValue)!)" as NSString
            
            //jsonデータのセット
            request.httpBody = data.data(using: String.Encoding.utf8.rawValue)
            
            /*let task:URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in*/
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) -> Void in
                DispatchQueue.global(qos: .default).sync(execute: {
                    do {
                        // 受け取ったJSONデータをパースする.
                        let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                        
                        // バックグラウンドだとUIの処理が出来ないので、メインスレッドでUIの処理を行わせる.
                        
                        //DispatchQueue.main.async(execute: {
                            let top = json as! Array<NSDictionary>
                            for roop in top{
                                cafeLists.append(roop)
                            }
                            /*// パースしたJSONデータへのアクセス.
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
                             }*/
                            
                        //})
                        
                    } catch {
                        print(error)
                    }
                })
                semaphore.signal()
            })
            
            task.resume()
            
            semaphore.wait()
        }
        
        
        
        return cafeLists
    }
}
