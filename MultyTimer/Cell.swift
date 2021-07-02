//
//  Cell.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 02.07.2021.
//

import UIKit

class Cell: UITableViewCell {
    
    private let offset: CGFloat = 16
    private let width: CGFloat = 50
    
    var timer: Model? {
        didSet {
            nameOfTimer.text = timer?.timerName
            time.text = timer?.time
        }
    }
    
    private var nameOfTimer: UILabel = {
        let label = UILabel()
        label.text = "Timer1"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var time: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupSubvies() {
        [nameOfTimer, time].forEach {
            contentView.addSubview($0)
        }
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            nameOfTimer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            nameOfTimer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            time.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            time.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
    
    func configureCell(data: Model) {
        nameOfTimer.text = data.timerName
        time.text = data.time

    }
    
}
