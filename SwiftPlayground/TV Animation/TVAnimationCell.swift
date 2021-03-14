//
//  TVAnimationCell.swift
//  SwiftPlayground
//
//  Created by Marchell on 13/03/21.
//

import UIKit

class TVAnimationCell: UITableViewCell {
    
    var backView: UIView!
    var colorView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupUI() {
        backView = UIView()
        backView.backgroundColor = .clear
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 50),
            backView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        colorView = UIView()
        colorView.backgroundColor = .blue
        colorView.layer.cornerRadius = 10
        colorView.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(colorView)
        
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 5),
            colorView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: 20),
            colorView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            colorView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 5),
        ])
    }
}
