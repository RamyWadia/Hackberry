//
//  MenuTableViewCell.swift
//  Hackberry
//
//  Created by Ramy Atalla on 2020-12-05.
//

import UIKit

final class MenuTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let reuseID = "reuseID"
    
    var option: MenuOptions! {
        didSet { configure() }
    }
    
    private var label = HeadLabel(text: "", font: .boldSystemFont(ofSize: 18))
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    fileprivate func configure() {
        selectionStyle = .none
        label.text = option.text
        label.textColor = .systemGray
    }
    
    fileprivate func configureUI() {
        addSubview(label)
        backgroundColor = .white
        label.center(inView: self)
    }
}
