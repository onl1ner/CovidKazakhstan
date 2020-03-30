//
//  ContactsViewController.swift
//  CovidKazakhstan
//
//  Created by onl1ner onl1ner on 30/03/2020.
//  Copyright © 2020 onl1ner onl1ner. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {

    @IBOutlet var phoneNumbersStackView: UIStackView!
    
    @IBOutlet var telegramBotBackgroundView: UIView!
    
    @IBOutlet var telegramNewsBotBackgroundView: UIView!
    
    @IBAction func openTelegramNewsBot(_ sender: Any) {
        if let url = URL(string: "tg://resolve?domain=coronavirus2020_kz") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func openTelegramBot(_ sender: Any) {
        if let url = URL(string: "tg://resolve?domain=kz_hls_bot") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func callToEmergency(_ sender: Any) {
        if let url = URL(string: "tel://103") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func callToHealthMinistry(_ sender: Any) {
        if let url = URL(string: "tel://1406") {
            UIApplication.shared.open(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        telegramBotBackgroundView.layer.cornerRadius = 10
        telegramBotBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                              withOpacity: 0.2,
                                              withOffset: CGSize(width: 0, height: 1))
        
        telegramNewsBotBackgroundView.layer.cornerRadius = 10
        telegramNewsBotBackgroundView.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                                  withOpacity: 0.2,
                                                  withOffset: CGSize(width: 0, height: 1))
        
        for i in phoneNumbersStackView.subviews {
            i.layer.cornerRadius = 10
            i.setupShadow(withColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                          withOpacity: 0.2,
                          withOffset: CGSize(width: 0, height: 1))
        }
    }
    
}
