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
    
    var timerLabel: UILabel!
    
    var cellState = Array<Int>(repeating:0, count:25)
    
    var cellRow: Float = 5
    
    // 時間計測用の変数.
    var count : Float = 0
    
    // タイマー
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cellStateランダム
        for _ in 1...1 {
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
        
        // CollectionViewを生成.
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.backgroundColor = UIColor.gray
        
        myCollectionView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        myCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        
        
        //Text Label
        timerLabel = UILabel()
        timerLabel.backgroundColor = UIColor.yellow
        timerLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        timerLabel.textAlignment = .center
        
        //Stack View
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 16.0
        
        stackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(myCollectionView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // タイマーを作る
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.onUpdate(timer:)), userInfo: nil, repeats: true)

    }
    
    // TimerのtimeIntervalで指定された秒数毎に呼び出されるメソッド
    @objc func onUpdate(timer : Timer){
        
        // カウントの値1増加
        count += 1
        
        // 桁数を指定して文字列を作る
        let str = String(format: "%.0f", count)
        
        // ラベルに表示
        timerLabel.text = str
        
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
