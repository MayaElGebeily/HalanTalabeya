//
//  ProductsViewController.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 18/08/2026.
//

import UIKit
import SDWebImage
import DesignKit

//TODO: -Builder
class ProductsViewController: UIViewController, ProductsDisplayLogic, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,ChipsHeaderViewDelegate {
    
    var interactor: ProductsBuisnessLogic?
    var router: ProductsRouter?
    var chips: [subCategoryChipViewModel] = []
    
    private var currentPage = 1
    private var isLoadingMore = false
    private var hasMorePages = true
    
    private var selectedIndex : Int = 0
    let categoryId: String
    let area: String
    let city: String
    let categoryName: String
    private var productCards: [ProductCardViewModel] = []
    private var AllProductCards: [ProductCardViewModel] = []
    private var selectedCategoryTitle: String = "الكل"
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var searchBarRow: CategorySearchBarView = {
            let view = CategorySearchBarView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.searchBar.delegate = self
            view.onGridTap = { [weak self] in self?.gridTapped() }
            return view
        }()
        
    
    private lazy var productsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
               collection.backgroundColor = AppColors.halanWhite
               collection.dataSource = self
               collection.delegate = self
               collection.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
               collection.register(ChipsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ChipsHeaderView.reuseIdentifier)
               collection.register(SelectedCategoryLabelView.self, forSupplementaryViewOfKind: "SelectedCategoryLabel", withReuseIdentifier: SelectedCategoryLabelView.reuseIdentifier)
               collection.translatesAutoresizingMaskIntoConstraints = false
               return collection
    }()
    
    init(categoryId: String, categoryName: String, area:String,
         city: String){
        self.categoryId = categoryId
        self.categoryName = categoryName
        self.area = area
        self.city = city
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    private func setup() {
        let interactor = ProductsInteractor()
        let presenter = ProductsPresenter()
        let router = ProductsRouter()
        
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.halanWhite
        title = categoryName
     // view.addSubview(topBar)
        setUpNav()
        searchBarRow.configure(placeholder: "ابحث فى \(categoryName)...")
        view.addSubview(searchBarRow)
        view.addSubview(productsCollectionView)
        view.addSubview(loadingIndicator)
      //topBar.configure(title: categoryName)
        
        NSLayoutConstraint.activate([
                    searchBarRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                    searchBarRow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    searchBarRow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    searchBarRow.heightAnchor.constraint(equalToConstant: 64),
                    
                    loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                    
                    productsCollectionView.topAnchor.constraint(equalTo: searchBarRow.bottomAnchor),
                    productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        loadingIndicator.startAnimating()
        interactor?.fetchChips(request: .init(categoryId: categoryId, area: area, city: city))
     // navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setUpNav(){
        navigationItem.title = categoryName
        
        let cartButton = UIBarButtonItem(
            image: UIImage(systemName: "cart"),
            style: .plain,
            target: self,
            action: #selector(cartTapped)
        )
        cartButton.tintColor = AppColors.contentPrimary
        navigationItem.leftBarButtonItem = cartButton
    }
    private func makeGridBarButton() -> UIBarButtonItem {
            let container = UIView()
            container.backgroundColor = AppColors.halanWhite
            container.layer.cornerRadius = 8
            container.translatesAutoresizingMaskIntoConstraints = false
            container.widthAnchor.constraint(equalToConstant: 40).isActive = true
            container.heightAnchor.constraint(equalToConstant: 40).isActive = true

            let icon = UIImageView(image: UIImage(systemName: "square.grid.2x2"))
            icon.tintColor = AppColors.contentPrimary
            icon.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(icon)
            NSLayoutConstraint.activate([
                icon.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                icon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                icon.widthAnchor.constraint(equalToConstant: 20),
                icon.heightAnchor.constraint(equalToConstant: 20)
            ])

            let gridTap = UITapGestureRecognizer(target: self, action: #selector(gridTapped))
            container.addGestureRecognizer(gridTap)

            return UIBarButtonItem(customView: container)
        }
    @objc private func cartTapped() { }
    @objc private func gridTapped() { }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                // Section 0: no cells, just the pinned chips header
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(0.01))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(46))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.pinToVisibleBounds = true
                header.zIndex = 100
                section.boundarySupplementaryItems = [header]
                return section
            } else {
                // Section 1: label header + the product grid
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(304))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 12, trailing: 6)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(304))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

                let labelSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let label = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: labelSize,
                    elementKind: "SelectedCategoryLabel",
                    alignment: .top
                )
                label.pinToVisibleBounds = false
                section.boundarySupplementaryItems = [label]
                return section
            }
        }
    }
    
    func displayChips(viewModel: ProductsModels.fetchChips.viewModel) {
        chips = viewModel.chips
        productsCollectionView.reloadData()
        guard let firstChip = chips.first else { return }
        selectedIndex = 0
        interactor?.fetchProducts(request: .init(categoryId: firstChip.id, area: area, city: city , page:1))
    }
    
    func displayProducts(viewModel: ProductsModels.fetchProducts.viewModel) {
        print("✅ Got \(viewModel.productCards.count) products, isFirstPage: \(viewModel.isFirstPage)") // TEMP
        if viewModel.isFirstPage {
            AllProductCards = viewModel.productCards
            productCards = viewModel.productCards
        } else{
            AllProductCards.append(contentsOf: viewModel.productCards)
            productCards.append(contentsOf: viewModel.productCards)
        }
        hasMorePages = !viewModel.productCards.isEmpty
        isLoadingMore = false
        loadingIndicator.stopAnimating()
        productsCollectionView.reloadData()
    }
    
    func chispsHeaderView(_ view: ChipsHeaderView, didSelectChipAt index: Int) {
        selectedIndex = index
        selectedCategoryTitle = chips[index].title
        productCards = []
        currentPage = 1
        hasMorePages = true
        loadingIndicator.startAnimating()
        productsCollectionView.reloadData()
        let chip = chips[index]
        interactor?.fetchProducts(request: .init(categoryId: chip.id, area: area, city: city , page: currentPage))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        guard !isLoadingMore, hasMorePages else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if offsetY > contentHeight - frameHeight - 200 {
            loadNextPage()
        }
    }
    
    private func loadNextPage(){
        guard !isLoadingMore else { return }
        isLoadingMore = true
        currentPage += 1
        print("📄 Loading page \(currentPage)")
        let categoryId = chips.indices.contains(selectedIndex) ? chips[selectedIndex].id : self.categoryId
        interactor?.fetchProducts(request: .init(categoryId: categoryId, area: area, city: city , page: currentPage))
    }




    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == 0 ? 0 : productCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
        cell.configure(with: productCards[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ChipsHeaderView.reuseIdentifier, for: indexPath) as! ChipsHeaderView
            header.delegate = self
            header.configure(chips: chips, selectedIndex: selectedIndex)
            return header
        } else {
            let label = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SelectedCategoryLabelView.reuseIdentifier, for: indexPath) as! SelectedCategoryLabelView
            label.configure(title: selectedCategoryTitle)
            return label
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let sectionInsets: CGFloat = 32
            let spacing: CGFloat = 8
            let width = (collectionView.bounds.width - sectionInsets - spacing) / 2
            return CGSize(width: width, height: 304)
        
    }
}

extension ProductsViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            productCards = AllProductCards
        }
        else{
            productCards = AllProductCards.filter{
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        productsCollectionView.reloadData()
    }
}
