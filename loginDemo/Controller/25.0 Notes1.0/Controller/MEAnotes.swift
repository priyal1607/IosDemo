//
//  MEAnotes.swift
//  loginDemo
//
//  Created by Priyal on 04/10/23.
//

import UIKit

class MEAnotes: HeaderViewController {
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tblView: UITableView!
    var MEAtblViewDelegate : MEAtblViewDelegate!
    var arr : [NotesModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.setCustomCornerRadius(radius: btnAdd.frame.width/2)
        setUpHeader()
        //        self.arr = DBOperation.getInstance().NoteList()
        //        setupTblView()
        setData()
        // Do any additional setup after loading the view.
    }
    func setUpHeader() {
        self.setUpHeaderTitle(strHeaderTitle: "MY MEA Notes".localizedString)
        self.viewHeader.lblHeaderTitle.textColor = .white
        
    }
    private func setData() {
        self.arr = DBOperation.getInstance().NoteList().reversed()
        setupTblView()
    }
    
    
    func setupTblView() {
        if self.MEAtblViewDelegate == nil {
            self.MEAtblViewDelegate = .init(arrData: arr, delegate: self, tbl: tblView)
            self.MEAtblViewDelegate.comp = { tag in
                let dvc = presentNoteVC.instantiate(appStoryboard: .presentNote)
                dvc.note = self.arr[tag].note
                dvc.modalPresentationStyle = .custom
                dvc.isEdit = true
                dvc.updateAddNotesCalled = { str in
                    let date = Date()
                    let df = DateFormatter()
                    df.dateFormat = "HH:mm MMMM dd, yyyy"
                    let dateString = df.string(from: date)
                    if DBOperation.getInstance().updateMEANote(id: self.arr[tag].id, note: str, date_time: dateString) {
                        self.arr[tag].note = str
                        self.arr[tag].date_time = dateString
                        self.tblView.reloadData()
                    }
                    
                }
                
                self.present(dvc, animated: true, completion: nil)
                self.tblView.reloadData()
            }
            self.MEAtblViewDelegate.compdelete = {tag , sender in
                UIAlertController.showWith(title: "Are you sure you want to delete".localizedString, msg: nil, style: .alert, sender: sender, actionTitles: ["Yes","No"], actionStyles: [.destructive, .default], actionHandlers: [{ (yesAction) in
                    if DBOperation.getInstance().deleteNote(id: self.arr[tag].id) {
                        self.arr.remove(at: tag)
                        
                        self.setupTblView()
                        if (self.arr.count > 0) {
                            self.tblView.backgroundView = nil
                        } else {
                            self.tblView.backgroundView = UIView.makeNoRecordFoundView(frame: self.tblView.bounds, msg: "No Records Found")
                        }
                    }
                    
                }, nil]) }
        }
        else {
            self.MEAtblViewDelegate?.reloadData(arr: arr)
            
        }
    }
    @IBAction func btnAddAction(_ sender: UIButton) {
        let dvc = presentNoteVC.instantiate(appStoryboard: .presentNote)
        //        slideInTransitioningDelegate.direction = .bottom
        //        slideInTransitioningDelegate.ratio = 0.8
        //      dvc.transitioningDelegate = slideInTransitioningDelegate
        dvc.modalPresentationStyle = .custom
        dvc.updateAddNotesCalled = { str in
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "HH:mm MMMM dd, yyyy"
            let dateString = df.string(from: date)
            let model = NotesModel(note: str,
                                   id: UUID().uuidString, date_time: dateString)
            
            if DBOperation.getInstance().insertNotes(list: [model]) {
                self.arr.insert(model, at: 0)
                self.setupTblView()
            }
            
        }
        dvc.modalPresentationStyle = .overFullScreen
        self.present(dvc, animated: true)
    }
    
}
extension MEAnotes : TblViewDelegate {
    func didSelect(tbl: UITableView, indexPath: IndexPath) {
        let vc = pNoteVC.instantiate(appStoryboard: .pNote)
        vc.modalPresentationStyle = .custom
        vc.note = arr[indexPath.row].note
        self.navigationController?.present(vc, animated: true)
    }
}
extension MEAnotes {
    
}
