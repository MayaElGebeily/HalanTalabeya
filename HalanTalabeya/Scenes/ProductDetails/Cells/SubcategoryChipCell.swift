//
//  SubcategoryChipCell.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// one filter chip's UI, configured similarly.

import UIKit
import DesignKit

class SubcategoryChipCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SubcategoryChipCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.subtitleST3
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = AppSpacing.buttonHeight/2
        contentView.layer.borderWidth = AppSpacing.borderWidth
        contentView.clipsToBounds = true
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                       titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                       titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
                       titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, isSelected: Bool) {
        let color = isSelected ? AppColors.halanLight1 : AppColors.contentPrimary
            titleLabel.attributedText = styledTitle(title, color: color)
            
            if isSelected {
                contentView.backgroundColor = AppColors.halanPrimary
                contentView.layer.borderColor = AppColors.halanPrimary.cgColor
            } else {
                contentView.backgroundColor = AppColors.halanLight1
                contentView.layer.borderColor = AppColors.borderDefault.cgColor
            }
        }
        
    private func styledTitle(_ text: String, color: UIColor) -> NSAttributedString {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = 22.4
            paragraphStyle.maximumLineHeight = 22.4
            paragraphStyle.alignment = .center
            
            return NSAttributedString(
                string: text,
                attributes: [
                    .font: AppFonts.paragraphP3,
                    .paragraphStyle: paragraphStyle,
                    .foregroundColor: color,
                    .baselineOffset: (22.4 - 14) / 4
                ]
            )
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }
}
