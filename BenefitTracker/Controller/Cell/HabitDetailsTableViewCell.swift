//
//  HabitDetailsTableViewCell.swift
//  BenefitTracker
//
//  Created by Valery Shel on 21.11.2020.
//

import UIKit

final class HabitDetailsTableViewCell: UITableViewCell {
    
    private lazy var titleHabit: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func configure(_ index: Int) {
        titleHabit.text = HabitsStore.shared.trackDateString(forIndex: index)
    }
    
    func setupLayout() {
        contentView.addSubviews(titleHabit)
        
        let constraints = [
            titleHabit.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)

    }

}
