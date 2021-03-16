//
//  AuthentificationRepository.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import PromiseKit

public protocol AuthentificationRepository {
    func connect(profile: UserProfile) -> Promise<UserProfile>
    func readUserSession() -> Promise<UserProfile?>
}
