//
//  CafeInfomation.swift
//  CafeList
//
//  Created by stardust on 2017/07/15.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation

class CafeInfomation{
    /// カフェの名前
    var name: String!
    
    /// URL
    var url: String!
    
    /// 住所
    var address: String!
    
    /// 営業開始時間
    var openTime: String!
    
    /// 営業終了時間
    var closeTime: String!
    
    /// ラストオーダー時間
    var lastOrderTime: String!
    
    /// 禁煙 / 喫煙
    var smoke: String!
    
    /// コンストラクタ
    init(){
        name = ""
        url = ""
        address = ""
        openTime = ""
        closeTime = ""
        lastOrderTime = ""
        smoke = ""
    }
    
    /// コピーコンストラクタ
    /// - Parameter cafeInfo: <#cafeInfo description#>
    init(cafeInfo: CafeInfomation){
        name = cafeInfo.name
        url = cafeInfo.url
        address = cafeInfo.address
        openTime = cafeInfo.openTime
        closeTime = cafeInfo.closeTime
        lastOrderTime = cafeInfo.lastOrderTime
        smoke = cafeInfo.smoke
    }
}
