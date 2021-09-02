//
//  ScheduleTableViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-24.
//

import UIKit

// View Controllers represent each screen, A basic screen is known as a View Controller but a view entirely devoted to say a TableView is a TableViewController. Thus this class is responsible for affecting strictly the table on the Schedule screen.
class ScheduleTableViewController: UITableViewController {
    
    // The cells are part of a table or collection. In this case it is of a table which is composed of multiple rows and populates downwards much like in the More and Teams page. Much like variables, they must have some identifier or name that is unique.
    let cellReuseIdentifier = "scheduleCell"
    // This is responsible for the height of the spacing between each row in pixels
    let cellSpacingHeight: CGFloat = 30
    @IBOutlet var ScheduleTableView: UITableView!
    // The value that dynamically builds the table is derived from the array here, if you can fetch data from the database and populate it here with the same formatting, then that will accomplish the data population as the rest of the UI formatting lies below.
    var dates: [String] = ["Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",
                           "Wed. Oct 7, 2020",]
    var points: [String] = ["2 - 2",
                            "2 - 2",
                            "2 - 2",
                            "2 - 2",
                            "2 - 2",]
    var locations: [String] = ["Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",
                               "Niagara Falls - Gale Center",]
    var teams1: [String] = ["Lincoln Street Legends",
                            "Dain City Dusters",
                            "Atlas Steelers",
                            "Crown Room Kings",
                            "Townline Tunnelers"]
    var teams2: [String] = ["BOI",
                            "Lincoln Street Legends",
                            "Atlas Steelers",
                            "Townline Tunnelers",
                            "Merritt Islanders",]
    
    // These are functions that act like attributes for the Table View. This responsible for the number of sections, for our purposes, all we need is 1
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dates.count
    }
    
    // There is just one row in every section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        let indexPath = ScheduleTableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!) as! ScheduleTableViewCell
        let alertTitle:String = String(currentCell.homeTeamLabel.text!) + " vs " + String(currentCell.awayTeamLabel.text!)
        // Team vs Team
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Directions", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Set Reminder", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // create a cell for each table view row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ScheduleTableViewCell is custom made by myself that has 2 image views one text label, highlighting and right clicking the ScheduleTableViewCell and jumping to Definition should display the outlets that the Custom cell class contains.
        // Think classes in Java, housing a bunch of elements repeatedly used in a singular class.
        let cell = self.ScheduleTableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        // Once the cell is fetched, modify it as needed
        // The imageViews and text labels were given unique identifiers being HomeImage and AwayImage for the images and scheduleText for the text label.
        cell.noSelectionStyle()
        cell.dateLabel.text = self.dates[indexPath.section]
        cell.dateLabel.font = UIFont.systemFont(ofSize: 15)
        cell.pointsLabel.text = self.points[indexPath.section]
        cell.pointsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cell.locationLabel.text = self.locations[indexPath.section]
        cell.locationLabel.font = UIFont.systemFont(ofSize: 15)
        cell.homeTeamLabel.text = self.teams1[indexPath.section]
        cell.homeTeamLabel.font = UIFont.systemFont(ofSize: 14)
        cell.awayTeamLabel.text = self.teams2[indexPath.section]
        cell.awayTeamLabel.font = UIFont.systemFont(ofSize: 14)
        
        cell.dateLabel.textAlignment = NSTextAlignment.center
        cell.pointsLabel.textAlignment = NSTextAlignment.center
        cell.locationLabel.textAlignment = NSTextAlignment.center
        cell.homeTeamLabel.textAlignment = NSTextAlignment.right
        cell.awayTeamLabel.textAlignment = NSTextAlignment.left
        
        cell.HomeImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams1[indexPath.section]))
        cell.AwayImage.image = UIImage(named: getImageNameFromTeamNameTable(teamName: self.teams2[indexPath.section]))
        
        cell.backgroundColor = UIColor.white
        cell.layer.borderWidth = 0
        cell.layer.cornerRadius = 24
        cell.clipsToBounds = true
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

// This is how you make a function header in Swift
// func methodName(parameterNAme:Type) -> return Type
extension UITableViewController{
    func getImageNameFromTeamNameTable(teamName:String) -> String {
        if teamName.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return "steelers_logo"
        }
        else if teamName.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return "townline_logo"
        }
        else if teamName.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return "crownRoom_logo"
        }
        else if teamName.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return "dusters_logo"
        }
        else if teamName.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            return "legends_logo"
        }
        else if teamName.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return "islanders_logo"
        }
        else{
            return "WNHL_Logo"
        }
    }
}

extension UIViewController{
    func getImageNameFromTeamName(teamName:String) -> String {
        if teamName.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return "steelers_logo"
        }
        else if teamName.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return "townline_logo"
        }
        else if teamName.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return "crownRoom_logo"
        }
        else if teamName.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return "dusters_logo"
        }
        else if teamName.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            return "legends_logo"
        }
        else if teamName.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return "islanders_logo"
        }
        else{
            return "WNHL_Logo"
        }
    }
}



extension UITableViewCell {
    func noSelectionStyle() {
        self.selectionStyle = .none
    }
}
