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

class SecondViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    // Creating Observable with an array of elements
    
    let food = Observable.just([
        Food(name: "Kids Burger", flickrID: "kids-burger"),
        Food(name: "Lasagna", flickrID: "lasagna"),
        Food(name: "Sausage", flickrID: "sausage"),
        Food(name: "Vegetables", flickrID: "vegetables")
    ])
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        food.bind(to: myTableView.rx.items(cellIdentifier: "Cell")) { row, foods, cell in
            cell.textLabel?.text = foods.name
            cell.detailTextLabel?.text = foods.flickrID
            cell.imageView?.image = foods.image
        }.disposed(by: disposeBag)
        
        myTableView.rx.modelSelected(Food.self).subscribe(onNext: {
            print("You have selected \($0)")
        }).disposed(by: disposeBag)
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
//
//extension SecondViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You have selected \(food[indexPath.row])")
//    }
//}
