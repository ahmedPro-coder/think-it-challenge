//
//  HeaderView.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

import UIKit
import SmartyHomeKit

public class HeaderView: UIView {
    //MARK: - Properties
    private var _hierarchyNotReady = true
    
    // MARK: view components
    let containerView: UIView = UIView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Bold", size: 32)
        label.textColor = UIColor(named: "Smarty_dark_blue")
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 16)
        label.textAlignment = .left
        label.textColor = UIColor(named: "Smarty_gray")
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dateLabel, self.nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }()
    
    //MARK: - Methods
    public init(name: String, frame: CGRect) {
        super.init(frame: frame)
        let formatString = NSLocalizedString("welcome_home_title", comment: "welcome user")
        let nameText = String.localizedStringWithFormat(formatString, name)
        nameLabel.text = nameText
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"
        let date = Date()
        let dateString = dateFormatterPrint.string(from: date)
        dateLabel.text = dateString.uppercased()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard self._hierarchyNotReady else { return }
        self.backgroundColor = .clear
        self.constructHierarchy()
        self.activateConstraints()
        self._hierarchyNotReady = false
    }
    
    private func constructHierarchy(){
        self.addSubview(self.contentStack)
    }
    
    private func activateConstraints() {
        activateContentConstraints()
    }
    
    private func activateContentConstraints() {
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }

}
