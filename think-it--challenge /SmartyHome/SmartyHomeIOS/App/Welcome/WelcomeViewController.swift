//
//  WelcomeViewController.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxSwift
import RxCocoa

public class WelcomeViewController: NiblessViewController {
    
    // MARK: - Properties
    let welcomeViewModel: WelcomeViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(welcomeViewModel: WelcomeViewModel) {
        self.welcomeViewModel = welcomeViewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        subscribe(to: welcomeViewModel.errorMessages)
    }
    
    public override func loadView() {
        view = WelcomeView(viewModel: welcomeViewModel)
    }
    
    /**
     Subscribing to the error provided by the view model
     */
    func subscribe(to observable: Observable<ErrorMessage>) {
        observable
            .subscribe(onNext: { [weak self] error in
                guard let strongSelf = self else { return }
                strongSelf.presentError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    func presentError(error: ErrorMessage) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ok_button_title", comment: "button title"), style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
