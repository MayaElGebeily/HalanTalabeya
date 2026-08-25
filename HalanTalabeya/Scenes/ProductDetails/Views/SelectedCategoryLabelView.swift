//
//  SelectedCategoryLabelView.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 19/08/2026.
//
import DesignKit
import UIKit

class SelectedCategoryLabelView: UICollectionReusableView {
    static let reuseIdentifier = "SelectedCategoryLabelView"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.headingH3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AppColors.contentPrimary
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
     
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
