//
//  WelcomeView.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxSwift
import RxCocoa

public class WelcomeView: NiblessView {
    
    // MARK: - Properties
    let viewModel: WelcomeViewModel
    var _hierarchyNotReady = true
    let disposeBag = DisposeBag()
    
    // MARK: View Components
    private let containerView = UIScrollView()
    let contentView: UIView = UIView()
    let appLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var elementsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, nameTextField, submitButton])
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 17
        return stack
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("app_title", comment: "app title")
        label.textColor = UIColor(named: "Smarty_dark_blue")
        label.font = UIFont(name: "Arial", size: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 39).isActive = true
        label.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("welcome_title", comment: "welcome title")
        label.textColor = UIColor(named: "Smarty_gray")
        label.font = UIFont(name: "Arial", size: 20)//.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.widthAnchor.constraint(equalToConstant: 160).isActive = true
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("name_placeholder", comment: "name textfield placeholder"),
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Smarty_gray") ?? .gray])
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont(name: "Arial", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        return textField
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("submit_button_title", comment: "button title"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor(named: "Smarty_light_blue"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 55)
            .isActive = true
        button.widthAnchor.constraint(equalToConstant: 160)
            .isActive = true
        button.titleLabel?.font = UIFont(name: "Arial", size: 18)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "Smarty_blue")
        return button
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        registerForKeyboardNotifications(scrollView: containerView)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard _hierarchyNotReady else {
            return
        }
        backgroundColor = UIColor(named: "Smarty_light_blue")
        constructHierarchy()
        activateConstraints()
        wireController()
        bindToViewModel()
        _hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        contentView.addSubview(elementsStack)
        contentView.addSubview(appLogoImageView)
        containerView.addSubview(contentView)
        addSubview(containerView)
    }
    
    func activateConstraints() {
        activateConstraintsContainerView()
        activateConstraintsContentView()
        activateConstraintsElementsStack()
        activateConstraintsAppLogo()
    }
    
    func activateConstraintsContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let width = containerView.widthAnchor.constraint(equalTo: widthAnchor)
        let centerX = containerView.centerXAnchor.constraint(equalTo: centerXAnchor)
        let top = containerView.topAnchor.constraint(equalTo: topAnchor)
        let bottom = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate(
            [centerX, width, top, bottom])
    }
    
    func activateConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let width = contentView.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        let height = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        let centerX = contentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = contentView.topAnchor.constraint(equalTo: containerView.topAnchor)
        let bottom = contentView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate(
            [centerX, width, top, bottom, height])
    }
    
    func activateConstraintsElementsStack() {
        elementsStack.translatesAutoresizingMaskIntoConstraints = false
        let left = elementsStack.leftAnchor
            .constraint(equalTo: contentView.leftAnchor, constant: 70)
        let right = elementsStack.rightAnchor
            .constraint(equalTo: contentView.rightAnchor, constant: -70)
        let bottom = elementsStack.bottomAnchor
            .constraint(equalTo: contentView.bottomAnchor, constant: -40)
        let height = elementsStack.heightAnchor
            .constraint(equalToConstant: 210)
        NSLayoutConstraint.activate([left, right, bottom, height])
    }
    
    func activateConstraintsAppLogo() {
        appLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = appLogoImageView.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        appLogoImageView.widthAnchor
            .constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        let height = appLogoImageView.heightAnchor
            .constraint(equalTo: appLogoImageView.widthAnchor)
        let bottom = appLogoImageView.bottomAnchor
            .constraint(equalTo: elementsStack.topAnchor, constant: -20)
        NSLayoutConstraint.activate([centerX, height, bottom])
    }
    
    func wireController() {
        submitButton.addTarget(viewModel, action: #selector(WelcomeViewModel.connect), for: .touchUpInside)
    }
    
    //MARK: Binding functions
    func bindToViewModel() {
        bindNameField()
        bindViewModelToNameField()
    }
    
    func bindNameField() {
        nameTextField.rx.text
            .asDriver()
            .map { $0 ?? "" }
            .drive(viewModel.nameInput)
            .disposed(by: disposeBag)
    }
    
    func bindViewModelToNameField() {
        viewModel
            .nameInputEnabled
            .asDriver(onErrorJustReturn: true)
            .drive(nameTextField.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
