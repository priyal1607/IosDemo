//
//  PickerConstants.swift
//  DemoPickerView
//
//  Created by Vikram Jagad on 25/04/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

//MARK:- Enum
enum PickerType: Int
{
    case single = 0
    //case date
    case multiple
}

//MARK:- TypeAlias
typealias StringPickerDoneAction = (([Int], Any?) -> ())
typealias DatePickerDoneAction = (Date) -> ()

//MARK:- Constants
let IS_iPad = UIDevice.current.userInterfaceIdiom == .pad
let screenWidth = UIScreen.main.bounds.size.width

//MARK:- Protocols
protocol StringPickerViewDelegate
{
    func didSelect(didSelectRow row: Int, inComponent component: Int, value: Any)
    
}

//MARK:- SharedInstances
let sharedStringPickerViewControllerInstance = StringPickerViewController()
let sharedDatePickerViewControllerInstance = DatePickerViewController()


let appDelegatePicker = UIApplication.shared.delegate as! AppDelegate

var delegateRootVCPicker: UIViewController? {
    
    return appDelegatePicker.window?.rootViewController
    
}
