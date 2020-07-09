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
    private var viewModel: AlbumTableViewModel?
    

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AlbumTableViewModel(delegate: self)
        registerTableViewCell()
    }
    

    // MARK: - Private Methods
    private func registerTableViewCell() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.cellID)
    }
    
    private func displayAlbumDetailView(withAlbum album: Album) {
        let detailViewModel = AlbumDetailViewModel(album: album)
        let albumDetailVC = AlbumDetailViewController(withViewModel: detailViewModel)

        self.navigationController?.pushViewController(albumDetailVC, animated: true)
    }


    // MARK: - TableView DataSource and Delegate Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel?.dataSource,
            data.indices.contains(indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.cellID,
                                                     for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }

        let album = data[indexPath.row]
        cell.configureCell(album: album)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = viewModel?.dataSource, data.indices.contains(indexPath.row) else { return }
        
        let album = data[indexPath.row]
        displayAlbumDetailView(withAlbum: album)
    }
}


// MARK: - Album Table View Model Delegate
extension AlbumTableViewController: AlbumTableViewModelDelegate {
    func albumDataSourceWasUpdated() {
        tableView.reloadData()
    }
    
    func errorOccurredWhileRetrieving(error: ResponseServerError) {
        let alert = UIAlertController(title: "Error", message: error.messageForError(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true)
    }
}
