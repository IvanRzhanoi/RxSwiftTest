//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Ivan Rzhanoi on 01/10/2018.
//  Copyright © 2018 Ivan Rzhanoi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
//    @IBOutlet weak var myTextField: UITextField!
//    @IBOutlet weak var myButton: UIButton!
//
//    let disposeBag = DisposeBag()
////    let textFieldText = Variable<String>("")
//    let textFieldRelay = BehaviorRelay(value: "")
//    let buttonSubject = PublishSubject<String>()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        myTextField.rx.text.orEmpty.bind(to: textFieldRelay).disposed(by: disposeBag)
//        textFieldRelay.asObservable().subscribe(onNext: {
//            print($0)
//        }).disposed(by: disposeBag)
//
//        myButton.rx.tap.map{ "Hello!" }.bind(to: buttonSubject).disposed(by: disposeBag)
//        buttonSubject.asObservable().subscribe(onNext: {
//            print($0)
//        }).disposed(by: disposeBag)
//    }
    
    // TapGestureRecogniser
    @IBOutlet weak var myTapGestureRecogniser: UITapGestureRecognizer!
    
    // Button and Label
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myButtonLabel: UILabel!
    
    // Slider and ProgressView
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var myProgressView: UIProgressView!
    
    // SegmentedControl and Label
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySegmentedControlLabel: UILabel!
    
    // DatePicker and Label
    @IBOutlet weak var myDatePicker: UIDatePicker!
    @IBOutlet weak var myDatePickerLabel: UILabel!
    
    // TextField and Label
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextFieldLabel: UILabel!
    
    // TextView and Label
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myTextViewLabel: UILabel!
    
    // Switch and ActivityIndicator
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    // Stepper and Label
    @IBOutlet weak var myStepper: UIStepper!
    @IBOutlet weak var myStepperLabel: UILabel!
    
    // DisposeBag - in this example is not a property. This is needed during system call of deinit in order to free the resources for Observable objects
    let disposeBag = DisposeBag()
    
    // DateFormat for DatePicker
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        myTapGestureRecogniser.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
//            self.myTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        myTextField.rx.text.map{ $0 }.bind {
            self.myTextFieldLabel.text = $0
        }.disposed(by: disposeBag)
        
        myTextView.rx.text.bind(onNext: {
            self.myTextViewLabel.text = "Character count: \($0!.count)"
        }).disposed(by: disposeBag)
//        //bindNext {
//            self.myTextViewLabel.text = "Character count: \($0?.count)"
//        }.disposed(by: disposeBag)
    }
}

