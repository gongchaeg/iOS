//
//  DeletePopUpVC.swift
//  Peekabook
//
//  Created by 김인영 on 2023/01/12.
//

import UIKit

import SnapKit
import Then

import Moya

final class DeletePopUpVC: UIViewController {
    
    // MARK: - Properties

    var bookShelfId: Int = 0
    
    // MARK: - UI Components
    private let popUpView = UIView()
    
    private let confirmLabel = UILabel().then {
        $0.text = I18N.BookDelete.popUpComment
        $0.font = .h4
        $0.textColor = .peekaRed
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle(I18N.Confirm.cancel, for: .normal)
        $0.titleLabel!.font = .h2
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .peekaGray2
        $0.addTarget(self, action: #selector(touchCancelButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var confirmButton = UIButton().then {
        $0.setTitle(I18N.Confirm.delete, for: .normal)
        $0.titleLabel!.font = .h1
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .peekaRed
        $0.addTarget(self, action: #selector(touchConfirmButtonDipTap), for: .touchUpInside)
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout
extension DeletePopUpVC {
    private func setUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        popUpView.backgroundColor = .peekaBeige
    }
    
    private func setLayout() {
        view.addSubview(popUpView)
        
        [confirmLabel, cancelButton, confirmButton].forEach {
            popUpView.addSubview($0)
        }
        
        popUpView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(295)
            $0.height.equalTo(136)
        }
        
        confirmLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(confirmLabel.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(124)
            $0.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(confirmLabel.snp.bottom).offset(14)
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(cancelButton)
        }
    }
}

// MARK: - Methods

extension DeletePopUpVC {
    @objc private func touchCancelButtonDidTap() {
        self.dismiss(animated: false, completion: nil)
    }

    @objc private func touchConfirmButtonDipTap() {
        deleteBookAPI(id: bookShelfId)
    }
}

// MARK: - Network

extension DeletePopUpVC {
    private func deleteBookAPI(id: Int) {
        BookShelfAPI.shared.deleteBook(bookId: id) { response in
            if response?.success == true {
                self.switchRootViewController(rootViewController: TabBarController(), animated: true, completion: nil)
            }
        }
    }
}
