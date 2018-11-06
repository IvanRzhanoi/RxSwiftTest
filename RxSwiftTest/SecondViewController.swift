//
//  SecondViewController.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 03/11/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SecondViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    // Creating Observable with an array of elements
    
//    let food = Observable.just([
//        Food(name: "Kids Burger", flickrID: "kids-burger"),
//        Food(name: "Lasagna", flickrID: "lasagna"),
//        Food(name: "Sausage", flickrID: "sausage"),
//        Food(name: "Vegetables", flickrID: "vegetables")
//    ])
    
    let foodsData = SectionModelFood()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Food>>(configureCell: { _, tableView, indexPath, foods in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = foods.name
        cell.detailTextLabel?.text = foods.flickrID
        cell.imageView?.image = foods.image
        return cell
    })
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        food.bind(to: myTableView.rx.items(cellIdentifier: "Cell")) { row, foods, cell in
//            cell.textLabel?.text = foods.name
//            cell.detailTextLabel?.text = foods.flickrID
//            cell.imageView?.image = foods.image
//        }.disposed(by: disposeBag)
//
//        myTableView.rx.modelSelected(Food.self).subscribe(onNext: {
//            print("You have selected \($0)")
//        }).disposed(by: disposeBag)
        
        dataSource.titleForHeaderInSection = { data, section in
            data.sectionModels[section].model
        }

        foodsData.foods.bind(to: myTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        myTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//extension SecondViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return food.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell") else {
//            return UITableViewCell()
//        }
//
//        let foods = food[indexPath.row]
//        cell.textLabel?.text = foods.name
//        cell.detailTextLabel?.text = foods.flickrID
//        cell.imageView?.image = foods.image
//
//        return cell
//    }
//}

extension SecondViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You have selected \(food[indexPath.row])")
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(64) + 32)
    }
}
