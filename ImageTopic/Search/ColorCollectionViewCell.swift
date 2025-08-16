//
//  ColorCollectionViewCell.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/16/25.
//

import UIKit
import SnapKit

final class ColorCollectionViewCell: UICollectionViewCell, Identifying {
    
    private let containerView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let colorView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let colorLabel = {
        let label = UILabel()
        label.font = .Detail.normal
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width,
                                height: 28)
        let autoSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        
        attributes.size = autoSize
        return attributes
    }
    
    override func draw(_ rect: CGRect) {
        containerView.layer.cornerRadius = containerView.frame.height / 2
        colorView.layer.cornerRadius = colorView.frame.height / 2
    }
    
    func configure(color: ColorCategory, isSelected: Bool) {
        colorView.backgroundColor = UIColor(named: "\(color.rawValue)Custom")
        colorLabel.text = color.description
        
        if isSelected {
            containerView.backgroundColor = .systemBlue
            colorLabel.textColor = .white
        } else {
            containerView.backgroundColor = .systemGray6
            colorLabel.textColor = .black
        }
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        [colorView, colorLabel].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        colorView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(4)
            make.width.equalTo(colorView.snp.height)
        }
        colorLabel.snp.makeConstraints { make in
            make.leading.equalTo(colorView.snp.trailing).offset(4)
            make.verticalEdges.equalTo(colorView)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
}
