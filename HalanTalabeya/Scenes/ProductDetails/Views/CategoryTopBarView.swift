//
//  CategoryTopBarView.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 19/08/2026.
//

import UIKit
import DesignKit
// TODO: -NavBar Done in VC
class CategoryTopBarView: UIView {
    
    private lazy var cartIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "cart"))
        imageView.tintColor = AppColors.contentPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.headingH3
        label.textColor = AppColors.contentPrimary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chevronIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = AppColors.contentPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gridIconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.halanLight1
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gridIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "square.grid.2x2"))
        imageView.tintColor = AppColors.contentPrimary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "ابحث فى بيض و البان..."
        bar.searchBarStyle = .minimal
        bar.semanticContentAttribute = .forceRightToLeft
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.halanWhite
        
        addSubview(cartIcon)
        addSubview(titleLabel)
        addSubview(chevronIcon)
        addSubview(gridIconContainer)
        gridIconContainer.addSubview(gridIcon)
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            cartIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cartIcon.centerYAnchor.constraint(equalTo: topAnchor, constant: 40),
            cartIcon.widthAnchor.constraint(equalToConstant: 24),
            cartIcon.heightAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: cartIcon.centerYAnchor),
            
            chevronIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            chevronIcon.centerYAnchor.constraint(equalTo: cartIcon.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 24),
            chevronIcon.heightAnchor.constraint(equalToConstant: 24),
            
            gridIconContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gridIconContainer.topAnchor.constraint(equalTo: cartIcon.bottomAnchor, constant: 16),
            gridIconContainer.widthAnchor.constraint(equalToConstant: 40),
            gridIconContainer.heightAnchor.constraint(equalToConstant: 40),
            gridIconContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            gridIcon.centerXAnchor.constraint(equalTo: gridIconContainer.centerXAnchor),
            gridIcon.centerYAnchor.constraint(equalTo: gridIconContainer.centerYAnchor),
            gridIcon.widthAnchor.constraint(equalToConstant: 20),
            gridIcon.heightAnchor.constraint(equalToConstant: 20),
            
            searchBar.leadingAnchor.constraint(equalTo: gridIconContainer.trailingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.centerYAnchor.constraint(equalTo: gridIconContainer.centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        alignSearchTextRight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    private func alignSearchTextRight() {
        if let textField = searchBar.value(forKey: "searchTextField") as? UITextField {
            textField.textAlignment = .right
            textField.backgroundColor = AppColors.halanWhite 
        }
    }
}
