//
//  WelcomeViewModel.swift
//  SmartyHomeKit
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import RxSwift

public class WelcomeViewModel {
    
    // MARK: - Repositories
    private let authRepository: AuthentificationRepository
    
    // MARK: - Responder
    let authResponder: AuthResponder
    
    // MARK: - Observables
    public let nameInput = BehaviorSubject<String>(value: "")
    public let nameInputEnabled = BehaviorSubject<Bool>(value: true)
    public var errorMessages: Observable<ErrorMessage> {
        return errorMessagesSubject.asObserver()
    }
    public let errorMessagesSubject = PublishSubject<ErrorMessage>()
    
    // MARK: - Methods
    public init(authRepository: AuthentificationRepository, authResponder: AuthResponder) {
        self.authRepository = authRepository
        self.authResponder = authResponder
    }
    
    @objc
    public func connect() {
        indicateConnnection()
        let name = getName()
        let message = errorMessage(name: name)
        if message == "" {
            authRepository.connect(profile: UserProfile(name: name))
                .done({ profile in
                    self.indicateEndConnection()
                    self.authResponder.goToHome(profile: profile)
                })
                .catch(indicateErrorConnecting)
        }else{
            errorMessagesSubject.onNext(ErrorMessage(title: NSLocalizedString("failed_connection", comment: "Failed connection message"),message: message))
            indicateEndConnection()
        }
    }
    
    func indicateConnnection() {
        nameInputEnabled.onNext(false)
    }
    
    func indicateEndConnection() {
        nameInputEnabled.onNext(true)
    }
    
    func getName() -> String {
        do {
            let name = try nameInput.value()
            return name
        } catch {
            fatalError(NSLocalizedString("reading_behavior_error", comment: "reading behavior error"))
        }
    }
    
    func indicateErrorConnecting(_ error: Error) {
        nameInputEnabled.onNext(true)
    }
    
    func errorMessage(name: String) -> String {
        var message = ""
        if name == "" {
            message = NSLocalizedString("empty_field_message", comment: "Empty Field message")
            return message
        }
        return message
    }
}
