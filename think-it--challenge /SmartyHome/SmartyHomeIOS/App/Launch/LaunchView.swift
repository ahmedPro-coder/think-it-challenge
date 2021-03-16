//
//  LaunchView.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxSwift
import RxCocoa

public class LaunchView: NiblessView {
    
    // MARK: - Properties
    let viewModel: LaunchViewModel
    var _hierarchyNotReady = true
    let disposeBag = DisposeBag()
    // MARK: View components
    let appLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard _hierarchyNotReady else {
            return
        }
        backgroundColor = .white
        constructHierarchy()
        activateConstraints()
        _hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        addSubview(appLogoImageView)
    }
    
    func activateConstraints() {
        activateConstraintsAppLogo()
    }
    
    func activateConstraintsAppLogo() {
    appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = appLogoImageView.centerXAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        let centerY = appLogoImageView.centerYAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        let width = appLogoImageView.widthAnchor
            .constraint(equalToConstant: 150)
        let height = appLogoImageView.heightAnchor
            .constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, centerY, width, height])
    }

}
