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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        PhotoService.retrievePhotos { (retrievedPhotos) in
            
            self.photos = retrievedPhotos
            self.tableView.reloadData()
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.photoCellId, for: indexPath) as? PhotoCell
        
        let photo = self.photos[indexPath.row]
        
        cell?.displayPhoto(photo: photo)
        
        return cell!
    }
}


