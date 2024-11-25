import UIKit

class LikesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let topBar = UIView()
    private let barTitle = UILabel()
    private let bottomLine = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let viewModel = LikesViewModel()
    
    var headerlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondaryGray
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(headerlabel)
        view.addSubview(lineView)
        
        setupUI()
        bindViewModel()
        viewModel.fetchData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        setupTopBar()
        setupTopBarTitle()
        setUpNavBarBottomLine()
        setupCollectionView()
    }
    
     private func setupTopBar() {
        view.addSubview(topBar)
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.backgroundColor = .tabBarCol
    
        NSLayoutConstraint.activate([
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            topBar.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
    
    private func setupTopBarTitle() {
        topBar.addSubview(barTitle)
        
        barTitle.configureCustomText(
            text: "You",
            color: .primaryBlack,
            isBold: true,
            size: 16
        )
        
        NSLayoutConstraint.activate([
            barTitle.centerXAnchor.constraint(equalTo: topBar.centerXAnchor),
            barTitle.bottomAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -30)
        ])
    }
    
    private func setUpNavBarBottomLine() {
        topBar.addSubview(bottomLine)
        bottomLine.backgroundColor = UIColor.secondaryGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomLine.leftAnchor.constraint(equalTo: topBar.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: topBar.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        topBar.bringSubviewToFront(bottomLine)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: LikeCollectionViewCell.identifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
        let headerContainer = UIView()
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerlabel)
        headerContainer.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerContainer.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: 50),
            
            headerlabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            headerlabel.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 8),
            
//            lineView.topAnchor.constraint(equalTo: headerlabel.bottomAnchor, constant: 8),
//            lineView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
//            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = -15
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LikeCollectionViewCell.identifier, for: indexPath) as? LikeCollectionViewCell,
              let likeItem = viewModel.item(at: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(with: likeItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }
        header.titleLabel.text = viewModel.sections[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
}

#Preview {
    LikesVC()
}
