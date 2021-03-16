//
//  LaunchViewController.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxCocoa
import RxSwift

public class LaunchViewController: NiblessViewController {
    
    // MARK: - Properties
    let viewModel: LaunchViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(launchViewModel: LaunchViewModel) {
        self.viewModel = launchViewModel
        super.init()
    }
    
    public override func loadView() {
        view = LaunchView(viewModel: viewModel)
    }
}
