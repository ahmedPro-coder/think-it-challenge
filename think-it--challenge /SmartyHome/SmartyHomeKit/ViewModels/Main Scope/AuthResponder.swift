//
//  AuthResponder.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//


public protocol NotSignedInResponder {
    
    func goToWelcome()
    
}

public protocol SignedInResponder {
    
    func goToHome(profile: UserProfile)
    
}

/**
    Responder protocol for authentification
 */
public protocol AuthResponder: SignedInResponder, NotSignedInResponder {
}
