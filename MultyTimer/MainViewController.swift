//
//  ViewController.swift
//  MultyTimer
//
//  Created by Irina Moiseeva on 02.07.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var tableView = UITableView()
    
    var countOfNumbers: [Model] = [Model]()
    
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
       // button.frame.size.width = 400
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addTimer), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
              createArray()
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

    func setupIUElements() {
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.tableFooterView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.frame = .zero
        
        view.addSubview(tableView)
        view.addSubview(addTimerLabel)
        view.addSubview(nameOfTimer)
        view.addSubview(timeInSeconds)
        view.addSubview(buttonAdd)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            addTimerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            nameOfTimer.topAnchor.constraint(equalTo: addTimerLabel.bottomAnchor, constant: 10),
            nameOfTimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameOfTimer.widthAnchor.constraint(equalToConstant: 200),
            nameOfTimer.heightAnchor.constraint(equalToConstant: 20),
            
            
            timeInSeconds.topAnchor.constraint(equalTo: nameOfTimer.bottomAnchor, constant: 10),
            timeInSeconds.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timeInSeconds.widthAnchor.constraint(equalToConstant: 200),
            timeInSeconds.heightAnchor.constraint(equalToConstant: 20),
            
            buttonAdd.topAnchor.constraint(equalTo: timeInSeconds.bottomAnchor, constant: 15),
            buttonAdd.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            buttonAdd.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //buttonAdd.widthAnchor.constraint(equalToConstant: 250),
        
            
            
            tableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func addTimer() {
        
    }

}

// MARK: - Table View Delegate and DataSourse protocols

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(Cell.self, forCellReuseIdentifier: "MyCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Cell

       var content = cell.defaultContentConfiguration()
        let item = countOfNumbers[indexPath.row]
        content.text = item.timerArray[indexPath.row]
        content.secondaryText = item.secondsArray[indexPath.row]
        content.prefersSideBySideTextAndSecondaryText = true
        cell.contentConfiguration = content
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countOfNumbers.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func createArray() {
        countOfNumbers.append(Model(timerName: "1", time: "30"))
        countOfNumbers.append(Model(timerName: "2", time: "30"))
        countOfNumbers.append(Model(timerName: "3", time: "30"))
        countOfNumbers.append(Model(timerName: "4", time: "30"))
        countOfNumbers.append(Model(timerName: "5", time: "30"))
    }
}
