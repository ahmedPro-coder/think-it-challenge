//
//  MainViewController.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit
import SmartyHomeKit
import SmartyHomeUIKit
import RxSwift

public class MainViewController: NiblessViewController {
    
    // MARK: - Properties
    // Main view Model
    let viewModel: MainViewModel
    
    // Child View Controllers
    let launchViewController: LaunchViewController
    var _welcomeViewController: WelcomeViewController?
    var _homeViewController: HomeViewController?
    
    // DisposeBag for State
    let disposeBag = DisposeBag()
    
    // Factory
    let mainFactory: MainFactory
    
    // MARK: - Methods
    init(viewModel: MainViewModel,
         mainFactory: MainFactory) {
        self.viewModel = viewModel
        self.mainFactory = mainFactory
        self.launchViewController = mainFactory.makeLaunchViewController()
        super.init()
        self.viewModel.goToLaunch()
    }
    
    /**
     Subscribing to the view state provided by the main view model
     */
    func subscribe(to observable: Observable<MainViewState>) {
        observable
            .subscribe(onNext: { [weak self] view in
                guard let strongSelf = self else { return }
                strongSelf.present(view)
            })
            .disposed(by: disposeBag)
    }
    
    /**
     Presenting appropriate view based on the main view state
     */
    private func present(_ view: MainViewState) {
        switch view {
        case .launch:
            presentLaunching()
        case .welcome:
            presentWelcome()
        case .home(let profile):
            presentHome(profile: profile)
        }
    }
    
    private func presentLaunching() {
        addFullScreen(childViewController: launchViewController)
    }
    
    private func presentWelcome() {
        remove(childViewController: launchViewController)
        let welcomeViewControllerToPresent = mainFactory.makeWelcomeViewController()
        self._welcomeViewController = welcomeViewControllerToPresent
        addFullScreen(childViewController: welcomeViewControllerToPresent)
    }
    
    private func presentHome(profile: UserProfile) {
        remove(childViewController: launchViewController)
        let homeViewControllerToPresent = mainFactory.makeHomeViewController(with: profile)
        self._homeViewController = homeViewControllerToPresent
        addFullScreen(childViewController: homeViewControllerToPresent)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    /**
        Observing viewModel events
     */
    private func observeViewModel() {
        let observable = viewModel.view.distinctUntilChanged()
        subscribe(to: observable)
    }
}
