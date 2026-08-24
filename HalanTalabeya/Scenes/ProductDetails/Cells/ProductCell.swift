//
//  ProductCell.swift
//  HalanTalabeya
//
//  Created by Maya El Gebeily on 17/08/2026.
// one product card's UI (UICollectionViewCell), configured via the Presenter's ProductCardViewModel
import UIKit
import DesignKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ProductCell"
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.halanWhite
        view.layer.cornerRadius = AppSpacing.cardCornerRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = AppColors.borderDefault.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.captionC2
        label.textColor = AppColors.halanWhite
        label.backgroundColor = AppColors.accentOrange
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.paragraphP3
        label.textColor = AppColors.contentPrimary
        label.numberOfLines = 2
        label.textAlignment = .right
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.headingH4
        label.textColor = AppColors.contentPrimary
        label.textAlignment = .right
        return label
    }()
    
    private lazy var originalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.captionC2
        label.textColor = AppColors.contentSecondary
        label.textAlignment = .right
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("اضف للعربة", for: .normal)
        button.backgroundColor = AppColors.halanPrimary
        button.setTitleColor(AppColors.halanWhite, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFonts.button2
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var currentProduct: Product?
    
    private lazy var packDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFonts.qtyDescriptor
        label.textColor = AppColors.halanPrimary
        label.backgroundColor = UIColor(
            red: 235 / 255,
            green: 248 / 255,
            blue: 244 / 255,
            alpha: 1
        )
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 0.5
        label.layer.borderColor = AppColors.borderDefault.cgColor

        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHierarchy()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpHierarchy() {
        cardView.addSubview(productImageView)
        cardView.addSubview(badgeLabel)
        textStack.addArrangedSubview(nameLabel)
        priceStack.addArrangedSubview(priceLabel)
        priceStack.addArrangedSubview(originalPriceLabel)
        cardView.addSubview(textStack)
        cardView.addSubview(priceStack)
        cardView.addSubview(addButton)
        cardView.addSubview(packDescriptionLabel)
        contentView.addSubview(cardView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            productImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            productImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 163),
            productImageView.heightAnchor.constraint(equalToConstant: 110),
            
            badgeLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            badgeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12), // was -8
            badgeLabel.heightAnchor.constraint(equalToConstant: 18),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            textStack.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            textStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            
            packDescriptionLabel.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 8),
            packDescriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12), // was -10
            packDescriptionLabel.widthAnchor.constraint(equalToConstant: 92),
            packDescriptionLabel.heightAnchor.constraint(equalToConstant: 25),
            
            priceStack.topAnchor.constraint(equalTo: packDescriptionLabel.bottomAnchor, constant: 4),
            priceStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12), // was 8
            priceStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12), // was -10
            
            addButton.topAnchor.constraint(equalTo: priceStack.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            addButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            addButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12), // matches padding-bottom: 12
            addButton.heightAnchor.constraint(equalToConstant: AppSpacing.buttonHeight),
        ])
    }
    
    func configure(with viewModel: ProductCardViewModel) {
        nameLabel.text = viewModel.name
        if let packDescription = viewModel.packDescription,
           !packDescription.isEmpty {

            packDescriptionLabel.text = "\(packDescription)"
            packDescriptionLabel.isHidden = false

        } else {

            packDescriptionLabel.isHidden = true
        }
        priceLabel.attributedText = viewModel.priceText
        
        if let original = viewModel.originalPriceText {
            let attributed = NSAttributedString(string: original, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            originalPriceLabel.attributedText = attributed
            originalPriceLabel.isHidden = false
        } else {
            originalPriceLabel.isHidden = true
        }
        
        badgeLabel.isHidden = viewModel.badgeText == nil
        badgeLabel.text = viewModel.badgeText.map { "  \($0)  " }
        
        productImageView.sd_setImage(with: URL(string: viewModel.imageURL), placeholderImage: UIImage(systemName: "photo"))
        
    }
    
    @objc private func addTapped() {
        print("Add to cart tapped")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.sd_cancelCurrentImageLoad()
        productImageView.image = UIImage(systemName: "photo")
    }
}
