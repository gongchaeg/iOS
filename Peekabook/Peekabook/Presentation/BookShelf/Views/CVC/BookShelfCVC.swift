//
//  BookShelfCVC.swift
//  Peekabook
//
//  Created by devxsby on 2023/01/04.
//

import UIKit

final class BookShelfCVC: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var bookId: Int = 0
    
    // MARK: - UI Components
    
    private let bookImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    private let horizontalLine = UIView().then {
        $0.clipsToBounds = false
    }
    
    private let pickImageView = UIImageView().then {
        $0.image = ImageLiterals.Icn.newPick
        $0.contentMode = .scaleToFill
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension BookShelfCVC {
    func initCell(model: SampleBookModel) {
        bookImageView.image = model.bookImage
    }
    
    private func setUI() {
        backgroundColor = .peekaLightBeige
        horizontalLine.backgroundColor = .peekaBeige
        bookImageView.layer.applyShadow(color: .black, alpha: 0.25, x: 1, y: 1, blur: 4, spread: 0)
    }
    
    private func setLayout() {
        addSubviews(bookImageView, horizontalLine, pickImageView)
        
        bookImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bookImageView.snp.bottom)
            make.width.equalTo(UIScreen.main.bounds.width*2)
            make.height.equalTo(6)
        }
        
        pickImageView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.top).offset(-4)
            make.trailing.equalTo(bookImageView).inset(8)
        }
    }
    
    func setData(model: Book) {
        
        pickImageView.isHidden = model.pickIndex == 0 ? true : false
        
        bookId = model.bookID
        bookImageView.kf.indicatorType = .activity
        bookImageView.kf.setImage(with: URL(string: model.book.bookImage))
    }
}
