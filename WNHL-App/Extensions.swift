//
//  Extensions.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-04.
//

import Foundation
import Swift
import UIKit

// Put to parent view
extension UIViewController{
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 55, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
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
    
    // Function to give the view a special background colour dependent on the team that was selected.
    func getColorFromTeamId(teamNameString: String) -> UIColor{
        if teamNameString.caseInsensitiveCompare("Atlas Steelers")  == ComparisonResult.orderedSame{
            return UIColor(red: 200.0/255.0, green: 10.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Townline Tunnelers") == ComparisonResult.orderedSame{
            return UIColor.systemBlue
        }
        else if teamNameString.caseInsensitiveCompare("Crown Room Kings") == ComparisonResult.orderedSame{
            return UIColor.black
        }
        else if teamNameString.caseInsensitiveCompare("Dain City Dusters") == ComparisonResult.orderedSame{
            return UIColor.red
        }
        else if teamNameString.caseInsensitiveCompare("Lincoln Street Legends") == ComparisonResult.orderedSame{
            // This will allow the creation of custom colours through changing the numerators
            return UIColor(red: 10.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        }
        else if teamNameString.caseInsensitiveCompare("Merritt Islanders") == ComparisonResult.orderedSame{
            return UIColor.systemGray2
        }
        else{
            return UIColor.systemOrange
        }
    }
}


// extension will allow this to be an extension to all UITableViewControllers such that they can all use this function.
extension UITableViewController{
    // This function will return a string of the image set name given a string of a team name.
    func getImageNameFromTeamNameTable(teamName:String) -> String {
        // Each check of team name is case insensitive.
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
    
    func scheduleLocalTest() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let date = Date()
        let calendar = Calendar.current
        let hourValue = calendar.component(.hour, from: date)
        let minuteValue = calendar.component(.minute, from: date)
        var dateComponents = DateComponents()
        dateComponents.hour = hourValue
        dateComponents.minute = minuteValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func scheduleLocal(dateTimeString:String) {
       
        //let date = Date(timeIntervalSinceNow: 60) //Working Fine
        let date = convertStringToDate(dateStr: dateTimeString) //log 2018-10-20 10:11:00 +0000
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy some milk"
        content.sound = UNNotificationSound.default
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date) //log ▿ year: 2018 month: 10 day: 20 hour: 18 minute: 11 second: 0 isLeapMonth: false
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                // Something went wrong
                print(error)
            }
        })
    }
    
    func showLocationOnMaps(primaryContactFullAddress: String) {
        let testURL: NSURL = NSURL(string: "maps://maps.apple.com/?q=")!
        if UIApplication.shared.canOpenURL(testURL as URL) {
            if let address = primaryContactFullAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                let directionsRequest: String = "maps://maps.apple.com/?q=" + (address)
                let directionsURL: NSURL = NSURL(string: directionsRequest)!
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(directionsURL as URL)) {
                    application.open(directionsURL as URL, options: [:], completionHandler: nil)
                }
            }
        } else {
            NSLog("Can't open Apple Maps on this device")
        }
    }
    
    // This function will take the string given representing a Youtube Channel ID and use it to take the user to it
    func goToYoutubeChannel(youtubeChannelId:String) {
        // appURL is the url for the Youtube app in particular
        let appURL = NSURL(string: "youtube://www.youtube.com/channel/\(youtubeChannelId)")!
        // webURL is the url for initializing Youtube on the browser.
        let webURL = NSURL(string: "https://www.youtube.com/channel/\(youtubeChannelId)")!
        let application = UIApplication.shared
        // Check if the Youtube app can be opened first. This means the user has it installed already.
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }

    // This function will take the user to a Twitter account given the handle represented by a String
    func goToTwitterAccount(twitterUserID:String) {
        // appURL is the url for the Twitter app in particular
        let appURL = NSURL(string: "twitter://user?screen_name=\(twitterUserID)")!
        // webURL is the url for the browser variant of Twitter
        let webURL = NSURL(string: "https://twitter.com/\(twitterUserID)")!
        
        let application = UIApplication.shared
        
        // Try to open the Twitter app first if it is installed, otherwise if that fails, open the Twitter account on browser.
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }

    // This function will simply redirect the user to the Google Spreadsheet for WNHL Fantasy in browser.
    func goToFantasySpreadsheet(){
        let webURL = NSURL(string: "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ8bY-Of5YbJHk0VTj0LxWyQLYkK2dzWea-2fjd899X3qWMXGysbmE2UhqCdsFBLtJ233WjsGA_IMYJ/pubhtml?gid=0&single=true")!
        let application = UIApplication.shared
        application.open(webURL as URL)
    }
    
    func convertStringToDate(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current// (abbreviation: "GMT+0:00")
        let dateFromString = dateFormatter.date(from: dateStr)
        print("dateFromString: ", dateFromString!)
        return dateFromString!
    }

}

// This extension will allow all UITableViewCells, even the customs ones made, use the functions within
extension UITableViewCell {
    // This function simply toggles the selection style to be that of none so that there won't be a grey highlight on click.
    func noSelectionStyle() {
        self.selectionStyle = .none
    }
}
// Make all tables scroll

extension UIButton {
    
    private class Action {
        var action: (UIButton) -> Void
        
        init(action: @escaping (UIButton) -> Void) {
            self.action = action
        }
    }
    
    private struct AssociatedKeys {
        static var ActionTapped = "actionTapped"
    }
    
    private var tapAction: Action? {
        set { objc_setAssociatedObject(self, &AssociatedKeys.ActionTapped, newValue, .OBJC_ASSOCIATION_RETAIN) }
        get { return objc_getAssociatedObject(self, &AssociatedKeys.ActionTapped) as? Action }
    }
    
    
    @objc dynamic private func handleAction(_ recognizer: UIButton) {
        tapAction?.action(recognizer)
    }
    
    
    func mk_addTapHandler(action: @escaping (UIButton) -> Void) {
        self.addTarget(self, action: #selector(handleAction(_:)), for: .touchUpInside)
        tapAction = Action(action: action)
        
    }
}

extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            self.init(data: try Data(contentsOf: url))
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

extension NotificationsViewController:ChildToParentProtocol {
    
    func needToPassInfoToParent(with isNowChecked:Bool, teamNameString:String) {
        if isNowChecked{
            self.showToast(message: teamNameString + " Notifications ON", font: .systemFont(ofSize: 15.0))
        }
        else{
            self.showToast(message: teamNameString + " Notifications OFF", font: .systemFont(ofSize: 15.0))
        }
    }
}