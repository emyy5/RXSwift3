//
//  CountriesViewController.swift
//  RXSwift3
//
//  Created by Eman Khaled on 29/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesViewController: UIViewController {
let disposeBag = DisposeBag()
    @IBOutlet weak var countriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()

        // Do any additional setup after loading the view.
    }
    func setUpTableView() {
        let countryObservable = Observable<[String]>.of(["Alex","Cairo","Egypt"])
        countryObservable.bind(to: countriesTableView.rx.items(cellIdentifier: "CountriesTableViewCell", cellType: CountriesTableViewCell.self)) { index, element , cell in
            cell.setCellData(countryName: element)
        }.disposed(by: disposeBag)
        countriesTableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print(indexPath.row)
        })
    }

}
