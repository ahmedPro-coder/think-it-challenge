//
//  LaunchViewModel.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

import Foundation
import PromiseKit
import RxSwift
import RxCocoa

struct LaunchConstants {
    public static let kDuration: Int = 3
}

public class LaunchViewModel {
    
    // MARK: - Properties
    // MARK: - ViewModel Constants
    let authRepository: AuthentificationRepository
    let authResponder: AuthResponder
    let disposeBag = DisposeBag()
    
    public var errorMessages: Observable<ErrorMessage> {
        return self.errorMessagesSubject.asObserver()
    }
    private let errorMessagesSubject: PublishSubject<ErrorMessage> =
        PublishSubject()
    
    private let sessionSubject = BehaviorRelay<UserProfile?>(value: nil)
    private let sessionLoadingObserver = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Methods
    public init(authRepository: AuthentificationRepository,
                authResponder: AuthResponder) {
        self.authRepository = authRepository
        self.authResponder = authResponder
        // setup minimum delay of KDuration before going to next screen
        sessionLoadingObserver.distinctUntilChanged().delaySubscription(.seconds(LaunchConstants.kDuration), scheduler: MainScheduler.instance).subscribe(onNext: {
            if $0 {
                self.goToNextScreen()
            }
        }).disposed(by: disposeBag)
        self.loadUserSession()
    }
    
    /**
      Check for user in cache
    */
    public func loadUserSession() {
        self.authRepository.readUserSession()
            .done({ (session) in
                guard let session = session else { return }
                self.sessionSubject.accept(session)
                self.sessionLoadingObserver.accept(true)
            }).catch { error in
                self.sessionSubject.accept(nil)
                self.sessionLoadingObserver.accept(true)
            }
    }
    
    /**
        Redirecting to appropriate screen after user check
     */
    public func goToNextScreen() {
        switch self.sessionSubject.value {
        case .none:
            authResponder.goToWelcome()
        case .some(let profile):
            authResponder.goToHome(profile: profile)
        }
    }
}

