//
//  HomeView.swift
//  SmartyHomeIOS
//
//  Created by Macbook Pro 2017 on 14/03/2021.
//

import UIKit
import SmartyHomeUIKit
import SmartyHomeKit
import RxSwift
import RxCocoa

class HomeView: NiblessView {
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    var _hierarchyNotReady = true
    let disposeBag = DisposeBag()
    
    // MARK: View Components
    let roomsList: UITableView = {
        let table = UITableView()
        table.register(RoomCell.self, forCellReuseIdentifier: "Cell")
        table.estimatedRowHeight = 170
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    public override func didMoveToWindow() {
        super.didMoveToWindow()
        guard _hierarchyNotReady else {
            return
        }
        backgroundColor = UIColor(named: "Smarty_light_blue")
        constructHierarchy()
        activateConstraints()
        _hierarchyNotReady = false
    }
    
    func constructHierarchy() {
        inputTableView()
        addSubview(roomsList)
    }
    
    func activateConstraints() {
        activateConstraintsAppLogo()
    }
    
    func activateConstraintsAppLogo() {
        roomsList.translatesAutoresizingMaskIntoConstraints = false
        let centerX = roomsList.centerXAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        let centerY = roomsList.centerYAnchor
            .constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        let width = roomsList.widthAnchor
            .constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -40)
        let height = roomsList.heightAnchor
            .constraint(equalTo: safeAreaLayoutGuide.heightAnchor, constant: -20)
        NSLayoutConstraint.activate([centerX, centerY, width, height])
    }
    
    /**
        Bind table view delegate and data source
     */
    func inputTableView() {
        // Set tableview delegate. (for setting table view cell height)
        roomsList.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
            
        // Bind data and tableview
        self.viewModel.rooms.asObservable()
            .bind(to: roomsList.rx
                .items(cellIdentifier: "Cell", cellType: RoomCell.self))
            { index, room, cell in
                // Write image, name and devices for cell label.
                cell.setup(with: room)
        }.disposed(by: disposeBag)
            
        roomsList.tableHeaderView = HeaderView(name: self.viewModel.profile.name, frame: CGRect(x: 0, y: 0, width: 300, height: 80))
    }

}

extension HomeView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
