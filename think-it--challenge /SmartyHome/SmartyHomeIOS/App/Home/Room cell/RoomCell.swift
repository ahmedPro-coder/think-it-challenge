//
//  RoomCell.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 15/03/2021.
//

import UIKit
import SmartyHomeKit

public class RoomCell: UITableViewCell {
    //MARK: - Properties
    private var _hierarchyNotReady = true
    //MARK: view compoenents
    let containerView: UIView = UIView()
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial Bold", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let devicesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 14)
        label.textAlignment = .left
        label.textColor = UIColor(named: "Smarty_light_blue")
        return label
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel,
                                                       self.devicesLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    //MARK: - Methods
    public override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        devicesLabel.text = nil
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard self._hierarchyNotReady else { return }
        self.styleCell()
        self.constructHierarchy()
        self.activateConstraints()
        self._hierarchyNotReady = false
    }
    
    private func styleCell() {
        selectionStyle = .none
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        containerView.clipsToBounds = true
        
        // add corner radius on `contentView`
        contentView.layer.cornerRadius = 8
    }
    
    private func constructHierarchy(){
        backgroundImage.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
        self.containerView.addSubview(self.contentStack)
        self.contentView.addSubview(containerView)
    }
    
    private func activateConstraints() {
        activateContainerConstraints()
        activateContentConstraints()
        activateBackgroundConstraints()
    }
    
    private func activateContainerConstraints() {
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.containerView.topAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.containerView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    private func activateContentConstraints() {
        self.contentStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentStack.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 20.0).isActive = true
        self.contentStack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.contentStack.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -20.0).isActive = true
        self.contentStack.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -15).isActive = true
    }
    
    private func activateBackgroundConstraints() {
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
        self.backgroundImage.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        self.backgroundImage.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
        self.backgroundImage.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
    }
    
    /**
        Populate cell with room information
     */
    public func setup(with room: Room){
        self.nameLabel.text = room.name
        let formatString = NSLocalizedString("number_of_devices", comment: "number of devices")
        let resultString = String.localizedStringWithFormat(formatString, room.devices)
        self.devicesLabel.text = resultString
        self.backgroundImage.image = UIImage(named: room.picture)
    }
}
