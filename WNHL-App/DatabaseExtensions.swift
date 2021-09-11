//
//  DatabaseExtensions.swift
//  WNHL-App
//
//  Created by Daniel Figueroa on 2021-09-09.
//

import Foundation
import Swift
import UIKit
import SQLite

extension UITableViewController{
    
    // This function will return a string of the image set name given a string of a team name.
    func getImageNameFromTeamId(teamId:Int) -> String {
        // Each check of team name is case insensitive.
        if teamId == 940{
            return "steelers_logo"
        }
        else if teamId == 1370{
            return "townline_logo"
        }
        else if teamId == 1371{
            return "crownRoom_logo"
        }
        else if teamId == 1810{
            return "dusters_logo"
        }
        else if teamId == 1822{
            return "legends_logo"
        }
        else if teamId == 1824{
            return "islanders_logo"
        }
        else{
            return "WNHL_Logo"
        }
    }
    
    
    func getLocationNameFromId(locationId:Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            //Column Names
            //Table Column Names
            let id = Expression<Int64>("id")
            let name = Expression<String>("name")
            //Table Names
            let venues = Table("Venues")
            // This is the more complex query
            // SELECT name WHERE id == locationId
            for venue in try db.prepare(venues.select(name).filter(id == locationId)){
                return ("\(venue[name])")
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
   
    func getGameDateString(gameId: Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let date = Expression<String>("date")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(date).filter(id == gameId)){
                return game[date]
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getGameTimeString(gameId: Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let time = Expression<String>("time")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(time).filter(id == gameId)){
                return game[time]
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getGameScoreString(gameId: Int64) -> String {
        var returnstring = ""
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let homeScore = Expression<Int64?>("homeScore")
            let awayScore = Expression<Int64?>("awayScore")
            var hScore = 0 as Int64
            var aScore = 0 as Int64
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(homeScore).filter(id == gameId)){
                hScore = game[homeScore] ?? -1
                if hScore > -1 {
                    returnstring.append(String(hScore))
                    returnstring.append("  -  ")
                }
            }
            for game in try db.prepare(games.select(awayScore).filter(id == gameId)){
                aScore = game[awayScore] ?? -1
                if aScore > -1 {
                    returnstring.append(String(aScore))
                }
            }
            if returnstring != "" {
                return returnstring
            }
        }
        catch {
            print(error)
        }
        return "No Score Available"
    }
    
    func getHomeIdFromGameId(gameId:Int64) -> Int {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let home = Expression<Int64>("home")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(home).filter(id == gameId)){
                return Int(game[home])
            }
        }
        catch {
            print(error)
        }
        return 0
    }
    
    func getAwayIdFromGameId(gameId:Int64) -> Int {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let away = Expression<Int64>("away")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(away).filter(id == gameId)){
                return Int(game[away])
            }
        }
        catch {
            print(error)
        }
        return 0
    }
    
    func getTitleFromGameId(gameId:Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(title).filter(id == gameId)){
                return ("\(game[title])")
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getLocationIdFromGameId(gameId:Int64) -> Int64 {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let location = Expression<Int64>("location")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(location).filter(id == gameId)){
                return (game[location])
            }
        }
        catch {
            print(error)
        }
        return 0
    }
    
    func getDateStringFromTeamId(gameId:Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let date = Expression<String>("date")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(date).filter(id == gameId)){
                return ("\(game[date])")
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getTimeStringFromTeamId(gameId:Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let time = Expression<String>("time")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(time).filter(id == gameId)){
                return ("\(game[time])")
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getFullDateTimeStringFromTeamId(gameId:Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let time = Expression<String>("time")
            let date = Expression<String>("date")
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(date, time).filter(id == gameId)){
                return ("\(game[date]) \(game[time])")
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
    
    func getTeamsFromSeasonId(seasonIdString:String) -> [String] {
        var teamArray:[String] = []
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let slug = Expression<String>("slug")
            let seasonID = Expression<String>("seasonID")
            //Table Names
            let teams = Table("Teams")
            for team in try db.prepare(teams.select(slug).filter(seasonID.like("%" + seasonIdString + "%"))){
                teamArray.append("\(team[slug])")
            }
        }
        catch {
            print(error)
        }
        return teamArray
    }
    
    func getTeamIdFromTeamName(teamName:String) -> Int64 {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let slug = Expression<String>("slug")
            let id = Expression<Int64>("id")
            //Table Names
            let teams = Table("Teams")
            for team in try db.prepare(teams.select(id).filter(slug == teamName)){
                return(team[id])
            }
        }
        catch {
            print(error)
        }
        return 0
    }
    
    func getAllGameIdsFromTeamId(teamId:Int64) -> [Int64]{
        var gameIdList:[Int64] = []
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let id = Expression<Int64>("id")
            let home = Expression<Int64>("home")
            let away = Expression<Int64>("away")
            
            //Table Names
            let games = Table("Games")
            for game in try db.prepare(games.select(id).filter(away == teamId || home == teamId)){
                gameIdList.append(game[id])
            }
        }
        catch {
            print(error)
        }
        return gameIdList
    }
    
    func scheduleAllTeamGames(idList:[Int64]){
      
        for n in 0..<idList.count {
            // For all the games in the idList, schedule them, they will be overwritten if they are already set
            scheduleLocal(dateTimeString: getFullDateTimeStringFromTeamId(gameId: idList[n]), notificationId: String(idList[n]))
        }
    }
    
    func deleteAllNotificationsOfTeamGames(idList:[Int64]){
        let defaults = UserDefaults.standard
        for n in 0..<idList.count {
            // For all the games in the idList, schedule them, they will be overwritten if they are already set
            deleteNotification(notificationId: String(idList[n]))
            defaults.setValue(false, forKey: String(idList[n]))

        }
        updateScheduledGamesFromPreferences()
    }
    
    // This function checks all the user defaults for the teams
    func updateScheduledGamesFromPreferences(){
        let defaults = UserDefaults.standard
        let teams = getTeamsFromSeasonId(seasonIdString: "34")
        for n in 0..<teams.count {
            if defaults.bool(forKey: teams[n]){
                let teamId = getTeamIdFromTeamName(teamName: teams[n])
                let gameIdList = getAllGameIdsFromTeamId(teamId: teamId)
                scheduleAllTeamGames(idList: gameIdList)
            }
        }
    }
}

extension UIViewController {
    func getTeamNameFromTeamId(teamId: Int64) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        do{
            let db = try Connection("\(path)/wnhl.sqlite3")
            let name = Expression<String>("name")
            let id = Expression<Int64>("id")
            //Table Names
            let teams = Table("Teams")
            for team in try db.prepare(teams.select(name).filter(id == teamId)){
                return(team[name])
            }
        }
        catch {
            print(error)
        }
        return "N/A"
    }
}
