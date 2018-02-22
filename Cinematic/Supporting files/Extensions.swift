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
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let fullFormatter = DateFormatter()
        fullFormatter.dateFormat = "dd-MMM-yyyy"
        let startDate: Date = fullFormatter.date(from: startDate)!
        var dates = [String]()
        var daysLeft = Int()
        
        if today >= startDate {
            
            let components = Calendar.current.dateComponents([.year, .month, .day], from: startDate, to: yesterday)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day]
            var numOfDays: String = formatter.string(from: components)!
            numOfDays.remove(at: numOfDays.index(before: numOfDays.endIndex))
            daysLeft = (7 * numberOfWeeks) - Int(numOfDays)!
                        
            if daysLeft > 0 {
                
                for day in 1..<daysLeft {
                    let date: Date = Calendar.current.date(byAdding: .day, value: day, to: yesterday)!
                    dates.append(fullFormatter.string(from: date))
                }
            }
            
            return dates

        } else {
            daysLeft = (7 * numberOfWeeks)
            
            for day in 1...daysLeft {
                let date: Date = Calendar.current.date(byAdding: .day, value: day, to: startDate)!
                dates.append(fullFormatter.string(from: date))
            }
            return dates
        }
    }
    
    func dayAndMonthFormat(date: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let dayMonth = formatter.date(from: date)
        
        let dayMonthFormatter = DateFormatter()
        dayMonthFormatter.dateFormat = "dd MMM"
        
        return dayMonthFormatter.string(from: dayMonth!)
    }
    
    func isTodayInBetweenStartDateAndEndDate(startDate: String, endDate: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        
        let sDate = formatter.date(from: startDate)!
        let eDate = formatter.date(from: endDate)!
        
        // adding one day to end date since the date is on thursday
        let eDatePlusOne = Calendar.current.date(byAdding: .day, value: 1, to: eDate)!
        let today = Date()
        
        if sDate < today && today < eDatePlusOne {
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
    
    func isEndDateMoreThanToday(startDate: String, numOfWeek: Int) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        
        let sDate = dateFormatter.date(from: startDate)!
        let eDate = Calendar.current.date(byAdding: .day, value: (7*numOfWeek), to: sDate)!
        let today = Date()
        
        if today < eDate {
            return true
        } else {
            return false
        }
    }
    
    func todayDateInString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return dateFormatter.string(from: Date())
    }
    
    func fullDateFromString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        let fullDateFormatter = DateFormatter()
        fullDateFormatter.dateFormat = "dd-MMM-yyyy HH:mm"
        
        let fDate = dateFormatter.date(from: date)!

        return fullDateFormatter.string(from: fDate)
    }
}
