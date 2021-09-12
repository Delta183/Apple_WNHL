//
//  StatisticsSpreadsheetViewController.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-08-26.
//

import UIKit
import SQLite

// This class will create and populate the spreadsheets for the Statistics View
class StatisticsSpreadsheetViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet var GoalsCollectionView: UICollectionView?
    @IBOutlet var AssistsCollectionView: UICollectionView?
    @IBOutlet var PointsCollectionView: UICollectionView?
    @IBOutlet var headerCollectionView1: UICollectionView!
    @IBOutlet var headerCollectionView2: UICollectionView!
    @IBOutlet var headerCollectionView3: UICollectionView!
    var reuseIdentifier1 = "goalsCell"
    var reuseIdentifier2 = "assistsCell"
    var reuseIdentifier3 = "pointsCell"
    var reuseIdentifierHeader1 = "headerCell1"
    var reuseIdentifierHeader2 = "headerCell2"
    var reuseIdentifierHeader3 = "headerCell3"
    var fontSize:CGFloat!


    var headerItems1 = ["Rank","Player","Team","G"]
    var headerItems2 = ["Rank","Player","Team","A"]
    var headerItems3 = ["Rank","Player","Team","P"]

    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let players = Table("Players")
    let name = Expression<String>("name")
    let currTeam = Expression<Int64>("currTeam")
    let goal = Expression<Int64>("goals")
    let assist = Expression<Int64>("assists")
    let point = Expression<Int64>("points")
    // The 3 arrays are for the Goals, Assists and Points spreadsheets respectively.
    var goals: [String] = []
    var assists: [String] = []
    var points: [String] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == GoalsCollectionView{
            return self.goals.count
        }
        else if collectionView == AssistsCollectionView{
            return self.assists.count
        }
        else if collectionView == PointsCollectionView{
            return self.points.count
        }
        else{
            return self.headerItems1.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let containerWidth = view.frame.size.width
        // Max width of this component is 374
        var cellWidth:CGFloat = CGFloat()
        // Rank Column 45
        if indexPath.row == 0 || ((indexPath.row) % 4) == 0 {
            cellWidth = containerWidth * 0.1203
        }
        // Player Column 140
        else if indexPath.row == 1 || ((indexPath.row - 1) % 4) == 0 {
            cellWidth = containerWidth * 0.374
        }
        // Team Column 155
        else if indexPath.row == 2 || ((indexPath.row - 2) % 4) == 0{
            cellWidth = containerWidth * 0.414
        }
        // 4th column 34
        else{
            cellWidth = containerWidth * 0.09
        }
        return CGSize(width: cellWidth, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if screenSize.width < 414 {
            fontSize = 10
        }
        else{
            fontSize = 12
        }
        if collectionView == self.GoalsCollectionView {
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier1, for: indexPath as IndexPath) as! GoalsCollectionViewCell
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.dataLabel1.text = self.goals[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell.dataLabel1.font = UIFont.systemFont(ofSize: fontSize)

            return cell
        }
        else if collectionView == self.AssistsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier2, for: indexPath as IndexPath) as! AssistsCollectionViewCell
            cell.dataLabel2.text = self.assists[indexPath.row]
            cell.dataLabel2.font = UIFont.systemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.PointsCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier3, for: indexPath as IndexPath) as! PointsCollectionViewCell
            cell.dataLabel3.text = self.points[indexPath.row]
            cell.dataLabel3.font = UIFont.systemFont(ofSize: fontSize)

            return cell
        }
        // This is responsible for the headers
        else if collectionView == self.headerCollectionView1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierHeader1, for: indexPath as IndexPath) as! headerGoals
            cell.headerLabel.text = self.headerItems1[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
        else if collectionView == self.headerCollectionView2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierHeader2, for: indexPath as IndexPath) as! headerAssists
            cell.headerLabel.text = self.headerItems2[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierHeader3, for: indexPath as IndexPath) as! headerPoints
            cell.headerLabel.text = self.headerItems3[indexPath.row]
            cell.headerLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            return cell
        }
    }
    
    func getGoals(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(goal)
            
            var count = try! db.scalar(sortedPlayers.count)
        
            for player in try db.prepare(sortedPlayers) {
                goals.append(String(player[goal]))
                goals.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                goals.append(player[name])
                goals.append(String(count))
                count-=1
            }
            goals.reverse()
        }
        catch {
            print(error)
        }
    }
    
    func getAssists(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(assist)
            
            var count = try! db.scalar(sortedPlayers.count)
            
            for player in try db.prepare(sortedPlayers) {
                assists.append(String(player[assist]))
                assists.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                assists.append(player[name])
                assists.append(String(count))
                count-=1
            }
            assists.reverse()
        }
        catch {
            print(error)
        }
    }
    
    func getPoints(){
        do {
            let db = try Connection("\(path)/wnhl.sqlite3")
            
            let sortedPlayers = Table("Players").order(point)
            
            var count = try! db.scalar(sortedPlayers.count)
            
            for player in try db.prepare(sortedPlayers) {
                points.append(String(player[point]))
                points.append(getTeamNameFromTeamId(teamId: player[currTeam]))
                points.append(player[name])
                points.append(String(count))
                count-=1
            }
            points.reverse()
        }
        catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        // Populate the arrays with the pertinent data
        getGoals()
        getAssists()
        getPoints()
        super.viewDidLoad()
        GoalsCollectionView?.delegate = self;
        GoalsCollectionView?.dataSource = self;
        AssistsCollectionView?.delegate = self;
        AssistsCollectionView?.dataSource = self;
        PointsCollectionView?.delegate = self;
        PointsCollectionView?.dataSource = self;
        headerCollectionView1?.delegate = self;
        headerCollectionView1?.dataSource = self;
        headerCollectionView2?.delegate = self;
        headerCollectionView2?.dataSource = self;
        headerCollectionView3?.delegate = self;
        headerCollectionView3?.dataSource = self;
    }
}
