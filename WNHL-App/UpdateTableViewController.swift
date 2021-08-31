//
//  UpdateTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit

class UpdateTableViewController: UITableViewController {
    
    @IBOutlet var UpdateTableView: UITableView!
    var reuseIdentifier = "updateTableCell"
    var categories = ["PLAYERS","GAME SCHEDULE","TEAMS","STANDINGS","EVERYTHING",]
    var iconNames = ["person.fill", "calendar", "play.circle", "chart.bar.xaxis", "square.and.arrow.down",]


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UpdateTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UpdateTableViewCell
        cell.noSelectionStyle()
        cell.updateLabel.text = categories[indexPath.row]
        cell.updateLabel.textColor = UIColor.white
        cell.updateLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        cell.iconImage.image = UIImage(systemName: iconNames[indexPath.row])
        cell.iconImage.tintColor = UIColor.white
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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