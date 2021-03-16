//
//  MockRemoteAuthApi.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public class MockRemoteAuthApi: RemoteAuthApi {
    
    // MARK: - Methods
    public init(){}
    
    public func connect(profile: UserProfile) -> Promise<UserProfile> {
        return Promise { seal in
            let defaults = UserDefaults.standard
            defaults.set(profile.name, forKey: "Profile")
            seal.fulfill(profile)
        }
    }
}
