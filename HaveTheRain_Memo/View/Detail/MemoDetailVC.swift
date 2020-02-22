//
//  MemoDetailVC.swift
//  HaveTheRain_Memo
//
//  Created by 김지우 on 16/02/2020.
//  Copyright © 2020 김지우. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MemoDetailVC: UIViewController {
    enum MemoState: Int {
        case New = 1
        case Edit = 2
        case Read = 3
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private let picker: UIImagePickerController = UIImagePickerController()
    
    public var memo: MemoVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAttribute()
        self.setViewAttribute()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func moreBtnaction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "편집", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
            
        }))
        alert.addAction(UIAlertAction(title: "삭제", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
            
        }))

        alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setAttribute() {
        self.titleTextField.delegate = self
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        
        self.picker.delegate = self
        self.picker.allowsEditing = false
    }
    
    func setViewAttribute() {
        self.navigationController?.navigationBar.tintColor = UIColor.init("#FF6813")
        self.contentTextView.layer.addBorder([.top], color: UIColor.init("#333333"), width: 1.0)
        self.imageCollectionView.layer.addBorder([.top], color: UIColor.init("#333333"), width: 1.0)
    }
}

extension MemoDetailVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 30)
    }
}

extension MemoDetailVC : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        guard let memo = self.memo else {
            dismiss(animated: true, completion: nil)
            return
        }
        memo.images.append(newImage)
        dismiss(animated: true, completion: nil)
    }
}

extension MemoDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let memo = self.memo else { return 1 }
        return memo.images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let btnCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeImageAddBtnCell", for: indexPath) as! MemeImageAddBtnCell
            return btnCell
        } else {
            let imgCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoImageCell", for: indexPath) as! MemoImageCell
            return imgCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "카메라", style: UIAlertAction.Style.default, handler: { (_) in
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "사진 & 비디오 보관함", style: UIAlertAction.Style.default, handler: { (_) in
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "URL로 가져오기", style: UIAlertAction.Style.default, handler: { (_) in
                let dialog = UIAlertController(title: "URL로 가져오기", message: "URL 주소를 입력하세요", preferredStyle: .alert)
                dialog.addTextField(configurationHandler: nil)
                dialog.addAction(UIAlertAction(title: "가져오기", style: UIAlertAction.Style.default, handler: { (_) in
                    print("HTR \(dialog.textFields!.first!.text)")
                }))
                dialog.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel))
                
                self.present(dialog, animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
    }
}
