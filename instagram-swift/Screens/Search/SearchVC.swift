//
//  SearchVC.swift
//  instagram-swift
//
//  Created by Despo on 22.11.24.
//

import UIKit

final class SearchVC: UIViewController {
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    private lazy var searchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private let viewModel = PostViewModel()
    private var filteredPostsData: [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewModel()
        searchBar.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            searchCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 19),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        filteredPostsData = viewModel.allPostsData
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(300)
            )
            
            let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { environment in
                var items: [NSCollectionLayoutGroupCustomItem] = []
                
                let spacing: CGFloat = 4
                
                let largeItemFrame = CGRect(
                    x: 0,
                    y: 0,
                    width: environment.container.contentSize.width * 0.66,
                    height: 300
                )
                let largeItem = NSCollectionLayoutGroupCustomItem(frame: largeItemFrame)
                items.append(largeItem)
                
                let smallTopItemFrame = CGRect(
                    x: environment.container.contentSize.width * 0.66 + spacing,
                    y: 0,
                    width: environment.container.contentSize.width * 0.34 - spacing,
                    height: 148
                )
                let smallTopItem = NSCollectionLayoutGroupCustomItem(frame: smallTopItemFrame)
                items.append(smallTopItem)
                
                let smallBottomItemFrame = CGRect(
                    x: environment.container.contentSize.width * 0.66 + spacing,
                    y: 152 + spacing,
                    width: environment.container.contentSize.width * 0.34 - spacing,
                    height: 148
                )
                let smallBottomItem = NSCollectionLayoutGroupCustomItem(frame: smallBottomItemFrame)
                items.append(smallBottomItem)
                
                return items
            }
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            section.interGroupSpacing = 8 
            return section
        }
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchVC: FeedViewModelDelegate {
    func didFinishFetchingData() {
        DispatchQueue.main.async { [weak self] in
            self?.filteredPostsData = self?.viewModel.allPostsData ?? []
            self?.searchCollectionView.reloadData()
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterPosts(query: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filterPosts(query: "")
    }
    
    private func normalizeText(_ text: String) -> String {
        let allowedCharacters = CharacterSet.alphanumerics
        let normalizedText = text.lowercased().components(separatedBy: allowedCharacters.inverted).joined()
        
        return normalizedText
    }
    
    private func filterPosts(query: String) {
        if query.isEmpty {
            filteredPostsData = viewModel.allPostsData
        } else {
            let normalizedQuery = normalizeText(query)
            
            filteredPostsData = viewModel.allPostsData.filter { post in
                let normalizedLocation = normalizeText(post.location)
                let normalizedUsername = normalizeText(post.user.username)
                
                return normalizedLocation.contains(normalizedQuery) || normalizedUsername.contains(normalizedQuery)
            }
        }
        searchCollectionView.reloadData()
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPostsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let post = filteredPostsData[indexPath.row]
        cell.configureSearchCollectionViewCell(with: post)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = filteredPostsData[indexPath.row]
        navigationController?.pushViewController(DetailsVC(model: post), animated: true)
    }
}
