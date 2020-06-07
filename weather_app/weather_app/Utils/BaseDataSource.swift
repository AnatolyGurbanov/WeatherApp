//
//  BaseDataSource.swift
//  weather_app
//
//  Created by Anatoly on 07.06.2020.
//  Copyright © 2020 Anatoly. All rights reserved.
//

import UIKit

class BaseDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    private weak var tableView: UITableView?

    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }

    var items: [ItemProtocol] = [] {
        didSet {
            self.items.map{$0.reuseIdentifier}
                .withRemovedDuplicates()
                .forEach({
                self.tableView?.register(UINib(nibName: $0, bundle: Bundle.main), forCellReuseIdentifier: $0)
            })
            self.tableView?.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: items[indexPath.row].reuseIdentifier) as? CellWithItem {
            
            cell.setItem(item: items[indexPath.row])
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].itemHeight
    }

}
