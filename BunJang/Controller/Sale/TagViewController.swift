//
//  TagViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit

protocol TagViewDelegate: AnyObject{
    func sendTags(_ tags: [String])
}
class TagViewController: UIViewController {
    weak var delegate: TagViewDelegate?
    @IBOutlet weak var TagTextField: UITextField!
    @IBOutlet weak var sharpImg: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var tag: [String] = []
    
    func setTextField() {
        TagTextField.leftView = sharpImg
        TagTextField.leftViewMode = .always
    }
    func setCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagCollectionViewCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        self.tagCollectionView.collectionViewLayout = flowLayout
        
    }
    @IBAction func addClcik(_ sender: Any) {
        guard let tagtext = self.TagTextField.text else {return}
        if tag.count == 5 {
            
        }
        else{
            tag.append(tagtext)
            TagTextField.text = ""
            DispatchQueue.main.async {
                self.tagCollectionView.reloadData()
            }
            self.delegate?.sendTags(self.tag)

        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        setTextField()
    }
}
extension TagViewController: UITextFieldDelegate {
    
}
extension TagViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as? TagCollectionViewCell else {return UICollectionViewCell()}
        
        cell.tagLabel.text = self.tag[indexPath.row]
        
        return cell
    }
}
extension TagViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = self.tag[indexPath.item]
        label.sizeToFit()
    
        
        let cellWidth = label.frame.width + 40
        
        return CGSize(width: cellWidth, height: 30)
    }
}

