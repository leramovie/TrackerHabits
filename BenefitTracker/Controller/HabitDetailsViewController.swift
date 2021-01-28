//
//  HabitDetailsViewController.swift
//  BenefitTracker
//
//  Created by Valery Shel on 21.11.2020.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    var habit: CustomHabit? {
        didSet {
            guard let habit = habit else { return }
            title = habit.habit.name
        }
    }
    
    
    //MARK: Bar button items
    private lazy var editButton: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(goToEditingHabits))
        return item
    }()
    
    private lazy var tableView: UITableView = {
            let table = UITableView(frame: .zero, style: .grouped)
            table.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: HabitDetailsTableViewCell.self))
            table.dataSource = self
            table.delegate = self
            table.showsVerticalScrollIndicator = false
                
            return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = editButton
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubviewWithAutoLayout(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func goToEditingHabits() {
        let habitVC = HabitViewController(isInEditMode: true)
        habitVC.habit = habit
        habitVC.habitsDetailVC = self

        let habitNC = UINavigationController(rootViewController: habitVC)
        habitNC.modalPresentationStyle = .fullScreen
        
        present(habitNC, animated: true, completion: nil)
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
}


extension HabitDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HabitDetailsTableViewCell.self), for: indexPath) as! HabitDetailsTableViewCell

        let date = HabitsStore.shared.dates[indexPath.row]

        cell.configure(indexPath.item)
    
        if HabitsStore.shared.habit(habit!.habit, isTrackedIn: date) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
