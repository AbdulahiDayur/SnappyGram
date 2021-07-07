//
//  FeedViewController.swift
//  SnappyGram
//
//  Created by Abdul Dayur on 6/25/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            self.photos = retrievedPhotos
            
            self.tableView.reloadData()
        }
    }
    

}
