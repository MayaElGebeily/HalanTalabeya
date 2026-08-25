//
//  CategorySearchBarView.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 24/08/2026.
//
import UIKit
import DesignKit

class CategorySearchBarView: UIView {
    
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
        bar.searchBarStyle = .minimal
        bar.semanticContentAttribute = .forceRightToLeft
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.layer.cornerRadius = 8
        bar.clipsToBounds = true
        return bar
    }()
    
    var onGridTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColors.halanWhite
        
        addSubview(gridIconContainer)
        gridIconContainer.addSubview(gridIcon)
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            gridIconContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gridIconContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            gridIconContainer.widthAnchor.constraint(equalToConstant: 40),
            gridIconContainer.heightAnchor.constraint(equalToConstant: 40),
            
            gridIcon.centerXAnchor.constraint(equalTo: gridIconContainer.centerXAnchor),
            gridIcon.centerYAnchor.constraint(equalTo: gridIconContainer.centerYAnchor),
            gridIcon.widthAnchor.constraint(equalToConstant: 20),
            gridIcon.heightAnchor.constraint(equalToConstant: 20),
            
            searchBar.leadingAnchor.constraint(equalTo: gridIconContainer.trailingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            topAnchor.constraint(equalTo: topAnchor),
            heightAnchor.constraint(equalToConstant: 64)
        ])
        
        let gridTap = UITapGestureRecognizer(target: self, action: #selector(gridTapped))
        gridIconContainer.addGestureRecognizer(gridTap)
        alignSearchTextRight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(placeholder: String) {
        searchBar.placeholder = placeholder
    }
    
    @objc private func gridTapped() {
        onGridTap?()
    }
    
    private func alignSearchTextRight() {
        if let textField = searchBar.value(forKey: "searchTextField") as? UITextField {
            textField.textAlignment = .right
            textField.backgroundColor = AppColors.greyLight

            textField.layer.cornerRadius = 8
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
            textField.leftViewMode = .always
            textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
            textField.rightViewMode = .always
        }
    }
}

