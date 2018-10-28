import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

import RxSwift
import UIKit

//example("Test") {
//    // --1--2--3---|->
//    // ---d-ff---f--x->
//    let intObservable = Observable.just(30)
//    let stringObservable = Observable.just("Hello")
//}

//example("just") {
//    // OBSERVABLE
//    let observable = Observable.just("Hello, RxSwift!")
//
//    // OBSERVER
//    observable.subscribe({ (event: Event<String>) in
//        print(event)
//    })
//}
//
//example("of") {
//    let observable = Observable.of(1, 2, 3, 4, 5)
//    observable.subscribe({ (event) in
//        print(event)
//    })
//
//    observable.subscribe {
//        print($0)
//    }
//}
//
//example("create") {
//    let items = [1, 2, 3, 4, 5]
//    Observable.from(items).subscribe(onNext: { (event) in
//        print(event)
//    }, onError: { (error) in
//        print(error)
//    }, onCompleted: {
//        print("ok")
//    }, onDisposed: {
//        print("Disposed")
//    })
//}
//
//example("disposable") {
//    let sequence = [1, 2, 3]
//    Observable.from(sequence).subscribe({ (event) in
//        print(event)
//    })
//    Disposable.dispose()
//}

//example("dispose") {
//    let sequence = [1, 2, 3]
//    let subscription = Observable.from(sequence)
//    subscription.subscribe({ (event) in
//        print(event)
//    }).dispose()
//}
//
//example("disposeBag") {
//    let disposeBag = DisposeBag()
//    let sequence = [1, 2, 3]
//    let subscription = Observable.from(sequence)
//    subscription.subscribe({ (event) in
//        print(event)
//    }).addDisposableTo(disposeBag)
//}
//
//example("takeUntil") {
//    let stopSequence = Observable.just(1).delaySubscription(2, scheduler: MainScheduler.instance)
//    let sequence = Observable.from([1, 2, 3]).takeUntil(stopSequence)
//    sequence.subscribe {
//        print($0)
//    }
//}

//example("filter") {
//    let sequence = Observable.of(1, 2, 20, 3, 40).filter{ $0 > 10 }
//    sequence.subscribe({ (event) in
//        print(event)
//    })
//}

//example("map") {
//    let sequence = Observable.of(1, 2, 3).map{ $0 * 10 }
//    sequence.subscribe({ (event) in
//        print(event)
//    })
//}

//example("merge") {
//    let firstSequence = Observable.of(1, 2, 3)
//    let secondSequence = Observable.of(4, 5, 6)
//
//    let bothSequences = Observable.of(firstSequence, secondSequence)
//    let mergeSequnces = bothSequences.merge()
//
//    mergeSequnces.subscribe({ (event) in
//        print(event)
//    })
//}


// MARK: - Subjects


//example("PublishSubject") {
//    let disposableBag = DisposeBag()
//    let subject = PublishSubject<String>()
//
//    subject.subscribe {
//        print("Subscription first:", $0)
//    }.disposed(by: disposableBag)
//
//    enum myError: Error {
//        case Test
//    }
//
//    subject.on(.next("Hello"))
//    //subject.onCompleted()
//    //subject.onError(myError.Test)
//    subject.onNext("RxSwift")
//
//    subject.subscribe(onNext: {
//        print("Subscription second:", $0)
//    }).disposed(by: disposableBag)
//
//    subject.onNext("Hi!")
//    subject.onNext("My name is Ivan")
//}

//example("BehaviorSubject") {
//    let disposableBag = DisposeBag()
//    let subject = BehaviorSubject(value: 1) // [1]
//
//    let firstSubscription = subject.subscribe(onNext: {
//        print(#line, $0)
//    }).disposed(by: disposableBag)
//
//    subject.onNext(2)   // [1, 2]
//    subject.onNext(3)   // [1, 2, 3]
//
//    let secondSubscription = subject.map({ $0 + 2 }).subscribe(onNext: {
//        print(#line, $0)    // [3]
//    }).disposed(by: disposableBag)
//}

//example("ReplaySubject") {
//    let disposableBag = DisposeBag()
//    let subject = ReplaySubject<String>.create(bufferSize: 1)
//
//    subject.subscribe {
//        print("First subscription: ", $0)
//    }.disposed(by: disposableBag)
//
//    subject.onNext("a")
//    subject.onNext("b")
//
//    subject.subscribe {
//        print("Second subscription: ", $0)
//    }.disposed(by: disposableBag)
//
//    subject.onNext("c")
//    subject.onNext("d")
    
//    let subject = ReplaySubject<Int>.create(bufferSize: 3)
//    subject.onNext(1)
//    subject.onNext(2)
//    subject.onNext(3)
//    subject.onNext(4)
//
//    subject.subscribe {
//        print($0)
//    }.disposed(by: disposableBag)
//}

//example("Variables") {
//    let disposableBag = DisposeBag()
//    let variable = Variable("A")
//
//    variable.asObservable().subscribe(onNext: {
//        print($0)
//    }).disposed(by: disposableBag)
//
//    variable.value = "B"
//}

//example("SideEffect") {
//    //-------1---2---3---|---> Source Observable
//    //       |   |   |
//    //  doOn{_ in action() } - Operator
//    //       |   |   |
//    //       |   |   |
//    //-------1---2---3---|---> Result Observable
//
//    // doOnNext
//    // doOnError
//    // doOnComplete
//
//    let disposableBag = DisposeBag()
//    let sequence = [0, 32, 100, 300, -40]
//    let temperatureSequence = Observable.from(sequence)
//    temperatureSequence.do(onNext: {
//        print("\($0)F = ", terminator: "")
//    }).map({
//        Double($0 - 32) * 5/9.0
//    }).subscribe(onNext: {
//        print(String(format: "%.1f", $0))
//    }).disposed(by: disposableBag)
//}

//example("without observeOn") {
//    _ = Observable.of(1, 2, 3).subscribe(onNext: {
//        print("\(Thread.current): ", $0)
//    }, onError: nil, onCompleted: {
//        print("Completed")
//    }, onDisposed: nil)
//}
//
//example("observeOn") {
//    _ = Observable.of(1, 2, 3)
//    .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
//        .subscribe(onNext: {
//            print("\(Thread.current): ", $0)
//        }, onError: nil, onCompleted: {
//            print("Completed")
//        }, onDisposed: nil)
//}

//example("subscribeOn and observableOn") {
//    let queue1 = DispatchQueue.global(qos: .default)
//    let queue2 = DispatchQueue.global(qos: .default)
//
//    print("Init Thread: \(Thread.current)")
//
//    _ = Observable<Int>.create({ (observer) -> Disposable in
//        print("Observable thread: \(Thread.current)")
//
//        observer.on(.next(1))
//        observer.on(.next(2))
//        observer.on(.next(3))
//
//        return Disposables.create()
//    })
//        .subscribeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queue1")).observeOn(SerialDispatchQueueScheduler(internalSerialQueueName: "queue2"))
//        .subscribe(onNext: {
//            print("Observable thread: \(Thread.current)", $0)
//        })
//}
