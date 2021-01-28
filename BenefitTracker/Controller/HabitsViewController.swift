//
//  HabitsViewController.swift
//  BenefitTracker
//
//  Created by Valery Shel on 08.11.2020.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    //MARK: Navigation item
    private lazy var addHabbitButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.style = .plain
        button.target = self
        button.action = #selector(addNewTask)

        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: ProgressCollectionViewCell.reuseIdentifier))
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.reuseIdentifier))
        collectionView.backgroundColor = UIColor(named: "DirtyWhite")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var removeHabits: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Очистить список"
        bbi.style = .plain
        bbi.target = self
        bbi.action = #selector(habitsRemoved)

        return bbi
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = addHabbitButton
        navigationItem.leftBarButtonItem = removeHabits
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @objc private func habitsRemoved() {
        let habitsStore = HabitsStore.shared
        habitsStore.habits.removeAll()
        
        collectionView.reloadData()
    }
    
    @objc func addNewTask() {
        let habitVC = UINavigationController(rootViewController: HabitViewController(isInEditMode: false))
        habitVC.modalPresentationStyle = .fullScreen
        present(habitVC, animated: true, completion: nil)
    }
    
    @objc private func flagHabitTapped(sender: TapGestureRecognizerWithIndex) {
        guard let indexItem = sender.indexPath else {return}
        
        let habit = HabitsStore.shared.habits[indexItem.item]
        
        if !habit.isAlreadyTakenToday {
            HabitsStore.shared.track(habit)
            
            let cell = collectionView.cellForItem(at: sender.indexPath!) as! HabitCollectionViewCell
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.autoreverse]) {
                UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0) {
                    cell.flagHabit.alpha = 1
                }
            } completion: { finished in }
        }
        collectionView.reloadData()
    }
    
    func setupLayout() {
        view.addSubviewWithAutoLayout(collectionView)
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}


extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let progressCell: ProgressCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProgressCollectionViewCell.reuseIdentifier), for: indexPath) as! ProgressCollectionViewCell
            
            progressCell.configure(HabitsStore.shared)
            
            return progressCell

        } else {
            let habitsCell: HabitCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.reuseIdentifier), for: indexPath) as! HabitCollectionViewCell
            
            habitsCell.habit = HabitsStore.shared.habits[indexPath.item]
           
            let tapGestureRecognizer = TapGestureRecognizerWithIndex(target: self, action: #selector(flagHabitTapped(sender:)))
            tapGestureRecognizer.indexPath = indexPath
            habitsCell.flagHabit.addGestureRecognizer(tapGestureRecognizer)
            
            return habitsCell
        }
    }
}
    

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 60)
        } else {
            let width = collectionView.bounds.width - 32
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        collectionView.deselectItem(at: indexPath, animated: true)
                
        if indexPath.section == 0 {
            return
        } else {
            let habitDetailsVC = HabitDetailsViewController()
            let habit = CustomHabit(habit: HabitsStore.shared.habits[indexPath.item], index: indexPath.item)
            habitDetailsVC.habit = habit
            
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
}

