//
//  MainViewController.swift
//  MiniApps
//
//  Created by Арсен Дадаев on 06.09.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    var presenter: MainPresenter
    private var isDetailMode: Bool = true
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.Identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
}

// MARK: Private methods
private extension MainViewController {
    func initialize() {
        self.view.backgroundColor = .white
        self.navigationItem.title = Consts.UIConsts.mainListTitle
        addToggleButton()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func addToggleButton() {
        let toggleButton = UIBarButtonItem(title: Consts.UIConsts.switchButton, style: .plain, target: self, action: #selector(toggleMode))
        self.navigationItem.rightBarButtonItem = toggleButton
    }

    @objc func toggleMode() {
        isDetailMode.toggle()
        tableView.reloadData()
    }
}

// MARK: - MainView
extension MainViewController: MainView {
    func displayMiniApps(_ miniApps: [MiniAppModel]) {
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.miniAppCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.Identifier, for: indexPath) as! MainViewCell
        let miniApp = presenter.miniAppSelected(at: indexPath.row)
        
        cell.configure(with: miniApp.title, type: miniApp.type, mode: isDetailMode)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isDetailMode {
            tableView.deselectRow(at: indexPath, animated: true)
            presenter.didSelectMiniApp(at: indexPath.row)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isDetailMode ? self.view.frame.height / 2 : self.view.frame.height / 8
    }
}
