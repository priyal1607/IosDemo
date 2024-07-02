//
//  openUrl.swift
//  MyGovMaharashtra
//
//  Created by Gunjan Patel on 14/06/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

func openURL(urlString : String) {
    if let url = URL(string: urlString) ?? URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}




