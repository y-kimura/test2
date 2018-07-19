//
//  ViewController.swift
//  test2
//
//  Created by KIMURA YOSUKE on 2018/07/11.
//  Copyright © 2018年 KIMURA YOSUKE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myCollectionView : UICollectionView!
    
    var cellState = Array<Int>(repeating:0, count:25)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cellStateランダム
        for _ in 1...10 {
            culcCellState(Int.random(in: 0 ... 24))
        }
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        let cellWidth : CGFloat = (self.view.frame.width - 10.0 - (5 * 10)) / 5.0
        let cellHeight : CGFloat = cellWidth
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        layout.itemSize = CGSize(width: cellWidth , height:cellHeight)
        
        // セクション毎のヘッダーサイズ.
        layout.headerReferenceSize = CGSize(width:100,height:30)
        
        // CollectionViewを生成.
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.backgroundColor = UIColor.gray
        
        self.view.addSubview(myCollectionView)
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "I'am a test label"
        self.view.addSubview(label)
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        culcCellState(indexPath.row)
        
        myCollectionView?.reloadData()
        
    }
    
    private func culcCellState(_ index: Int){
        changeState(index)
        if (index > 4) {
            changeState(index - 5)
        }
        if(index < 20){
            changeState(index + 5)
        }
        if(index % 5 != 4){
            changeState(index + 1)
        }
        if(index % 5 != 0){
            changeState(index - 1)
        }
    }
    
    private func changeState(_ index: Int) {
        if (cellState[index] == 0) {
            cellState[index] = 1;
        } else {
            cellState[index] = 0;
        }
    }
    /*
     Cellの総数を返す
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    /*
     Cellに値を設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell",
                                                                             for: indexPath as IndexPath)
        
        if (cellState[indexPath.row] == 0) {
            cell.backgroundColor = UIColor.gray
        } else {
            cell.backgroundColor = UIColor.black
        }
        
        return cell
    }
    
}
