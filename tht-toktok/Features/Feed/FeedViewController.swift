//
//  FeedViewController.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 04/12/22.
//

import Combine
import UIKit

class FeedViewController: UIViewController {
    
    // MARK: - Outlets and Variables
    private var feedTableView: UITableView!
    
    // MARK: View Model
    private var viewModel: FeedViewModel = {
        return FeedViewModel(service: MockFeedService())
    }()
    
    // MARK: Combine Control
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle Control
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewSetup()
        self.viewModelSetup()
        viewModel.loadFeed()
    }
    
    // MARK: - Model & Component Setup
    private func viewModelSetup() {
        viewModel
            .$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    // TODO: downloading feed, show loading indicator
                    return
                case .feed:
                    self?.feedTableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    private func tableViewSetup() {
        feedTableView = FeedTableView(frame: view.frame)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        view.addSubview(feedTableView)
    }
    
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: FeedCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? FeedCell
        
        let item = viewModel.data[indexPath.row]
        cell?.setup(withItem: item)
        return cell ?? UITableViewCell()
    }
}
