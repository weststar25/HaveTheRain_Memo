//
//  MemoListVC.swift
//  HaveTheRain_Memo
//
//  Created by 김지우 on 16/02/2020.
//  Copyright © 2020 김지우. All rights reserved.
//

import UIKit

class MemoListVC: UIViewController {
    @IBOutlet weak var memoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAttribute()
    }
    
    func setAttribute() {
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init("#FF6813")]
    }
    @IBAction func makeMemoAction(_ sender: UIBarButtonItem) {
        let memoDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoDetailVC") as! MemoDetailVC
        
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
}

extension MemoListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoListCell", for: indexPath)
        return cell
    }
}
