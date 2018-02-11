//
//  ViewController.swift
//  BookExcite
//
//  Created by Impresyjna on 28.01.2018.
//  Copyright © 2018 Impresyjna. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: Model

final class TaskList: Object {
    @objc dynamic var text = ""
    @objc dynamic var id = ""
    let items = List<Task>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class Task: Object {
    @objc dynamic var text = ""
    @objc dynamic var completed = false
}

class ViewController: UITableViewController {
    var items: [Task] = []
    var notificationToken: NotificationToken?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRealm()
//        items.append(Task(value: ["text": "My First Task"]))
    }
    
    func setupUI() {
        title = "My Tasks"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupRealm() {
//        let myTask = Task()
//        myTask.text = "Hello"
//        myTask.completed = true
        realm = try! Realm()
        
//        try! realm.write {
//            realm.add(myTask)
//        }
        
        items = Array(realm.objects(Task.self))
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.text
        cell.textLabel?.alpha = item.completed ? 0.5 : 1
        return cell
    }
}


