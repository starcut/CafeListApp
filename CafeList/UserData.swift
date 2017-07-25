//
//  UserObject.swift
//  CafeList
//
//  Created by stardust on 2017/07/15.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation


/// ログイン情報のオブジェクト
class UserData{
    /// ユーザID
    var loginId: String!
    
    /// パスワード
    var password: String!
    
    /// コンストラクタ
    init() {
        loginId = ""
        password = ""
    }
    
    /// コピーコンストラクタ
    /// - Parameter userInfo: ログイン情報のオブジェクト
    init(userInfo: UserData) {
        loginId = userInfo.loginId
        password = userInfo.password
    }
}
