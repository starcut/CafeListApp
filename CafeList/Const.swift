//
//  Const.swift
//  CFToR
//
//  Created by stardust on 2017/03/28.
//  Copyright © 2017年 stardust. All rights reserved.
//

import Foundation
import UIKit

class Const{
    
    /// ログインのテキストフィールド
    public static let LOGIN_TEXTFIELD_WIDTH : CGFloat = 200;
    public static let LOGIN_TEXTFIELD_HEIGHT : CGFloat = 40;
    
    /// ナビゲーションバーの高さ
    public static let NAVIGATION_BAR_HEIGHT : CGFloat = 44;
    
    /// タブバーの高さ
    public static let TABBAR_HEIGHT : CGFloat = 49;
    
    /// ログイン処理を行うAPIのURL
    public static let LOGIN_API_URL : String = "http://seeking-star.com/APIs/LoginAPI.php";
    
    /// 新規ユーザ登録処理を行うAPIのURL
    public static let REGISTER_USER_API_URL : String = "http://seeking-star.com/APIs/RegisterUserAPI.php";
    
    /// リストを表示する処理を行うAPIのURL
    public static let FETCH_LIST_API : String = "http://seeking-star.com/APIs/FetchAllCafeListAPI.php";
    
    /// 新しいリストを登録する処理を行うAPIのURL
    public static let REGISTER_LIST_API : String = "http://seeking-star.com/APIs/AddCafeListAPI.php";
    
    /// 既存のリストを編集する処理を行うAPIのURL
    public static let EDIT_LIST_API : String = "http://seeking-star.com/APIs/EditCafeListAPI.php";
    
    /// 登録したリストを削除する処理を行うAPIのURL
    public static let DELETE_LIST_API : String = "http://seeking-star.com/APIs/DeleteCafeListAPI.php";
}
