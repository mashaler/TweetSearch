//
//  ViewController.swift
//  TweetSearcher
//
//  Created by Gontse Ranoto on 2021/10/27.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    @IBOutlet private weak var tweetSearchBar: UISearchBar!
    @IBOutlet private weak var tweetsTableView: UITableView!
    @IBOutlet private weak var emptyStateView: UIView!
    @IBOutlet private weak var emptyStateLabel: UILabel!
    
    private lazy var viewModel: TweetSearcherViewModel = {
        return TweetSearcherViewModel(self)
    }()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        tweetSearchBar.delegate = self
        tweetSearchBar.searchTextField.backgroundColor = .white
        tweetSearchBar.isTranslucent = false
        tweetSearchBar.barTintColor = .lightGray
        tweetSearchBar.backgroundColor = .lightGray
    }
    
    private func setupTableView() {
        tweetsTableView.dataSource = self
        tweetsTableView.delegate = self
        tweetsTableView.register(TweetTableViewCell.nib, forCellReuseIdentifier: TweetTableViewCell.reusableIdentifier)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.titleView = UIImageView(image: UIImage(named: "twitter"))
        navigationItem.titleView?.contentMode = .scaleAspectFit
    }
    
    private func bindViewModel() {
        viewModel.$error.receive(on: DispatchQueue.main).sink{ _ in
          //TODO: Error Alert
        }.store(in: &subscriptions)
    }
}

// MARK: - UITableView DataSource & Delegate

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.getRowCount() }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.reusableIdentifier) as? TweetTableViewCell,
              let tweetData = viewModel.getTweetForRow(indexPath.row) else { return UITableViewCell() }
        cell.configureCell(handle: tweetData.handle, tweet: tweetData.tweet)
        cell.layoutIfNeeded()
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        viewModel.getTweets(searchTerm)
    }
}

// MARK: - SearchPresentable

extension SearchViewController: SearchPresentable {
    func didGetEmptyResults() {
        emptyStateLabel.isHidden = false
        emptyStateView.isHidden = false
        emptyStateLabel.text = localizedString(forKey: "noSeachResultsMessage")
    }
    
    func showloader() {
        DispatchQueue.main.async { [unowned self] in
            self.startActivityIndicator()
            self.emptyStateLabel.isHidden = true
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [unowned self] in
            self.stopActivityIndicator()
        }
    }
    
    func didGetResults() {
        DispatchQueue.main.async { [unowned self] in
            tweetsTableView.reloadData()
            emptyStateView.isHidden = true
        }
    }
}
