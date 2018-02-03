//
//  Extensions.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 28/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import Foundation

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension Date {
    func daysFromStartDate(startDate: String, numberOfWeeks: Int) -> [String] {
        let today = Date()
        let fullFormatter = DateFormatter()
        fullFormatter.dateFormat = "dd-MMM-yyyy"
        let dayMonthFormatter = DateFormatter()
        dayMonthFormatter.dateFormat = "dd MMM"
        let startDate: Date = fullFormatter.date(from: startDate)!
        var dates = [String]()
        var daysLeft = Int()
        
        if today >= startDate {
            
            let components = Calendar.current.dateComponents([.year, .month, .day], from: startDate, to: today)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day]
            var numOfDays: String = formatter.string(from: components)!
            numOfDays.remove(at: numOfDays.index(before: numOfDays.endIndex))
            daysLeft = (7 * numberOfWeeks) - Int(numOfDays)! - 1
            
            if daysLeft > 0 {
                
                for day in 0...daysLeft {
                    let date: Date = Calendar.current.date(byAdding: .day, value: day, to: today)!
                    dates.append(dayMonthFormatter.string(from: date))
                }
            }
            
            return dates

        } else {
            daysLeft = (7 * numberOfWeeks) - 1
            
            for day in 0...daysLeft {
                let date: Date = Calendar.current.date(byAdding: .day, value: day, to: startDate)!
                dates.append(dayMonthFormatter.string(from: date))
            }
            return dates
        }
    }
    
    func isTodayInBetweenStartDateAndEndDate(startDate: String, endDate: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let sDate = formatter.date(from: startDate)!
        let eDate = formatter.date(from: endDate)!
        let today = Date()
        
        if sDate < today && today < eDate {
            return true
        } else {
            return false
        }
    }
    
    func isStartDateIsGreaterThanNextFriday(startDate: String) -> Bool {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let sDate = formatter.date(from: startDate)!

        var components = DateComponents()
        components.weekday = 6
        
        let friday =  Calendar.current.nextDate(after: Date(),
                                                matching: components,
                                                matchingPolicy:.nextTime)!
        
        if sDate == friday || sDate > friday {
            return true
        } else {
            return false
        }
    }
}
