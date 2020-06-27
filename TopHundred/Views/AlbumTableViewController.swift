//
//  AlbumTableViewController.swift
//  TopHundred
//
//  Created by Stephen Payne on 6/27/20.
//  Copyright © 2020 Stephen Payne. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {
    // MARK: - Properties
    let viewModel = AlbumTableViewModel()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
