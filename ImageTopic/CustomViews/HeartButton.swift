//
//  HeartButton.swift
//  ImageTopic
//
//  Created by 김영훈 on 8/17/25.
//

import UIKit

protocol HeartButtonDelegate: AnyObject {
    func reloadCell(indexPath: IndexPath)
}

final class HeartButton: UIButton {
    
    private var id: String? = nil
    var indexPath: IndexPath?
    weak var delegate: HeartButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(id: String?) {
        self.id = id
        setImage()
    }
    
    private func setImage() {
        guard let id else { return }
        setImage(UIImage(systemName: UserDefaultManager.Favorites.getFavoriteImage(id)), for: .normal)
    }
    
    private func setup() {
        tintColor = .systemBlue
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped() {
        print(#function)
        guard let id else { return }
        UserDefaultManager.Favorites.toggleItemInMovieBox(id)
        setImage()
        
        guard let indexPath else { return }
        delegate?.reloadCell(indexPath: indexPath)
    }
}
