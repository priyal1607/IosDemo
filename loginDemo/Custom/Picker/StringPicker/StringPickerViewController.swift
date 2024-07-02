//
//  StringPickerViewController.swift
//  DemoPickerView
//
//  Created by Vikram Jagad on 24/04/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class StringPickerViewController: NSObject
{
    //MARK:- Variables
    //Local Variables
    private var VC: UIViewController!
    private var pickerType: PickerType = .single
    private var initialSelection: Any!
    private var arrSource: [[Any]]!
    private var pickerView: UIPickerView!
    private var sender: UIView!
    //private var datePickerView: UIDatePicker!
    private var btnCancel: UIButton!
    private var btnDone: UIButton!
    private var pickerViewDelegateDataSource: StringPickerViewDelegateDataSource!
    private var doneAction: StringPickerDoneAction!
    private var animated: Bool!
    private var selectedRow: Int = 0
    private var selectedValue: Any!
    private let barBtnHeight: CGFloat = 40
    private let barBtnTopBottomSpacing: CGFloat = 5
    private let viewPickerTag = 200
    private let btnCancelTag = 300
    private let btnDoneTag = 400
    private let viewBtnsTag = 500
    private let viewHeight: CGFloat = 260
    private lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    //Public
    private class var getInstance: StringPickerViewController {
        return sharedStringPickerViewControllerInstance
    }
    var btnDoneColor: UIColor = .clear
    var btnCancelColor: UIColor = .clear
    var viewBtnsColor: UIColor = .customWhite
    var pickerViewColor: UIColor = .customWhite
    var btnDoneTitleFont: UIFont = .regularSystemFont(withSize: .value)
    var btnCancelTitleFont: UIFont = .regularSystemFont(withSize: .value)
    var btnDoneTitleColor:UIColor = .systemBlue
    var btnCancelTitleColor:UIColor = .systemBlue
    var btnDoneTitle: String = .LanguageLocalisation.done
    var btnCancelTitle: String = .LanguageLocalisation.cancel
    
    //MARK:- Initializers
    override init()
    {
        super.init()
    }
    
    init(pickerType: PickerType, initialSelection: Any?, arrSource: [[Any]]?, doneAction: @escaping StringPickerDoneAction, animated: Bool, origin: UIView)
    {
        super.init()
        self.pickerType = pickerType
        self.initialSelection = initialSelection
        self.doneAction = doneAction
        self.animated = animated
        self.VC = UIViewController()
        self.sender = origin
        self.setBtns()
        self.arrSource = arrSource
        self.pickerView = UIPickerView()
        self.pickerViewDelegateDataSource = StringPickerViewDelegateDataSource(arrSource: self.arrSource)
        self.pickerView.delegate = self.pickerViewDelegateDataSource
        self.pickerView.dataSource = self.pickerViewDelegateDataSource
        self.pickerViewDelegateDataSource.delegate = self
        self.setInitialSelection()
    }
    
    //MARK:- Class Methods
    class func show(pickerType: PickerType, initialSelection: Any?, arrSource: [[Any]]?, doneAction: @escaping StringPickerDoneAction, animated: Bool, origin: UIView, onVC: UIViewController? = nil)
    {
        self.getInstance.pickerType = pickerType
        self.getInstance.initialSelection = initialSelection
        self.getInstance.doneAction = doneAction
        self.getInstance.animated = animated
        self.getInstance.VC = UIViewController()
        self.getInstance.sender = origin
        self.getInstance.setBtns()
        self.getInstance.arrSource = arrSource
        self.getInstance.pickerView = UIPickerView()
        self.getInstance.pickerViewDelegateDataSource = StringPickerViewDelegateDataSource(arrSource: self.getInstance.arrSource)
        self.getInstance.pickerView.delegate = self.getInstance.pickerViewDelegateDataSource
        self.getInstance.pickerView.dataSource = self.getInstance.pickerViewDelegateDataSource
        self.getInstance.pickerViewDelegateDataSource.delegate = self.getInstance
        self.getInstance.setInitialSelection()
        self.getInstance.show(onVC: onVC)
    }
    
    //MARK:- Public Methods
    
    //MARK:- Public Methods
    func show(onVC: UIViewController?) {
        UIView.hideKeyBoard()
        if (onVC != nil) {
            btnCancel.backgroundColor = btnCancelColor
            btnCancel.titleLabel?.font = btnCancelTitleFont
            btnCancel.setTitle(btnCancelTitle.localizedString, for: .normal)
            btnDone.backgroundColor = btnDoneColor
            btnDone.titleLabel?.font = btnDoneTitleFont
            btnDone.setTitleColor(btnDoneTitleColor, for: .normal)
            btnCancel.setTitleColor(btnCancelTitleColor, for: .normal)
            btnDone.setTitle(btnDoneTitle.localizedString, for: .normal)
            self.addViewMain()
            self.addPickerView()
            self.setBarButtons()
            if let viewPicker = VC.view.viewWithTag(viewPickerTag)
            {
                viewPicker.backgroundColor = pickerViewColor
            }
            if let viewBtns = VC.view.viewWithTag(viewBtnsTag)
            {
                viewBtns.backgroundColor = viewBtnsColor
            }
            slideInTransitioningDelegate.direction = .bottom
            slideInTransitioningDelegate.ratio = (viewHeight + barBtnHeight + bottomMarginFromSafeArea)/SCREEN_HEIGHT
            VC.transitioningDelegate = slideInTransitioningDelegate
            VC.modalPresentationStyle = .custom
            onVC?.present(VC, animated: true, completion: nil)
        } else if let presentOnVC = delegateRootVCPicker {
            btnCancel.backgroundColor = btnCancelColor
            btnCancel.titleLabel?.font = btnCancelTitleFont
            btnCancel.setTitle(.LanguageLocalisation.cancel, for: .normal)
            btnDone.backgroundColor = btnDoneColor
            btnDone.titleLabel?.font = btnDoneTitleFont
            btnDone.setTitleColor(btnDoneTitleColor, for: .normal)
            btnCancel.setTitleColor(btnCancelTitleColor, for: .normal)
            btnDone.setTitle(.LanguageLocalisation.done, for: .normal)
            self.addViewMain()
            self.addPickerView()
            self.setBarButtons()
            if let viewPicker = VC.view.viewWithTag(viewPickerTag)
            {
                viewPicker.backgroundColor = pickerViewColor
            }
            if let viewBtns = VC.view.viewWithTag(viewBtnsTag)
            {
                viewBtns.backgroundColor = viewBtnsColor
            }
            slideInTransitioningDelegate.direction = .bottom
            slideInTransitioningDelegate.ratio = (viewHeight + barBtnHeight + bottomMarginFromSafeArea)/SCREEN_HEIGHT
            VC.transitioningDelegate = slideInTransitioningDelegate
            VC.modalPresentationStyle = .custom
            presentOnVC.present(VC, animated: true, completion: nil)
        } else {
            print("No ViewController to present.")
        }
    }
    
    //MARK:- Private Methods
    private func setBtns()
    {
        btnCancel = UIButton(type: .custom)
        btnCancel.tag = btnCancelTag
        btnCancel.addTarget(self, action: #selector(btnCancelTapped(_:)), for: .touchUpInside)
        btnDone = UIButton(type: .custom)
        btnDone.tag = btnDoneTag
        btnDone.addTarget(self, action: #selector(btnDoneTapped(_:)), for: .touchUpInside)
    }
    
    private func addViewMain()
    {
        let viewPicker = UIView()
        viewPicker.tag = viewPickerTag
        VC.view.addSubview(viewPicker)
        viewPicker.translatesAutoresizingMaskIntoConstraints = false
        viewPicker.bottomAnchor.constraint(equalTo: VC.view.bottomAnchor, constant: -bottomMarginFromSafeArea).isActive = true
        viewPicker.leadingAnchor.constraint(equalTo: VC.view.leadingAnchor).isActive = true
        viewPicker.trailingAnchor.constraint(equalTo: VC.view.trailingAnchor).isActive = true
    }
    
    private func addPickerView()
    {
        if let viewPicker = VC.view.viewWithTag(viewPickerTag)
        {
            viewPicker.addSubview(pickerView)
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            pickerView.bottomAnchor.constraint(equalTo: viewPicker.bottomAnchor).isActive = true
            pickerView.leadingAnchor.constraint(equalTo: viewPicker.leadingAnchor).isActive = true
            pickerView.trailingAnchor.constraint(equalTo: viewPicker.trailingAnchor).isActive = true
            pickerView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        }
        else
        {
            print("No View To Present.")
        }
    }
    
    private func setBarButtons()
    {
        if let viewPicker = VC.view.viewWithTag(viewPickerTag)
        {
            let viewBtns = UIView()
            viewBtns.isUserInteractionEnabled = true
            VC.view.addSubview(viewBtns)
            viewBtns.tag = viewBtnsTag
            viewBtns.translatesAutoresizingMaskIntoConstraints = false
            viewBtns.leadingAnchor.constraint(equalTo: viewPicker.leadingAnchor).isActive = true
            viewBtns.trailingAnchor.constraint(equalTo: viewPicker.trailingAnchor).isActive = true
            viewBtns.topAnchor.constraint(equalTo: viewPicker.topAnchor).isActive = true
            if (self.pickerView != nil)
            {
                viewBtns.bottomAnchor.constraint(equalTo: pickerView.topAnchor).isActive = true
            }
            else
            {
                viewBtns.bottomAnchor.constraint(equalTo: VC.view.bottomAnchor, constant: -bottomMarginFromSafeArea).isActive = true
            }
            if (bottomMarginFromSafeArea > 0)
            {
                let bottomView = UIView()
                bottomView.backgroundColor = pickerViewColor
                bottomView.translatesAutoresizingMaskIntoConstraints = false
                VC.view.addSubview(bottomView)
                bottomView.leadingAnchor.constraint(equalTo: VC.view.leadingAnchor).isActive = true
                bottomView.trailingAnchor.constraint(equalTo: VC.view.trailingAnchor).isActive = true
                bottomView.heightAnchor.constraint(equalToConstant: bottomMarginFromSafeArea).isActive = true
                bottomView.bottomAnchor.constraint(equalTo: VC.view.bottomAnchor, constant: 0).isActive = true
            }
            viewBtns.addSubview(btnCancel)
            btnCancel.translatesAutoresizingMaskIntoConstraints = false
            btnCancel.leadingAnchor.constraint(equalTo: viewBtns.leadingAnchor, constant: barBtnTopBottomSpacing).isActive = true
            btnCancel.widthAnchor.constraint(equalTo: btnCancel.heightAnchor, multiplier: 2).isActive = true
            btnCancel.heightAnchor.constraint(equalToConstant: barBtnHeight).isActive = true
            btnCancel.topAnchor.constraint(equalTo: viewBtns.topAnchor, constant: barBtnTopBottomSpacing).isActive = true
            btnCancel.bottomAnchor.constraint(equalTo: viewBtns.bottomAnchor, constant: -barBtnTopBottomSpacing).isActive = true
            
            viewBtns.addSubview(btnDone)
            btnDone.translatesAutoresizingMaskIntoConstraints = false
            btnDone.topAnchor.constraint(equalTo: btnCancel.topAnchor).isActive = true
            btnDone.bottomAnchor.constraint(equalTo: btnCancel.bottomAnchor).isActive = true
            btnDone.widthAnchor.constraint(equalTo: btnCancel.widthAnchor).isActive = true
            btnDone.trailingAnchor.constraint(equalTo: viewBtns.trailingAnchor, constant: -barBtnTopBottomSpacing).isActive = true
            viewBtns.layoutIfNeeded()
        }
        else
        {
            print("No View To Present.")
        }
    }
    
    private func setInitialSelection()
    {
        if (self.initialSelection != nil)
        {
            switch self.pickerType {
            case .single:
                self.setInitialValueForTextType()
            case .multiple:
                self.setInitialValueForOtherType()
                break
            }
        }
    }
    
    private func setInitialValueForTextType()
    {
        if (self.initialSelection != nil)
        {
            if let str = self.initialSelection as? String
            {
                if let arr = self.arrSource[0] as? [String]
                {
                    self.selectedRow = arr.firstIndex(of: str) ?? 0
                    self.selectedValue = arr[self.selectedRow]
                    self.pickerView.selectRow(arr.firstIndex(of: str) ?? 0, inComponent: 0, animated: self.animated)
                }
                else
                {
                    let arr = self.arrSource[0]
                    self.checkAndSelect(str: str, arr: arr)
                }
            }
            else
            {
                let arr = self.arrSource[0]
                let str = String(describing: self.initialSelection!)
                self.checkAndSelect(str: str, arr: arr)
            }
        }
    }
    
    private func checkAndSelect(str: String, arr: [Any])
    {
        for i in 0..<arr.count
        {
            if let value = arr[i] as? String
            {
                if (value == str)
                {
                    self.selectedRow = i
                    self.selectedValue = arr[self.selectedRow]
                    self.pickerView.selectRow(i, inComponent: 0, animated: self.animated)
                }
            }
            else
            {
                let value = String(describing: arr[i])
                if (value == str)
                {
                    self.selectedRow = i
                    self.selectedValue = arr[self.selectedRow]
                    self.pickerView.selectRow(i, inComponent: 0, animated: self.animated)
                }
            }
        }
    }
    
    private func setInitialValueForOtherType()
    {
        
    }
    
    private func removeAllSubviews()
    {
        if let viewPicker = VC.view.viewWithTag(viewPickerTag)
        {
            for subview in viewPicker.subviews
            {
                subview.removeFromSuperview()
            }
            viewPicker.removeFromSuperview()
        }
        self.VC = nil
        self.initialSelection = nil
        self.arrSource = nil
        self.pickerView = nil
        self.pickerViewDelegateDataSource = nil
        self.doneAction = nil
        self.animated = nil
        self.btnCancel = nil
        self.btnDone = nil
    }
    
    private func removeAllSubviewsOfSingletonClass()
    {
        if (StringPickerViewController.getInstance.VC != nil)
        {
            if let viewPicker = StringPickerViewController.getInstance.VC.view.viewWithTag(StringPickerViewController.getInstance.viewPickerTag)
            {
                for subview in viewPicker.subviews
                {
                    subview.removeFromSuperview()
                }
                viewPicker.removeFromSuperview()
            }
            StringPickerViewController.getInstance.VC = nil
            StringPickerViewController.getInstance.initialSelection = nil
            StringPickerViewController.getInstance.arrSource = nil
            StringPickerViewController.getInstance.pickerView = nil
            StringPickerViewController.getInstance.pickerViewDelegateDataSource = nil
            StringPickerViewController.getInstance.doneAction = nil
            StringPickerViewController.getInstance.animated = nil
            StringPickerViewController.getInstance.btnCancel = nil
            StringPickerViewController.getInstance.btnDone = nil
        }
    }
    
    //MARK:- IBAction
    @objc func btnCancelTapped(_ sender: UIButton)
    {
        VC.dismiss(animated: true) {
            self.removeAllSubviews()
            self.removeAllSubviewsOfSingletonClass()
        }
    }
    
    @objc func btnDoneTapped(_ sender: UIButton)
    {
        self.doneAction([selectedRow], selectedValue)
        VC.dismiss(animated: true) {
            self.removeAllSubviews()
            self.removeAllSubviewsOfSingletonClass()
        }
    }
}

//MARK:- StringPickerViewDelegate Methods
extension StringPickerViewController: StringPickerViewDelegate
{
    func didSelect(didSelectRow row: Int, inComponent component: Int, value: Any)
    {
        self.selectedRow = row
        self.selectedValue = value
    }
}
