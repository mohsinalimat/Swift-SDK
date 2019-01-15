//
//  UserDefaultsHelper.swift
//
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2019 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

class UserDefaultsHelper: NSObject {
    
    public static let shared = UserDefaultsHelper()
    
    private let PERSISTENT_USER_TOKEN_KEY = "userTokenKey"
    private let TABLE_CLASS_MAPPINGS_KEY = "tableClassMapping"
    
    func savePersistentUserToken(_ userToken: String) {
        let userDefaults = UserDefaults.standard
        let userToken: [String: String] = ["userToken": userToken]
        userDefaults.setValue(userToken, forKey: PERSISTENT_USER_TOKEN_KEY)
        userDefaults.synchronize()
    }
    
    func getPersistentUserToken() -> String? {
        let userDefaults = UserDefaults.standard
        if let userToken = userDefaults.value(forKey: PERSISTENT_USER_TOKEN_KEY),
            let token = (userToken as! [String: String])["userToken"] {
            return token
        }
        return nil
    }
    
    func removePersistentUser() {
        UserDefaults.standard.removeObject(forKey: PERSISTENT_USER_TOKEN_KEY)
    }
    
    func mapTable(_ tableName: String, toClass: AnyClass) {
        var tableToClassMappings = [String: AnyClass]()
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: TABLE_CLASS_MAPPINGS_KEY) != nil {
            tableToClassMappings = userDefaults.value(forKey: TABLE_CLASS_MAPPINGS_KEY) as! [String : AnyClass]
        }
        tableToClassMappings[tableName] = toClass
        userDefaults.setValue(tableToClassMappings, forKey: TABLE_CLASS_MAPPINGS_KEY)
        userDefaults.synchronize()
    }
    
    func getTableToClassMappings() -> [String: AnyClass]? {
        let userDefaults = UserDefaults.standard
        if let tableToClassMappings = userDefaults.value(forKey: TABLE_CLASS_MAPPINGS_KEY) {
            print(tableToClassMappings)
        }
        return nil
    }
}

