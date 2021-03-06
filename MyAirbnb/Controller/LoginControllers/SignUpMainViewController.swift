//
//  SignUpMainViewController.swift
//  MyAirbnb
//
//  Created by 김광준 on 11/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class SignUpMainViewController: UIViewController {
    
    let mainScrollView = UIScrollView()
    
    //    let loginBtn = UIBarButtonItem()
    let moveToLoginVCbtn = UIButton(type: .custom)
    let signUpTopBarItem = UIView()
    let signUpBtn = UIButton()
    let facebookLoginBtn = UIButton()
    let optionBtn = UIButton()
    let bnbLogoImage = UIImageView()
    let firstWelcomMsgLbl = UILabel()
    let secondWelcomMsgLbl = UILabel()
    let mainDescriptionLbl = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let naviBackImage = UIImage(named: "airBnB-background")
        
        view.backgroundColor = .init(patternImage: UIImage.init(named: "AirBnB-background")!)
        
        navigationController?.navigationBar.isHidden = true
        
        
        addSubViews()
        mainScrollViewLayout()
        signUpTopBarItemLayout()
        
        btnLayout()
        btnLayoutConfigure()
        
        moveToLoginVCbtnConfigure()
        
        bnbLogoImageLayout()
        bnbLogoImageConfigure()
        
        labelsLayout()
        labelsConfigure()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    private func addSubViews() {
        view.addSubview(signUpTopBarItem)
        view.addSubview(mainScrollView)
        signUpTopBarItem.addSubview(moveToLoginVCbtn)
        
        mainScrollView.addSubview(facebookLoginBtn)
        mainScrollView.addSubview(signUpBtn)
        mainScrollView.addSubview(bnbLogoImage)
        mainScrollView.addSubview(firstWelcomMsgLbl)
        mainScrollView.addSubview(secondWelcomMsgLbl)
        mainScrollView.addSubview(optionBtn)
        mainScrollView.addSubview(mainDescriptionLbl)
        
    }
    
    private func signUpTopBarItemLayout() {
        let guide = view.safeAreaLayoutGuide
        
        let signUpTopBarItemHeight = view.frame.height - (view.frame.height - 55)
        
        signUpTopBarItem.backgroundColor = .clear
        
        signUpTopBarItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpTopBarItem.topAnchor.constraint(equalTo: guide.topAnchor),
            signUpTopBarItem.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            signUpTopBarItem.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            signUpTopBarItem.heightAnchor.constraint(equalToConstant: signUpTopBarItemHeight)
            ])
        
        // 오토레이아웃 테스트용
        //        signUpTopBarItem.backgroundColor = .black
        
    }
    
    // 메인 스크롤 뷰 레이아웃
    private func mainScrollViewLayout() {
        
        let guide = view.safeAreaLayoutGuide
        
        mainScrollView.backgroundColor = .clear
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: signUpTopBarItem.bottomAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            ])
        
        //        mainScrollView.contentSize.width = view.frame.width
        //        mainScrollView.contentSize.height = view.frame.height
        
    }
    
    // 메인 로고
    private func bnbLogoImageConfigure() {
        bnbLogoImage.image = UIImage(named: "AirBnB_Logo")
    }
    
    private func bnbLogoImageLayout() {
        
        bnbLogoImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bnbLogoImage.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 20),
            bnbLogoImage.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            //            bnbLogoImage.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -400),
            bnbLogoImage.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -800),
            ])
    }
    
    
    // 메인 환영 메시지 레이블, 하단 정책 설명 레이블
    private func labelsConfigure() {
        firstWelcomMsgLbl.text = "에어비엔비에 오신 것을 환영"
        firstWelcomMsgLbl.font = UIFont.boldSystemFont(ofSize: 28)
        firstWelcomMsgLbl.textColor = .white
        
        secondWelcomMsgLbl.text = "합니다."
        secondWelcomMsgLbl.font = UIFont.boldSystemFont(ofSize: 28)
        secondWelcomMsgLbl.textColor = .white
        
        mainDescriptionLbl.numberOfLines = 0
        mainDescriptionLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        mainDescriptionLbl.text = "'계속','계정 만들기',또는'기타 옵션'을 누름으로써 에어비엔비 서비스 약관과 결제 서비스 약관, 개인정보 처리 방침, 차별 금지 정책에 모두 동의합니다."
        mainDescriptionLbl.font = UIFont.boldSystemFont(ofSize: 14)
        mainDescriptionLbl.textColor = .white
    }
    
    private func labelsLayout() {
        
        let welcomMsgLblHeight = view.frame.height - (view.frame.height - 45)
        let lblHeight = view.frame.height - (view.frame.height - 55)
        
        firstWelcomMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        secondWelcomMsgLbl.translatesAutoresizingMaskIntoConstraints = false
        mainDescriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstWelcomMsgLbl.topAnchor.constraint(equalTo: bnbLogoImage.bottomAnchor, constant: 20),
            firstWelcomMsgLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            firstWelcomMsgLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            firstWelcomMsgLbl.heightAnchor.constraint(equalToConstant: welcomMsgLblHeight),
            
            
            
            secondWelcomMsgLbl.topAnchor.constraint(equalTo: firstWelcomMsgLbl.bottomAnchor, constant: 0),
            secondWelcomMsgLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            secondWelcomMsgLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            secondWelcomMsgLbl.heightAnchor.constraint(equalToConstant: welcomMsgLblHeight),
            
            
            
            mainDescriptionLbl.topAnchor.constraint(equalTo: optionBtn.bottomAnchor, constant: 40),
            mainDescriptionLbl.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            mainDescriptionLbl.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            mainDescriptionLbl.heightAnchor.constraint(equalToConstant: lblHeight),
            ])
        //        secondWelcomMsgLbl.backgroundColor = .black
        //        firstWelcomMsgLbl.backgroundColor = .yellow
        //        mainDescriptionLbl.backgroundColor = .blue
    }
    
    // 로그인 버튼 레이아웃
    private func moveToLoginVCbtnConfigure() {
        
        moveToLoginVCbtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moveToLoginVCbtn.centerYAnchor.constraint(equalTo: signUpTopBarItem.centerYAnchor),
            moveToLoginVCbtn.trailingAnchor.constraint(equalTo: signUpTopBarItem.trailingAnchor, constant: -20),
            ])
        //        moveToLoginVCbtn.backgroundColor = .white
    }
    
    // 페이스북 계정 로그인 버튼, 계정 만들기 버튼, 옵션 더 보기
    private func btnLayout() {
        
        facebookLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        optionBtn.translatesAutoresizingMaskIntoConstraints = false
        
        let btnHeight = view.frame.height - (view.frame.height - 50)
        let optionHeight = view.frame.height - (view.frame.height - 15)
        
        NSLayoutConstraint.activate([
            facebookLoginBtn.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            facebookLoginBtn.topAnchor.constraint(equalTo: secondWelcomMsgLbl.bottomAnchor, constant: 30),
            facebookLoginBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            facebookLoginBtn.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            facebookLoginBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            
            
            
            signUpBtn.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            signUpBtn.topAnchor.constraint(equalTo:facebookLoginBtn.bottomAnchor, constant: 15),
            signUpBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            signUpBtn.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor, constant: -20),
            signUpBtn.heightAnchor.constraint(equalToConstant: btnHeight),
            
            
            
            optionBtn.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 40),
            optionBtn.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor, constant: 20),
            optionBtn.heightAnchor.constraint(equalToConstant: optionHeight),
            ])
        //        optionBtn.backgroundColor = .black
    }
    
    private func btnLayoutConfigure() {
        
        signUpBtn.setTitle("계정 만들기", for: .normal)
        signUpBtn.setTitleColor(.white, for: .normal)
        signUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpBtn.titleLabel?.textAlignment = .center
        
        signUpBtn.layer.borderWidth = 3
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        signUpBtn.layer.cornerRadius = 7
        
        signUpBtn.addTarget(self, action: #selector(didTapSignBtn(_:)), for: .touchUpInside)
        
        facebookLoginBtn.setTitle("페이스북 계정으로 로그인", for: .normal)
        facebookLoginBtn.backgroundColor = .white
        facebookLoginBtn.setTitleColor(#colorLiteral(red: 0, green: 0.5842272043, blue: 0.6075613499, alpha: 1), for: .normal)
        facebookLoginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        facebookLoginBtn.titleLabel?.textAlignment = .center
        
        facebookLoginBtn.layer.borderWidth = 3
        facebookLoginBtn.layer.borderColor = UIColor.white.cgColor
        facebookLoginBtn.layer.cornerRadius = 7
        
        facebookLoginBtn.addTarget(self, action: #selector(didTapFacebookLoginBtn(_:)), for: .touchUpInside)
        
        optionBtn.setTitle("옵션 더 보기", for: .normal)
        optionBtn.setTitleColor(.white, for: .normal)
        optionBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        optionBtn.titleLabel?.textAlignment = .center
        
        optionBtn.addTarget(self, action: #selector(didTapOptionBtn(_:)), for: .touchUpInside)
        
        moveToLoginVCbtn.setTitle("로그인", for: .normal)
        moveToLoginVCbtn.setTitleColor(.white, for: .normal)
        moveToLoginVCbtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        moveToLoginVCbtn.titleLabel?.textAlignment = .center
        
        moveToLoginVCbtn.addTarget(self, action: #selector(didTapMoveToLoginVCbtn(_:)), for: .touchUpInside)
        
    }
    
    @objc private func didTapSignBtn(_ sender: UIButton) {
        let signUpPageVC = MakeIdPageViewController()
        navigationController?.pushViewController(signUpPageVC, animated: true)
    }
    
    @objc private func didTapFacebookLoginBtn(_ sender: UIButton) {
        print("tapped  facebookLoginBtn")
    }
    
    @objc private func didTapOptionBtn(_ sender: UIButton) {
        let optionLoginVC = OptionLoginPageViewController()
        present(optionLoginVC, animated: true, completion: nil)
    }
    
    // 네비게이션 바 버튼 액션 -> 로그인 버튼
    @objc private func didTapMoveToLoginVCbtn(_ sender: UIButton) {
        let loginPageVC = LoginPageViewController()
        navigationController?.pushViewController(loginPageVC, animated: true)
    }
}

