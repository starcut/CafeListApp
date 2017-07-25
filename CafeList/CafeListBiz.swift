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
    
    /// コンストラクタ
    init(){
        getListItemsFromServer()
    }
    
    /// サーバーからリストに表示する項目を取得する
    func getListItemsFromServer(){
        for index in 0..<4 {
            //CafeListBiz.listItems.("カフェ\(index)")
        }
    }
}
