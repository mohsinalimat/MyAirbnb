//
//  MainViewController.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 06/07/2019.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView
import Kingfisher

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    let searchBarView = SearchBarView()
    let searchBarTableViewBackWhiteView = UIView()
    let searchBarTableView = SearchBarTableView()
    
    var mainView = MainView()
    
    let indicatorView = UIView()
    let indicator = NVActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    let jsonDecoder = JSONDecoder()
    let notiCenter = NotificationCenter.default
    let netWork = NetworkCommunicator()
    let kingfisher = ImageDownloader.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
        addNotificationObserver()
        makeIndicatorView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        searchBarView.useCase = .inMainVC
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideSearchBarTableView()
        stopIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setAutoLayout() {
        let safeGuide = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 0).isActive = true
        searchBarView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor).isActive = true
        searchBarView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor).isActive = true
        //        searchBarView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: searchBarView.filterStackView.bottomAnchor, constant: 5).isActive = true
        //        mainView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: 110).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: 0).isActive = true
        
        view.addSubview(searchBarTableViewBackWhiteView)
        searchBarTableViewBackWhiteView.translatesAutoresizingMaskIntoConstraints = false
        searchBarTableViewBackWhiteView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: -40).isActive = true
        searchBarTableViewBackWhiteView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBarTableViewBackWhiteView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBarTableViewBackWhiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        searchBarTableViewBackWhiteView.addSubview(searchBarTableView)
        searchBarTableView.translatesAutoresizingMaskIntoConstraints = false
        searchBarTableView.topAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.topAnchor).isActive = true
        searchBarTableView.leadingAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.leadingAnchor).isActive = true
        searchBarTableView.trailingAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.trailingAnchor).isActive = true
        searchBarTableView.bottomAnchor.constraint(equalTo: searchBarTableViewBackWhiteView.bottomAnchor).isActive = true
        
        view.bringSubviewToFront(searchBarView)
        view.sendSubviewToBack(searchBarTableViewBackWhiteView)
    }
    
    private func configureViewsOptions() {
        view.backgroundColor = .white
        
        searchBarTableView.alpha = 0
        searchBarTableViewBackWhiteView.backgroundColor = .white
        searchBarTableViewBackWhiteView.alpha = 0
    }
    
    var setLayout = false
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if setLayout == false {
            
            setLayout = true
        }
    }
    
    private func showSearchBarTableView() {
        view.bringSubviewToFront(searchBarTableViewBackWhiteView)
        self.searchBarTableViewBackWhiteView.alpha = 1
        
        UIView.animate(withDuration: 0.3) {
            self.searchBarTableView.alpha = 1
        }
    }
    
    private func hideSearchBarTableView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.searchBarTableView.alpha = 0
        }) { (_) in
            self.searchBarTableViewBackWhiteView.alpha = 0
            self.view.sendSubviewToBack(self.searchBarTableViewBackWhiteView)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print("touchesEnd")

        print(searchBarTableView.tableView.isDragging)
        let location = touches.first!.location(in: view)

        if searchBarTableView.frame.contains(location) {
            searchBarView.searchTF.resignFirstResponder()
        }
    }
    
    private func makeIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBarView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicatorView.backgroundColor = .white
        view.sendSubviewToBack(indicatorView)
        
        let centerX = UIScreen.main.bounds.width/2
        let centerY = UIScreen.main.bounds.height/2
        indicatorView.addSubview(indicator)
        indicator.frame = CGRect(x: centerX-15, y: centerY-300, width: 30, height: 30)
        indicator.type = .ballBeat
        indicator.color = StandardUIValue.shared.colorBlueGreen
    }
    
    private func startIndicator() {
        view.bringSubviewToFront(indicatorView)
        indicator.startAnimating()
    }
    
    private func stopIndicator() {
        view.sendSubviewToBack(indicatorView)
        indicator.stopAnimating()
    }
}

//Notification
extension MainViewController {
    private func addNotificationObserver() {
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditBegin, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarEditEnd, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarDateBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarDateResultBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarPeopleBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .searchBarFilterBtnDidTap, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseView, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToHouseDetailView, object: nil)
        notiCenter.addObserver(self, selector: #selector(receiveNotification(_:)), name: .moveToPlusHouseDetailView, object: nil)
    }
    
    @objc func receiveNotification(_ sender: Notification) {
        switch sender.name {
        case Notification.Name.searchBarEditBegin:
            showSearchBarTableView()

        case Notification.Name.searchBarEditEnd:
            hideSearchBarTableView()
            
        case Notification.Name.searchBarDateBtnDidTap:
            let calendarVC = CalenderViewController()
            calendarVC.modalPresentationStyle = .overFullScreen
            //        calendarVC.modalPresentationStyle = .overCurrentContext
            
            if searchBarView.selectedDatesArray.count > 0 {
                calendarVC.beginDatesArray = searchBarView.selectedDatesArray
            }
            
            present(calendarVC, animated: false)
            
        case Notification.Name.searchBarDateResultBtnDidTap:
            print("")
            
        case Notification.Name.searchBarPeopleBtnDidTap:
            let filterPeopleVC = FilterPeopleViewController()
            filterPeopleVC.selectedPeople = searchBarView.selectedPeople
            
            filterPeopleVC.modalPresentationStyle = .overFullScreen
            present(filterPeopleVC, animated: false)
            
        case Notification.Name.searchBarFilterBtnDidTap:
            let filterRemainsVC = FilterRemainsViewController()
            filterRemainsVC.isDateSelected = (searchBarView.selectedDateString == "날짜") ? false : true
            present(filterRemainsVC, animated: true)
            
        case Notification.Name.moveToHouseView:
            startIndicator()
            
            getServerHouseDataInList { (housedataArray) in
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    let houseVC = HouseViewController()
                    houseVC.houseView.houseDataArray = housedataArray
                    self.navigationController?.pushViewController(houseVC, animated: false)
                }
            }
            
        case Notification.Name.moveToHouseDetailView:
            guard let userInfo = sender.userInfo as? [String: Any]
                , let roomID = userInfo["roomID"] as? Int
                , let type = userInfo["type"] as? String
                , let name = userInfo["houseName"] as? String
                else { print("moveToHouseDetailView noti error"); return }
            
            let houseDetailVC = HouseDetailViewController()
            houseDetailVC.roomID = roomID
            houseDetailVC.nameLabelPlaceholder = name
            houseDetailVC.typeLablePlaceholder = type
            self.navigationController?.pushViewController(houseDetailVC, animated: false)
            
        case Notification.Name.moveToPlusHouseDetailView:
            let plusHouseVC = PlusViewController()
            navigationController?.pushViewController(plusHouseVC, animated: true)
            
        default : break
        }
    }
    
    
    
    private func getServerHouseDataInList(completion: @escaping ([HouseDataInList]) -> ()) {
        let urlString = netWork.basicUrlString
            + "/rooms/?search=seoul&ordering=price&page_size=5&page=1"
        
        netWork.getJsonObjectFromAPI(urlString: urlString, urlForSpecificProcessing: nil) { (json, success) in
            guard success else {
                return
            }
            guard let object = json as? [String: Any]
                , let resultArray = object["results"] as? [[String: Any]]
                else { print("object convert error"); return }
            
            guard let data = try? JSONSerialization.data(withJSONObject: resultArray) else {
                print("‼️ LaunchVC data convert error")
                return
            }
            guard var houseArray = try? self.jsonDecoder.decode([HouseDataInList].self, from: data) else {
                print("‼️ LaunchVC result decoding convert error")
                return
            }
            
            for i in 0..<houseArray.count {
                guard let url = URL(string: houseArray[i].image) else { print("‼️ LaunchVC kingfisher url "); return }
                self.kingfisher.downloadImage(with: url, completionHandler: { (result) in
                    switch result {
                    case .success(let value):
                        houseArray[i].imageArray.append(value.image)
                    case .failure(let error):
                        print("‼️ LaunchVC kinfisher: ", error.localizedDescription)
                    }
                    (i == houseArray.count - 1) ? completion(houseArray) : ()
                })
            }
        }
    }
}

