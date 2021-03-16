//
//  MainViewModel.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import Foundation
import RxSwift

public class MainViewModel: AuthResponder {
    
    // MARK: - Properties
    public var view: Observable<MainViewState> { return viewSubject.asObservable() }
    private let viewSubject = BehaviorSubject<MainViewState>(value: .launch)
    
    // MARK: - Methods
    public init() {}
    
    public func goToLaunch() {
        viewSubject.onNext(.launch)
    }
    
    public func goToWelcome() {
        viewSubject.onNext(.welcome)
    }
    
    public func goToHome(profile: UserProfile) {
        viewSubject.onNext(.home(profile: profile))
    }
    
}
