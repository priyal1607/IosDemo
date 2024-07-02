//
//  DatePickerViewController.swift
//  DemoPickerView
//
//  Created by Vikram Jagad on 24/04/19.
//  Copyright © 2019 Vikram Jagad. All rights reserved.
//

import UIKit

class DatePickerViewController: UIView
{
    //MARK:- Interface Builder
    //UIView
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewBtns: UIView!
    
    //UIButton
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    //DatePicker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //UILabel
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK:- Variables
    //Local
    private var initialSelection: Date!
    private var selectedDate: Date { return self.datePicker.date }
    private var doneAction: DatePickerDoneAction!
    private var sender: UIView!
    private var animated: Bool!
    private var VC: UIViewController!
    private let viewHeight: CGFloat = 260
    private lazy var slideInTransitioningDelegate = SlideInPresentationManager()
    
    //Public
    class var getInstance: DatePickerViewController {
        return sharedDatePickerViewControllerInstance
    }
    var btnDoneColor: UIColor = .clear
    var btnCancelColor: UIColor = .clear
    var viewBtnsColor: UIColor = .customWhite
    var pickerViewColor: UIColor = .customWhite
    var lblTitleColor: UIColor = .customBlack
    var btnDoneTitleColor:UIColor = .systemBlue
    var btnCancelTitleColor:UIColor = .systemBlue
    var btnDoneTitleFont: UIFont = .regularSystemFont(withSize: .value)
    var btnCancelTitleFont: UIFont = .regularSystemFont(withSize: .value)
    var lblTitleFont: UIFont = .boldSystemFont(withSize: .medium)
    var btnDoneTitle: String?
    var btnCancelTitle: String?
    var lblTitleText: String = .LanguageLocalisation.select
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(initialSelection: Date?, maximumDate: Date? = nil, minimumDate: Date? = nil, datePickerMode: UIDatePicker.Mode, doneAction: @escaping DatePickerDoneAction, animated: Bool, origin: UIView)
    {
        self.init(frame: .zero)
        self.VC = UIViewController()
        self.initialSelection = initialSelection
        self.doneAction = doneAction
        self.sender = origin
        self.animated = animated
        self.datePicker.datePickerMode = datePickerMode
        self.datePicker.minimumDate = minimumDate
        self.datePicker.maximumDate = maximumDate
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle = .wheels
        }
        self.setInitialValue()
    }
    
    //MARK:- Private Methods
    private func commonInit()
    {
        Bundle.main.loadNibNamed("DatePickerViewController", owner: self, options: nil)
        self.viewContent.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(viewContent)
    }
    
    private func setInitialValue()
    {
        if (self.initialSelection != nil) {
            self.datePicker.setDate(self.initialSelection, animated: self.animated)
        } else if (self.datePicker.maximumDate != nil) {
            self.datePicker.setDate(self.datePicker.maximumDate!, animated: self.animated)
        } else if (self.datePicker.minimumDate != nil) {
            self.datePicker.setDate(self.datePicker.minimumDate!, animated: self.animated)
        } else {
//            self.selectedDate = Date()
        }
    }
    
    private func addSelfToVC()
    {
        VC.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: VC.view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: VC.view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: VC.view.bottomAnchor, constant: -bottomMarginFromSafeArea).isActive = true
        self.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
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
    }
    
    private func removeAllSubviews()
    {
        self.removeFromSuperview()
        self.viewContent.removeFromSuperview()
        self.VC = nil
        self.initialSelection = nil
        self.sender = nil
        self.animated = nil
    }
    
    private func removeAllSubviewsOfSingletonClass()
    {
        if (DatePickerViewController.getInstance.VC != nil)
        {
            DatePickerViewController.getInstance.removeFromSuperview()
            DatePickerViewController.getInstance.viewContent.removeFromSuperview()
            DatePickerViewController.getInstance.VC = nil
            DatePickerViewController.getInstance.initialSelection = nil
            DatePickerViewController.getInstance.sender = nil
            DatePickerViewController.getInstance.animated = nil
        }
    }
    
    private func prepareView()
    {
        btnCancel.backgroundColor = btnCancelColor
        btnCancel.titleLabel?.font = btnCancelTitleFont
        if (btnCancelTitle == nil) {
            btnCancelTitle = .LanguageLocalisation.cancel
        }
        btnCancel.setTitle(btnCancelTitle, for: .normal)
        btnDone.backgroundColor = btnDoneColor
        btnDone.titleLabel?.font = btnDoneTitleFont
        if (btnDoneTitle == nil) {
            btnDoneTitle = .LanguageLocalisation.done
        }
        btnDone.setTitle(btnDoneTitle, for: .normal)
        viewMain.backgroundColor = pickerViewColor
        viewBtns.backgroundColor = viewBtnsColor
        btnDone.setTitleColor(btnDoneTitleColor, for: .normal)
        btnCancel.setTitleColor(btnCancelTitleColor, for: .normal)
        lblTitle.text = lblTitleText
        lblTitle.font = lblTitleFont
        lblTitle.textColor = lblTitleColor
    }
    
    //Public Methods
    func show(onVC: UIViewController?)
    {
        UIView.hideKeyBoard()
        self.addSelfToVC()
        self.prepareView()
        slideInTransitioningDelegate.direction = .bottom
        slideInTransitioningDelegate.ratio = (viewHeight + bottomMarginFromSafeArea)/SCREEN_HEIGHT
        VC.transitioningDelegate = slideInTransitioningDelegate
        VC.modalPresentationStyle = .custom
        if let presentOnVC = onVC
        {
            presentOnVC.present(VC, animated: true) {
                self.btnCancelTitle = nil
                self.btnDoneTitle = nil
            }
        }
        else if let presentOnVC = delegateRootVCPicker
        {
            presentOnVC.present(VC, animated: true) {
                self.btnCancelTitle = nil
                self.btnDoneTitle = nil
            }
            /*VC.modalPresentationStyle = .overCurrentContext
            self.VC.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            presentOnVC.present(VC, animated: true) {
                
            }*/
        }
    }
    
    //Class Methods
    class func show(initialSelection: Date?, maximumDate: Date? = nil, minimumDate: Date? = nil, datePickerMode: UIDatePicker.Mode, doneAction: @escaping DatePickerDoneAction, animated: Bool, origin: UIView, onVC: UIViewController?)
    {
        self.getInstance.commonInit()
        self.getInstance.VC = UIViewController()
        self.getInstance.initialSelection = initialSelection
        self.getInstance.doneAction = doneAction
        self.getInstance.sender = origin
        self.getInstance.animated = animated
        self.getInstance.datePicker.datePickerMode = datePickerMode
        self.getInstance.datePicker.minimumDate = minimumDate
        self.getInstance.datePicker.maximumDate = maximumDate
        if #available(iOS 13.4, *) {
            self.getInstance.datePicker.preferredDatePickerStyle = .wheels
        }
        self.getInstance.setInitialValue()
        self.getInstance.show(onVC: onVC)
    }
    
    //MARK:- IBAction Outlets
    @IBAction func datePickerDidChangeValue(_ sender: UIDatePicker)
    {
//        self.selectedDate = sender.date
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton)
    {
        VC.dismiss(animated: true) {
            self.removeAllSubviews()
            self.removeAllSubviewsOfSingletonClass()
        }
    }
    
    @IBAction func btnDoneTapped(_ sender: UIButton)
    {
        doneAction(self.selectedDate)
        VC.dismiss(animated: true) {
            self.removeAllSubviews()
            self.removeAllSubviewsOfSingletonClass()
        }
    }
}
