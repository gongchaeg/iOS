//
//  UserAPI.swift
//  Peekabook
//
//  Created by devxsby on 2023/03/28.
//

import UIKit

import Moya

final class UserAPI {
    
    static let shared = UserAPI()
    private var userProvider = MoyaProvider<UserRouter>(plugins: [MoyaLoggerPlugin()])
    
    private init() { }
    
    private(set) var signUpData: GeneralResponse<BlankData>?
    
    // 1. 회원 가입하기
    
    func signUp(param: SignUpRequest, image: UIImage, completion: @escaping (GeneralResponse<BlankData>?) -> Void) {
        userProvider.request(.patchSignUp(param: param, image: image)) { [self] (result) in
            switch result {
            case .success(let response):
                do {
                    self.signUpData = try response.map(GeneralResponse<BlankData>.self)
                    completion(signUpData)
                } catch let error {
                    print(error.localizedDescription, 500)
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
