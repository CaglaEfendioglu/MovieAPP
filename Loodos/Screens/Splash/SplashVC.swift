//
//  SplashVC.swift
//  Lodoos
//
//  Created by Cagla Efendioğlu on 2.06.2023.
//

import UIKit
import Alamofire
import SnapKit
import FirebaseRemoteConfig

class Connect {
    class func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


class SplashVC: UIViewController {
    
    private var splashLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.337, green: 0.745, blue: 0.514, alpha: 1)
        return label
    }()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchRemoteConfig()
    }
    
    func fetchRemoteConfig() {
        let defaults: [String: NSObject] = ["text": "loodos" as NSObject]
        remoteConfig.setDefaults(defaults)
        
        remoteConfig.fetch(withExpirationDuration: 10) { status, error in
            guard error == nil else { return }
            self.remoteConfig.activate()
        }
        
        let loodos = remoteConfig.configValue(forKey: "text").stringValue ?? ""
        splashLabel.text = loodos
        animation()
    }
    
    func configure() {
        view.backgroundColor = .white
        view.addSubview(splashLabel)
        
        makeConstraints()
    }
    
    func animation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isNetwork()
        }
    }
    
    func isNetwork() {
        if Connect.isConnected() {
            let viewController = UINavigationController(rootViewController: SearchListBuilder.make())
            viewController.modalPresentationStyle = .fullScreen
            self.show(viewController, sender: nil)
        }else{
            let errorAlert = UIAlertController(title: "UPS!",
                                               message: "No internet connection",
                                               preferredStyle: .alert
            )
            let errorAction = UIAlertAction(title: "OK",
                                            style: .cancel
            )
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true)
        }
    }
}

//MARK: - Constraints

extension SplashVC {
    func makeConstraints() {
        splashLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
    }
}
