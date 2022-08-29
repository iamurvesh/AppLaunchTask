//
//  Extension.swift
//  UrveshMishraTask
//
//  Created by Urvesh Mishra on 26/08/22.
//

import Foundation
import UIKit

// MARK:-
extension UIViewController  {
    
    var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    // Display Alert Message
    func showAlert(_ title: String,
                   message: String,
                   actions:[UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)]) {

            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            for action in actions {
                alert.addAction(action)
            }

            self.present(alert, animated: true, completion: nil)
    }
        
}


// MARK:-
extension UITableView {
    func EmptyMessage(message:String) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width, height: self.frame.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func registerCell(withNib reuseIdentifier:String) {
        self.register(UINib(nibName: reuseIdentifier, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
}

extension String {
    
    func getUTCToLocalDateFromString(format: String,conevertString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        let utcdate = dateFormatter.date(from: self) ?? Date()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = conevertString
        
        return dateFormatter.string(from: utcdate)
    }
    
    func getDateFromString(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self) ?? Date()
    }
    
    
}

extension Date{
    func removeTimeStampFromDate() -> Date {
        
        var dateComponents = Calendar.current.dateComponents([.year,.month,.day], from: self)
        
        dateComponents.timeZone = TimeZone(identifier: TimeZone.current.abbreviation() ?? "GMT")
        dateComponents.minute = 0
        dateComponents.hour = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}
