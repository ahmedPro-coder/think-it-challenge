//
//  MainFactory.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import SmartyHomeKit

/**
    Factory Protocol for Main Scope
 */
protocol MainFactory {
    func makeLaunchViewController() -> LaunchViewController
    func makeWelcomeViewController() -> WelcomeViewController
    func makeHomeViewController(with profile: UserProfile) -> HomeViewController
}
