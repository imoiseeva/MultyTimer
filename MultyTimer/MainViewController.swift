//
//  ViewController.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 02.07.2021.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
 
    var tableView = UITableView()

   // private var arrayTimets: [Timers] = []
    var realTimer = Timer()
    var totalSecond = 10
    private var timer = StorageManager.shared.fetchData()
    
    private var addTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавление таймеров"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var nameOfTimer: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Название таймера",
                                                             attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 10.0)!])
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var timeInSeconds: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Время в секудах"
        textField.attributedPlaceholder = NSAttributedString(string: "Время в секудах",
                                                             attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 10.0)!])
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var buttonAdd: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.809979856, green: 0.8100972176, blue: 0.809954226, alpha: 1)
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Таймеры"
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupIUElements()
        setConstraints()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        title = "Мульти таймер"
        
        let navBarApearence = UINavigationBarAppearance()
        navBarApearence.configureWithOpaqueBackground()
        navBarApearence.backgroundColor = UIColor(
            red: 192/255,
            green: 192/255,
            blue: 192/255,
            alpha: 194/255
        )
        navigationController?.navigationBar.standardAppearance = navBarApearence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApearence
    }
    
   private func setupIUElements() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.separatorStyle = .singleLine
        tableView.frame = .zero
        
        view.addSubview(tableView)
        view.addSubview(addTimerLabel)
        view.addSubview(nameOfTimer)
        view.addSubview(timeInSeconds)
        view.addSubview(buttonAdd)
        view.addSubview(timerLabel)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            addTimerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            nameOfTimer.topAnchor.constraint(equalTo: addTimerLabel.bottomAnchor, constant: 10),
            nameOfTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            nameOfTimer.widthAnchor.constraint(equalToConstant: 200),
            nameOfTimer.heightAnchor.constraint(equalToConstant: 20),
            
            timeInSeconds.topAnchor.constraint(equalTo: nameOfTimer.bottomAnchor, constant: 10),
            timeInSeconds.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            timeInSeconds.widthAnchor.constraint(equalToConstant: 200),
            timeInSeconds.heightAnchor.constraint(equalToConstant: 20),
            
            buttonAdd.topAnchor.constraint(equalTo: timeInSeconds.bottomAnchor, constant: 20),
            buttonAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17),
            
            timerLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            
            tableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func saveButton() {
   
        guard let timerName = nameOfTimer.text else { return }
        guard let seconds = timeInSeconds.text else { return }
            
            StorageManager.shared.save(timerName, seconds) { timerNewItem in
                self.timer.append(timerNewItem)
                self.tableView.insertRows(
                    at: [IndexPath(row: self.timer.count - 1, section: 0)],
                    with: .automatic
                )
        }
        
        startTimer()

        nameOfTimer.text = nil
        timeInSeconds.text = nil
    }
}

// MARK: - Table View Delegate and DataSourse protocols

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(Cell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Cell
        
        var content = cell.defaultContentConfiguration()
        let item = timer[indexPath.row]
        content.text = item.timersName
        content.secondaryText = item.seconds
        content.prefersSideBySideTextAndSecondaryText = true
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDelegate
extension MainViewController {
    
    // Delete task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = timer[indexPath.row]
        
        if editingStyle == .delete {
            timer.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(task)
        }
    }
}

// MARK: - Timer
extension MainViewController {
    
    func startTimer() {
        
        realTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime(data: Timers, index: IndexPath){
     guard var time = data.seconds else { return }
     totalSecond = Int(time)!
     print(timeFormatted(totalSecond))
        time = String(timeFormatted(totalSecond))
     if totalSecond != 0 {
         totalSecond -= 1
     } else {
         endTimer()
     }
 }
    
    func endTimer() {
        realTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "0:%02d", seconds)
    }
    
}
