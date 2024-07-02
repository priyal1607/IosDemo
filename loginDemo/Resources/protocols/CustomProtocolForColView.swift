//
//  CustomProtocolForColView.swift
//  Social Justice
//
//  Created by Vikram Jagad on 26/02/21.
//

import UIKit

protocol CustomProtocolForDelegateDataSource {
    associatedtype T
    associatedtype ScrlView
    associatedtype Delegate
    var arrSource: [T] { get set }
    var delegate: Delegate { get set }
    var scrlView: ScrlView { get set }
    init(arrData: [T], delegate: Delegate, scrl: ScrlView)
    func setUpScrlView()
    func registerCell()
    func reloadScrlView(arr: [T])
}

typealias DICTIONARY = [String : Any]

protocol CustomProtocolDissmis {
    
    func dismissedIndex(strType:String)
}
