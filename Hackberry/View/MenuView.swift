//
//  MenuView.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-05.
//

import UIKit

protocol MenuViewDelegate: class {
    func navigateTo(_ contoller: UIViewController)
}

final class MenuView: UIView {
    
    //MARK: - Properties
    
    private var options: [MenuOptions] = [.mobile, .analytics, .workHere, .aboutUs, .contact, .language(.swedish)]
    
    private lazy var tableView: UITableView = {
        var view = UITableView()
        view.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.reuseID)
        return view
    }()
    
    weak var delegate: MenuViewDelegate?
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    fileprivate func configure() {
        alpha = 0
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
        tableView.addConstraintsToFillView(self)
    }
}

//MARK: - UITableViewDataSource

extension MenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseID, for: indexPath) as! MenuTableViewCell
        cell.option = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = frame.height / 6
        return height
    }
}

//MARK: - UITableViewDelegate

extension MenuView {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = options[indexPath.row].controller
        delegate?.navigateTo(page)
    }
}


