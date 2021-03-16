//
//  SmartyHomeAuthentificationRepository.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public class SmartyHomeAuthentificationRepository: AuthentificationRepository {
    
    // MARK: - Properties
    var _remoteAPI: RemoteAuthApi
    
    // MARK: - Methods
    public init(remoteAPI: RemoteAuthApi) {
        self._remoteAPI = remoteAPI
    }
    
    public func connect(profile: UserProfile) -> Promise<UserProfile> {
        return _remoteAPI.connect(profile: profile)
    }
    
    public func readUserSession() -> Promise<UserProfile?> {
//        return dataStore.readUserSession()
        return Promise { seal in
            let defaults = UserDefaults.standard
            if let name = defaults.string(forKey: "Profile") {
                seal.fulfill(UserProfile(name: name))
            }else {
                seal.reject(NSError(domain:"unkown_repo_error", code: 0))
            }
        }
    }
    
}
