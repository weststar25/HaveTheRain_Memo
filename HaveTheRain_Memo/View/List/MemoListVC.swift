//
//  MemoListVC.swift
//  HaveTheRain_Memo
//
//  Created by 김지우 on 16/02/2020.
//  Copyright © 2020 김지우. All rights reserved.
//

import UIKit
import Kingfisher
import Realm
import RealmSwift

class MemoListVC: UIViewController {
    @IBOutlet weak var memoTableView: UITableView!
    
    public var memoList: Results<MemoVO>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAttribute()
    }
    
    @IBAction func makeMemoAction(_ sender: UIBarButtonItem) {
        let memoDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoDetailVC") as! MemoDetailVC
        
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
    
    func setAttribute() {
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init("#FF6813")]
    }
    
    
    func getMemoList() {
        do {
            let realm = try Realm()
            memoList = realm.objects(MemoVO.self)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension MemoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let memoList = self.memoList else { return 0 }
        return memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath) as! MemoListCell
        guard let memoList = self.memoList else { return cell }
        if let image = memoList[indexPath.row].images.first {
            cell.thumbnailImg.image = image
        } else {
            cell.thumbnailImg.image = UIImage(named: "memo_default")
        }
    
        cell.titleLabel.text = memoList[indexPath.row].title
        cell.summaryLabel.text = memoList[indexPath.row].content
        
        return cell
    }
}
