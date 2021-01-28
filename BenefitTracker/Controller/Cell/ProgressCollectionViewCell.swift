//
//  ProgressCollectionViewCell.swift
//  BenefitTracker
//
//  Created by Valery Shel on 15.11.2020.
//

import UIKit

final class ProgressCollectionViewCell: UICollectionViewCell {
    
    private let habitTodayProgress = HabitsStore.shared
    
    static let reuseIdentifier = "ProgressCollectionViewCell"
    
    private lazy var habitsStore = HabitsStore.shared
    
    private lazy var encouragingLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.textColor = UIColor(named: "SystemGray2")
        label.font = UIFont(name: "FontsFree-Net-SFProDisplay-Semibold", size: 13)
        
        return label
    }()
    
    private lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = habitTodayProgress.todayProgress
        progress.backgroundColor = UIColor(named: "silver_light")
        progress.layer.cornerRadius = 4
        
        return progress
    }()
    
    private lazy var percent: UILabel = {
        let label = UILabel()
        label.text = String(describing: "\(Int(habitTodayProgress.todayProgress))%")
        label.textColor = UIColor(named: "SystemGray2")
        label.font = UIFont(name: "FontsFree-Net-SFProDisplay-Semibold", size: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        setupLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ habitsStore: HabitsStore) {
        progress.setProgress(habitsStore.todayProgress, animated: true)
        percent.text = String(describing: "\(Int(habitsStore.todayProgress * 100))%")
    }
    
    
}


private extension ProgressCollectionViewCell {
    func setupLayout() {
        
        contentView.addSubviews(encouragingLabel,
                                progress,
                                percent )
            
        let constraints = [
            encouragingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            encouragingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),

            progress.topAnchor.constraint(equalTo: encouragingLabel.bottomAnchor, constant: 10),
            progress.leadingAnchor.constraint(equalTo: encouragingLabel.leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            progress.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            progress.heightAnchor.constraint(equalToConstant: 7),
            progress.widthAnchor.constraint(equalToConstant: 60),
            
            percent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            percent.topAnchor.constraint(equalTo: encouragingLabel.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}

