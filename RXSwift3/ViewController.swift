//
//  ViewController.swift
//  RXSwift3
//
//  Created by Eman Khaled on 28/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    var dispoBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // testZip()
       // testMerge()
        //testPublishSubject()
        testLabel()
        
    }
    func testLabel(){
        let publishSubject = PublishSubject<String>()
        publishSubject.bind(to: textLbl.rx.text).disposed(by: dispoBag)
        publishSubject.onNext("One")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            publishSubject.onNext("Two")
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            publishSubject.onNext("Three")
        })
    }

    func testPublishSubject(){
        let publishSubject = PublishSubject<Int>()
        publishSubject.onNext(1)
        publishSubject.subscribe(onNext: { value in
            print(value)
        }).disposed(by: dispoBag)
        publishSubject.onNext(2)
    }
    
    func testZip(){
        let observable1 = Observable<Int>.create{ observer in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            return Disposables.create()
        }
     
        let observable2 = Observable<String>.create{ observer in
            observer.onNext("one")
            observer.onNext("two")
            observer.onNext("three")
            observer.onNext("four")
            return Disposables.create()
        }
        Observable.zip(observable1, observable2).subscribe(onNext: {value in
            print(value)
        }).disposed(by: dispoBag )
    }
    func testMerge(){
        let observable1 = Observable<Int>.create{ observer in
            observer.onNext(1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                observer.onNext(2)
                observer.onCompleted()
            })
            observer.onNext(3)
            return Disposables.create()
            
        }
        let observable2 = Observable<Int>.create{ observer in
            observer.onNext(10)
            observer.onNext(20)
            observer.onNext(30)
            observer.onCompleted()
            return Disposables.create()
        }
        Observable.merge(observable1, observable2)
            .subscribe(onNext: { value in
                print(value)
            }).disposed(by: dispoBag)
        
        
    }
}

