//
//  ChipsHeaderView.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 19/08/2026.
//
import UIKit
import DesignKit

protocol ChipsHeaderViewDelegate: AnyObject {
    func chispsHeaderView(_ view: ChipsHeaderView, didSelectChipAt index: Int)
}

class ChipsHeaderView: UICollectionReusableView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let reuseIdentifier = "ChipsHeaderView"
    weak var delegate: ChipsHeaderViewDelegate?
    var chips: [subCategoryChipViewModel] = []
    private var selectedIndex: Int = 0
    
  //  private lazy var selectedCategoryLabel: UILabel = {
  //      let label = UILabel()
  //      label.font = AppFonts.headingH3
  //      label.textColor = AppColors.contentPrimary
  //      label.translatesAutoresizingMaskIntoConstraints = false
  //      return label
  //  }()
    
    private lazy var chipsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColors.halanWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SubcategoryChipCell.self, forCellWithReuseIdentifier: SubcategoryChipCell.reuseIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.halanWhite
        addSubview(chipsCollectionView)
     //   addSubview(selectedCategoryLabel)
        NSLayoutConstraint.activate([
            chipsCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            chipsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            chipsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            chipsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
      //      selectedCategoryLabel.topAnchor.constraint(equalTo: //chipsCollectionView.bottomAnchor, constant: 16),
      //      selectedCategoryLabel.trailingAnchor.constraint(equalTo: //trailingAnchor, constant: -16),
      //      selectedCategoryLabel.bottomAnchor.constraint(equalTo: //bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(chips: [subCategoryChipViewModel], selectedIndex: Int
                  // categoryTitle: String
    ) {
        self.chips = chips
        self.selectedIndex = selectedIndex
     //   selectedCategoryLabel.text = categoryTitle
        chipsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection segrction: Int) -> Int {
        chips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chipsCollectionView.dequeueReusableCell(withReuseIdentifier: SubcategoryChipCell.reuseIdentifier, for: indexPath) as! SubcategoryChipCell
        cell.configure(title: chips[indexPath.item].title, isSelected: indexPath.item == selectedIndex)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.chispsHeaderView(self, didSelectChipAt: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = chips[indexPath.item].title
        let width = text.size(withAttributes: [.font: AppFonts.paragraphP3]).width + (AppSpacing.buttonPaddingHorizontal * 2)

        return CGSize(width: width, height: AppSpacing.buttonHeight)
    }
}
