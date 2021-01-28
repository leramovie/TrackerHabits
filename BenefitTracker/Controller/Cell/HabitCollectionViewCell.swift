//
//  HabitCollectionViewCell.swift
//  BenefitTracker
//
//  Created by Valery Shel on 15.11.2020.
//

import UIKit

final class HabitCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "HabitCollectionViewCell"
    
    var habit: Habit? {
        didSet {
            guard let habit = habit else { return }
            configure(habit)
        }
    }
    
    private lazy var titleHabit: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    private lazy var descriptionHabit: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var counterHabit: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray

        return label
    }()
    
    lazy var flagHabit: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .none
        image.isUserInteractionEnabled = true
    
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        
        setupLayout()
    }
    

    func configure(_ habit: Habit) {
       
        titleHabit.text = habit.name
        titleHabit.textColor = habit.color
        descriptionHabit.text = habit.dateString
        counterHabit.text = String("Подряд \(habit.trackDates.count)")
        
        if habit.isAlreadyTakenToday {
            flagHabit.tintColor = habit.color
            flagHabit.alpha = 1
            flagHabit.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            flagHabit.tintColor = habit.color
            flagHabit.alpha = 1
            flagHabit.image = UIImage(systemName: "circle")
        }
    }
    
    func setupLayout() {
        contentView.addSubviews(titleHabit,
                                descriptionHabit,
                                counterHabit,
                                flagHabit)
        
        let constraints = [
            titleHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleHabit.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionHabit.topAnchor.constraint(equalTo: titleHabit.bottomAnchor, constant: 4),
            descriptionHabit.leadingAnchor.constraint(equalTo: titleHabit.leadingAnchor),
            
            counterHabit.topAnchor.constraint(equalTo: descriptionHabit.bottomAnchor, constant: 30),
            counterHabit.leadingAnchor.constraint(equalTo: titleHabit.leadingAnchor),
            counterHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            flagHabit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 47),
            flagHabit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
            flagHabit.widthAnchor.constraint(equalToConstant: 36),
            flagHabit.heightAnchor.constraint(equalToConstant: 36),
            flagHabit.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -47)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
