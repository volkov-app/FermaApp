//
//  infoTableViewController.swift
//  GrigGroupeApp
//
//  Created by user183382 on 11/6/20.
//

import UIKit

class infoTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var images: [UIImage] = [#imageLiteral(resourceName: "1.JPG"),#imageLiteral(resourceName: "2.JPG"),#imageLiteral(resourceName: "3.JPG"),#imageLiteral(resourceName: "4.JPG"),#imageLiteral(resourceName: "5.JPG"),#imageLiteral(resourceName: "6.JPG"),#imageLiteral(resourceName: "7.JPG"),#imageLiteral(resourceName: "8.JPG"),#imageLiteral(resourceName: "9.JPG"),#imageLiteral(resourceName: "10.JPG"),#imageLiteral(resourceName: "11.JPG")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        cell.image.image = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
        imageView.image = images[indexPath.row] // Your image here...
        showAlert.view.addSubview(imageView)
        let height = NSLayoutConstraint(item: showAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 320)
        let width = NSLayoutConstraint(item: showAlert.view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
        showAlert.view.addConstraint(height)
        showAlert.view.addConstraint(width)
        showAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // your actions here...
        }))
        self.present(showAlert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func insta(_ sender: UIButton) {
        guard let url = URL(string: "https://instagram.com/ferma_restaurant") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func tripAdvisor(_ sender: UIButton) {
        guard let url = URL(string: "https://www.tripadvisor.ru/Restaurant_Review-g1602418-d12543802-Reviews-Ferma-Serpukhov_Moscow_Oblast_Central_Russia.html") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func vk(_ sender: UIButton) {
        guard let url = URL(string: "https://vk.com/restaurant_ferma") else { return }
        UIApplication.shared.open(url)
    }
    // MARK: - Table view data source

//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Configure the cell...
//
//        return cell
//    }
//    
//
//    
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
