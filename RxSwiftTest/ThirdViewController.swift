//
//  ThirdViewController.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 03/11/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    typealias Item = String
    typealias Identity = String
    
    var identity: Identity { return title }
    var items: [Item] { return data }
    
    init(original: AnimatedSectionModel, items: [String]) {
        self = original
        data = items
    }
}

extension String {
    public typealias Identity = String
    public var identity: Identity { return self }
}

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var longPressGestureRecogniser: UILongPressGestureRecognizer!
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>(configureCell: { _, collectionView, indexPath, title in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.titleLabel.text = title
        return cell
    }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
        header.titleLabel.text = "Section: \(indexPath.section)"
        return header
    }, canMoveItemAtIndexPath: { _, _ in true })

//    }, configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
//        header.titleLabel.text = "Section: \(indexPath.section)"
//        return header
//    }, canMoveItemAtIndexPath: { _, _ in true })﻿
    
    // 'Variable' Deprecated
    /*
    let data = Variable([
        AnimatedSectionModel(title: "Section: 0", data: ["0-0"])
    ])
    */
    
    let data = BehaviorRelay(value: [
        AnimatedSectionModel(title: "Section: 0", data: ["0-0"])
    ])

    override func viewDidLoad() {
        super.viewDidLoad()

//        dataSource.configureCell = {_, collectionView, indexPath, title in
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
//            cell.titleLabel.text = title
//            return cell
//        }
        
//        dataSource.configureSupplementaryView = { dataSource, collectionView, kind, indexPath in
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
//            header.titleLabel.text = "Section: \(self.data.value.count)"
//            return header
//        }
        
        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        addBarButtonItem.rx.tap.asDriver().drive(onNext: {
            let section = self.data.value.count
            let items: [String] = {
                var items = [String]()
                let random = arc4random_uniform(5) + 1
                (0...random).forEach {
                    items.append("\(section)-\($0)")
                }
                return items
            }()
            
//            self.data.value += [AnimatedSectionModel(title: "Section: \(section)", data: items)]
//            self.data.accept([AnimatedSectionModel(title: "Section: \(section)", data: items)])
            
            // Huge performance hit with up to 70% execution time
            self.data.accept(self.data.value + [AnimatedSectionModel(title: "Section: \(section)", data: items)])
        }).disposed(by: disposeBag)
        
        longPressGestureRecogniser.rx.event.subscribe(onNext: {
            switch $0.state {
            case .began:
                guard let selectedIndexPath = self.collectionView.indexPathForItem(at: $0.location(in: self.collectionView)) else { break }
                self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            case .changed:
                self.collectionView.updateInteractiveMovementTargetPosition($0.location(in: $0.view!))
            case .ended:
                self.collectionView.endInteractiveMovement()
            default:
                self.collectionView.cancelInteractiveMovement()
            }
        }).disposed(by: disposeBag)
    }
}
