import UIKit

class DashboardDatasourceDelegate: NSObject {
    
    typealias T = DashboardModel
    typealias tblview = UITableView
    typealias delegate = TblViewDelegate
    
    var arr : [T]
    var tblv  : tblview
    var del : delegate
    var array: [Section]
    var isSearch : Bool
 
    
    
    init(arr : [T] , tblv : tblview , del : delegate,array : [Section],isSearch : Bool){
        self.arr = arr
        self.tblv = tblv
        self.del = del
        self.array = array
        self.isSearch = isSearch
        super.init()
        setupTableView()
    }
    
    func reload(arr : [T] , isSearch :Bool , array : [Section]) {
        self.arr = arr
        self.array = array
        self.isSearch = isSearch
        
        tblv.reloadData()
    }
    
    fileprivate func setupTableView()  {
    let nib = UINib(nibName: "DashboardTblViewCell", bundle: nil)
    tblv.register(nib, forCellReuseIdentifier: "DashboardTblViewCell")
        tblv.delegate = self
        tblv.dataSource = self

    }
}

extension  DashboardDatasourceDelegate : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.del.didSelect?(tbl: tableView, indexPath: indexPath)
        
      
    }
   
}

extension  DashboardDatasourceDelegate : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch {
            return 1
        } else {
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearch {
            return ""
        } else {
            return array[section].letter
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            return arr.count
        } else {
            return array[section].names.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblv.dequeueReusableCell(withIdentifier: "DashboardTblViewCell", for: indexPath) as! DashboardTblViewCell
        let section = indexPath.section
        if isSearch {
            cell.configureCell(data: arr[indexPath.row])
        } else {
            cell.configureCell(data: array[section].names[indexPath.row])
        }
        
        
        cell.layoutIfNeeded()
        cell.layoutSubviews()
        return cell
        
    }
}
