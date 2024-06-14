//
//  ViewController.swift
//  PaginationSwiftUIkit
//
//  Created by Rath! on 14/6/24.
//

import UIKit

class PaginationViewController: UIViewController {
    
    var page = 0
    var size = 100
    var allTotal = 0
    let viewModel = ViewModel()
    
    var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var result = [Result](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(pullRefreshControl), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        getDataApi(page: page, size: size, isLoading: true)
    }
    
    @objc func pullRefreshControl(){
        page = 0
        getDataApi(page: page, size: size, isLoading: false)
        let attributedTitle = NSAttributedString(string: "Pull to Refresh", attributes: [
            .font: UIFont.systemFont(ofSize: 16.0),
            .foregroundColor: UIColor.red
        ])
        
        refreshControl.attributedTitle = attributedTitle
        refreshControl.endRefreshing()
    }
    
    func getDataApi(page: Int, size: Int, isLoading: Bool){
        
        if isLoading{
            Loading.shared.showLoading()
        }
        
        ViewModel.getDataApi(page: page, size: size) { data in
            DispatchQueue.main.async { [self] in
                allTotal = data.count ?? 0
                
                if page == 0 {
                    result = data.results ?? []
                }else{
                    result += data.results ?? []
                }
                tableView.hideLoadingSpinner()
                Loading.shared.hideLoading()
            }
        }
    }
}


extension PaginationViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        let data = result[indexPath.row]
        cell.imgLogo.imageFromURL(urlString: data.url ?? "")
        cell.title.text  = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let last = tableView.numberOfRows(inSection: 0)-1
        let items =  result.count
        if last == indexPath.row && allTotal > items{
            page += 1
            tableView.showLoadingSpinner(with: "Fetch data...")
            getDataApi(page: page, size: size, isLoading: false)
        }
    }
}



