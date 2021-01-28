//
//  HabbitViewController.swift
//  BenefitTracker
//
//  Created by Valery Shel on 15.11.2020.
//

import UIKit

final class HabitViewController: UIViewController {
    
    var habit: CustomHabit?
    var habitsDetailVC: HabitDetailsViewController?
    var isInEditMode: Bool?

    //MARK: NAvigationBar Items
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Отменить"
        button.style = .plain
        button.target = self
        button.action = #selector(cancel)

        return button
    }()
    
    private lazy var createButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = "Создать"
        button.style = .plain
        button.target = self
        button.action = #selector(add)

        return button
    }()
    
    
    //MARK: Items for creating new habit
    let habitItemsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var inputHeader: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return textField
    }()
    
    private lazy var deleteHabit: UIButton = {
        let button = UIButton()
               button.isHidden = true
               button.isUserInteractionEnabled = true
               button.setTitle("Удалить привычку", for: .normal)
               button.setTitleColor(.systemRed, for: .normal)
               button.addTarget(self, action: #selector(deleteHabitButton), for: .touchUpInside)
               return button
    }()
    
    private lazy var colorHeader: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        return label
    }()
    
    private lazy var colorPicker: UIColorWell = {
        let picker = UIColorWell()
        
        return picker
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private lazy var timeLabelDetail: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        
        return label
    }()
    
    private lazy var timeSelection: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.timeZone = .current
        
        return datePicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Создать"
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = cancelButton
        navigationItem.leftBarButtonItem = createButton
        
        if let mode = isInEditMode {
            if isInEditMode == true {
                title = "Править"
                deleteHabit.isHidden = false

                setupLayout(mode)
                            
                if let habitToEdit = habit { setupEditMode(habitToEdit.habit) }
            } else {
                title = "Создать"
                
                setupLayout(mode)
            }
        }
    }
    
    init(isInEditMode: Bool) {
        self.isInEditMode = isInEditMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(_ isInEditMode: Bool) {
        view.addSubviews(habitItemsView,
                         deleteHabit)

        habitItemsView.addSubviews(inputHeader,
                                inputTextField,
                                colorHeader,
                                colorPicker,
                                timeLabel,
                                timeLabelDetail,
                                timeSelection)
        
        let constraints = [
            deleteHabit.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            deleteHabit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            habitItemsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitItemsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitItemsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            inputHeader.topAnchor.constraint(equalTo: habitItemsView.topAnchor, constant: 22),
            inputHeader.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),

            inputTextField.topAnchor.constraint(equalTo: inputHeader.bottomAnchor, constant: 7),
            inputTextField.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),

            colorHeader.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 15),
            colorHeader.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),

            colorPicker.topAnchor.constraint(equalTo: colorHeader.bottomAnchor, constant: 7),
            colorPicker.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),
            colorPicker.heightAnchor.constraint(equalToConstant: 30),
            colorPicker.widthAnchor.constraint(equalToConstant: 30),

            timeLabel.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),
            
            timeLabelDetail.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timeLabelDetail.leadingAnchor.constraint(equalTo: habitItemsView.leadingAnchor),
            timeLabelDetail.bottomAnchor.constraint(equalTo: habitItemsView.bottomAnchor, constant: -15),
            
            timeSelection.leadingAnchor.constraint(equalTo: timeLabelDetail.trailingAnchor, constant: 16),
            timeSelection.centerYAnchor.constraint(equalTo: timeLabelDetail.centerYAnchor),
            

        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupEditMode(_ habit: Habit) {
        colorPicker.selectedColor = habit.color
        inputHeader.text = habit.name
        inputHeader.font = .systemFont(ofSize: 20, weight: .bold)
        inputHeader.textColor = .systemBlue
        timeSelection.date = habit.date
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func add() {
        
        guard let newTask = inputTextField.text else { return }
        guard let colorSelected = colorPicker.selectedColor else { return }
        
        let newHabit = Habit(name: newTask,
                             date: timeSelection.date,
                             color: colorSelected)
        
        if isInEditMode == true {
            guard let habit = habit else {return}
            editHabit(newHabit, atIndex: habit.index)
        } else {
            let habitStore = HabitsStore.shared
            habitStore.habits.append(newHabit)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func editHabit(_ habit: Habit, atIndex index: Int) {
            HabitsStore.shared.habits[index].name = habit.name
            HabitsStore.shared.habits[index].date = habit.date
            HabitsStore.shared.habits[index].color = habit.color
    }
    
    @objc private func deleteHabitButton() {
        guard let habit = habit else { return }
                
        let alertController = UIAlertController(title: "Удаление привычки",
                                                message: "Вы дествительно хотите удалить привычку \"\(String(describing: habit.habit.name))\"",
                                                preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            HabitsStore.shared.habits.remove(at: habit.index)
            
            self.habitsDetailVC?.navigationController?.popViewController(animated: true)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}
