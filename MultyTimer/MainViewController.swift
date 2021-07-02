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
    
 // var dataFromModel = Model()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        setupNavigationBar()
        setupIUElements()
        setConstraints()
        
//        if countOfNumbers.isEmpty {
//            countOfNumbers = Array(repeating: dataFromModel, count: dataFromModel.timerArray.count)
//        }
            // tableView.reloadData()
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
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
