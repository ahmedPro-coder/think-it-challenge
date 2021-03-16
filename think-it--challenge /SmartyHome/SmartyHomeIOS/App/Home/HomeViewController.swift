//
//  HomeViewController.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxSwift
import RxCocoa

public class HomeViewController: NiblessViewController {
    
    // MARK: - Properties
    let homeViewModel: HomeViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Methods
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func loadView() {
        view = HomeView(viewModel: homeViewModel)
    }
}
